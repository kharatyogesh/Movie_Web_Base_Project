package org.techhub.repository;

import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import org.springframework.jdbc.core.RowMapper;

import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.EmptyResultDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.techhub.model.ActorModel;
import org.techhub.model.GenreMasterModel;
import org.techhub.model.MovieDetail;
import org.techhub.model.MovieMasterModel;

@Repository("movieRepo")
public class MovieRepositoryImpl implements MovieRepository {

	@Autowired
	JdbcTemplate template;
	
	List<GenreMasterModel> list;
	
	@Override
	public Integer getMaxMovieId() {
	    // Fetch the maximum movie ID from the database, default to 0 if not found
	    Integer maxMovieId = template.queryForObject(
	        "SELECT COALESCE(MAX(mov_id), 0) FROM moviemaster",
	        Integer.class
	    );
	    return maxMovieId != null ? maxMovieId : 0;
	}


	public boolean isAddNewMovie(MovieMasterModel model) {
	    // Check the release date
	    String dateString = model.getMovDate();
	    if (dateString == null || dateString.isEmpty()) {
	        throw new IllegalArgumentException("Movie release date cannot be null or empty");
	    }

	    LocalDate parsedDate;
	    try {
	        parsedDate = LocalDate.parse(dateString);
	    } catch (DateTimeParseException e) {
	        throw new IllegalArgumentException("Invalid date format: " + dateString, e);
	    }

	    Date sqlDate = Date.valueOf(parsedDate);

	    // Fetch the maximum movie ID and set the new movie ID
	    Integer maxMovieId = getMaxMovieId();
	    int newMovieId = maxMovieId + 1;
	    model.setMovieId(newMovieId);

	    // Insert the movie
	    String insertMovieQuery = "INSERT INTO moviemaster (mov_id, mov_title, mov_rel_date) VALUES (?, ?, ?)";
	    int movieInsertResult = template.update(insertMovieQuery, newMovieId, model.getMovTitle(), sqlDate);

	    if (movieInsertResult > 0) {
	        Integer genId = null;
	        try {
	            genId = template.queryForObject(
	                "SELECT gen_id FROM genres WHERE gen_name = ?",
	                Integer.class,
	                model.getGenName()
	            );
	        } catch (EmptyResultDataAccessException e) {
	            // Insert new genre if it does not exist
	            String insertGenreQuery = "INSERT INTO genres (gen_name) VALUES (?)";
	            template.update(insertGenreQuery, model.getGenName());

	            genId = template.queryForObject(
	                "SELECT gen_id FROM genres WHERE gen_name = ?",
	                Integer.class,
	                model.getGenName()
	            );
	        }

	        Integer actId = null;
	        try {
	            actId = template.queryForObject(
	                "SELECT act_id FROM actor WHERE act_name = ?",
	                Integer.class,
	                model.getActName()
	            );
	        } catch (EmptyResultDataAccessException e) {
	            // Insert new actor if it does not exist
	            String insertActorQuery = "INSERT INTO actor (act_name) VALUES (?)";
	            template.update(insertActorQuery, model.getActName());

	            actId = template.queryForObject(
	                "SELECT act_id FROM actor WHERE act_name = ?",
	                Integer.class,
	                model.getActName()
	            );
	        }

	        // Insert into moviegenreactorjoin table
	        String insertJoinQuery = "INSERT INTO moviegenreactorjoin (mov_id, gen_id, act_id) VALUES (?, ?, ?)";
	        int joinInsertResult = template.update(insertJoinQuery, newMovieId, genId, actId);

	        if (joinInsertResult > 0) {
	            return true;
	        } else {
	            throw new IllegalStateException("Failed to insert into moviegenreactorjoin table");
	        }
	    }

	    return false;
	}





	@Override
	public List<MovieMasterModel> getMovieList() {
		
	    String sql = "select m.mov_id, m.mov_title, m.mov_rel_date, g.gen_name,a.act_name from moviemaster m join moviegenreactorjoin mj ON m.mov_id = mj.mov_id join genres g ON mj.gen_id = g.gen_id join actor a on mj.act_id=a.act_id order by m.mov_id asc";

	        return template.query(sql, new RowMapper<MovieMasterModel>() {
	            @Override
	            public MovieMasterModel mapRow(ResultSet rs, int rowNum) throws SQLException {
	            	MovieMasterModel m = new MovieMasterModel();
	                m.setMovieId(rs.getInt("mov_id")); // Assuming "genId" is the column name
	                m.setMovTitle(rs.getString("mov_title"));
	                m.setMovDate(rs.getDate("mov_rel_date").toString());
	                m.setGenName(rs.getString("gen_name")); // Assuming "genName" is the column name
	                m.setActName(rs.getString("act_name"));
	                return m;
	            }
	        });
	}

	@Override
	public void isDeleteMovieById(int movid) {
		
		template.update("delete from moviemaster where mov_id="+movid);
	}
	public List<MovieMasterModel> searchMovies(String movieTitle, String movieGenre, String yearFrom, String yearTo,String movieActor) {
	 //   StringBuilder sql = new StringBuilder("SELECT m.mov_id, m.mov_title, m.mov_rel_date, g.gen_name FROM moviemaster m JOIN moviegenrejoin mj ON m.mov_id = mj.mov_id JOIN genres g ON mj.gen_id = g.gen_id WHERE 1=1");
	  
	    StringBuilder sql = new StringBuilder("select m.mov_id, m.mov_title, m.mov_rel_date, g.gen_name,a.act_name FROM moviemaster m JOIN moviegenreactorjoin mj ON m.mov_id = mj.mov_id JOIN genres g ON mj.gen_id = g.gen_id join actor a on mj.act_id=a.act_id WHERE 1=1");

		List<Object> params = new ArrayList<>();

	    if (movieTitle != null && !movieTitle.isEmpty()) {
	        sql.append(" AND m.mov_title LIKE ?");
	        params.add("%" + movieTitle + "%");
	    }
	    if (movieGenre != null && !movieGenre.isEmpty()) {
	        sql.append(" AND g.gen_name LIKE ?");
	        params.add("%" + movieGenre + "%");
	    }
	    if (yearFrom != null && !yearFrom.isEmpty()) {
	        sql.append(" AND m.mov_rel_date >= ?");
	        params.add(java.sql.Date.valueOf(yearFrom));
	    }
	    if (yearTo != null && !yearTo.isEmpty()) {
	        sql.append(" AND m.mov_rel_date <= ?");
	        params.add(java.sql.Date.valueOf(yearTo));
	    }
	    if (movieActor != null && !movieActor.isEmpty()) {
	        sql.append(" AND a.act_name LIKE ?");
	        params.add("%" + movieActor + "%");
	    }

	    return template.query(sql.toString(), params.toArray(), new MovieRowMapper());
	}

	
	private static class MovieRowMapper implements RowMapper<MovieMasterModel> {
	    @Override
	    public MovieMasterModel mapRow(ResultSet rs, int rowNum) throws SQLException {
	        MovieMasterModel movie = new MovieMasterModel();
	        
	        movie.setMovieId(rs.getInt("mov_id"));
	        movie.setMovTitle(rs.getString("mov_title"));
	        movie.setGenName(rs.getString("gen_name"));
	        movie.setMovDate(rs.getDate("mov_rel_date").toString()); 
	        movie.setActName(rs.getString("act_name"));
	        return movie;
	    }
	}


	@Override
	public MovieMasterModel getMovieById(int movieId) {
	    String sql = "select m.mov_id AS movieId, m.mov_title AS movTitle, m.mov_rel_date AS movDate, g.gen_name AS genName, a.act_name AS actName " +
	                 "FROM moviemaster m " +
	                 "JOIN moviegenreactorjoin mg ON m.mov_id = mg.mov_id " +
	                 "JOIN genres g ON mg.gen_id = g.gen_id " +
	                 "JOIN actor a ON mg.act_id = a.act_id " +
	                 "WHERE m.mov_id = ?";

	    return template.queryForObject(sql, new Object[]{movieId}, (rs, rowNum) -> {
	        MovieMasterModel movie = new MovieMasterModel();
	        movie.setMovieId(rs.getInt("movieId"));        
	        movie.setMovTitle(rs.getString("movTitle"));   
	        movie.setMovDate(rs.getDate("movDate").toString());  
	        movie.setGenName(rs.getString("genName")); 
	        movie.setActName(rs.getString("actName"));  // Corrected the column name
	        return movie;
	    });
	}

//	@Override
//	public void updateMovie(MovieMasterModel movie) {
//	    // Fetch the genre ID(s) based on the genre name
//	    String getGenreIdSql = "SELECT gen_id FROM genres WHERE gen_name = ?";
//	    List<Integer> genreIds = template.queryForList(getGenreIdSql, new Object[] { movie.getGenName() }, Integer.class);
//
//	    // Fetch the actor ID(s) based on the actor name
//	    String getActorIdSql = "SELECT act_id FROM actor WHERE act_name = ?";
//	    List<Integer> actorIds = template.queryForList(getActorIdSql, new Object[] { movie.getActName() }, Integer.class);
//
//	    // Check if the lists are empty and handle the error or provide default behavior
//	    if (genreIds.isEmpty()) {
//	        throw new IllegalArgumentException("No genre found with the name: " + movie.getGenName());
//	    }
//	    if (actorIds.isEmpty()) {
//	        // Handle the missing actor case: you could either throw an exception or handle it differently
//	        throw new IllegalArgumentException("No actor found with the name: " + movie.getActName());
//	    }
//
//	    // Use the first genre and actor ID (assuming there's only one)
//	    int genreId = genreIds.get(0);
//	    int actorId = actorIds.get(0);
//
//	    // Update the movie-genre-actor join table
//	    String genreActorJoinUpdateSql = "UPDATE moviegenreactorjoin SET gen_id = ?, act_id = ? WHERE mov_id = ?";
//	    template.update(genreActorJoinUpdateSql, genreId, actorId, movie.getMovieId());
//	}
	@Override
	public void updateMovie(MovieMasterModel movie) {

	    String getGenreIdSql = "SELECT gen_id FROM genres WHERE gen_name = ?";
	    Integer genreId = null;
	    try {
	        genreId = template.queryForObject(getGenreIdSql, new Object[] { movie.getGenName() }, Integer.class);
	    } catch (EmptyResultDataAccessException e) {
	     
	        String insertGenreSql = "INSERT INTO genres (gen_name) VALUES (?)";
	        template.update(insertGenreSql, movie.getGenName());

	  
	        genreId = template.queryForObject(getGenreIdSql, new Object[] { movie.getGenName() }, Integer.class);
	    }

	   
	    String getActorIdSql = "SELECT act_id FROM actor WHERE act_name = ?";
	    Integer actorId = null;
	    try {
	        actorId = template.queryForObject(getActorIdSql, new Object[] { movie.getActName() }, Integer.class);
	    } catch (EmptyResultDataAccessException e) {
	      
	        String insertActorSql = "INSERT INTO actor (act_name) VALUES (?)";
	        template.update(insertActorSql, movie.getActName());

	       
	        actorId = template.queryForObject(getActorIdSql, new Object[] { movie.getActName() }, Integer.class);
	    }

	
	    String genreActorJoinUpdateSql = "UPDATE moviegenreactorjoin SET gen_id = ?, act_id = ? WHERE mov_id = ?";
	    template.update(genreActorJoinUpdateSql, genreId, actorId, movie.getMovieId());
	}

	@Override
	public MovieMasterModel findByName(String movieName) {
	    String sql = "SELECT m.mov_id AS movieId, m.mov_title AS movTitle, m.mov_rel_date AS movDate, g.gen_name AS genName, a.act_name AS actName " +
	                 "FROM moviemaster m " +
	                 "JOIN moviegenreactorjoin mg ON m.mov_id = mg.mov_id " +
	                 "JOIN genres g ON mg.gen_id = g.gen_id " +
	                 "JOIN actor a ON mg.act_id = a.act_id " +
	                 "WHERE m.mov_title = ?";

	    try {
	        return template.queryForObject(sql, new Object[]{movieName}, (rs, rowNum) -> {
	            MovieMasterModel movie = new MovieMasterModel();
	            movie.setMovieId(rs.getInt("movieId"));        
	            movie.setMovTitle(rs.getString("movTitle"));   
	            movie.setMovDate(rs.getDate("movDate").toString());  
	            movie.setGenName(rs.getString("genName")); 
	            movie.setActName(rs.getString("actName"));  // Corrected the column name
	            return movie;
	        });
	    } catch (EmptyResultDataAccessException e) {
	        // Handle the case where no movie was found with the given name
	        return null; // or throw a custom exception if needed
	    }
	}

	public List<MovieMasterModel> getWatchedMoviesByUser(int userId) {
	    String query = "SELECT m.mov_id, m.mov_title, m.mov_rel_date, g.gen_name, a.act_name " +
	                   "FROM rating r " +
	                   "JOIN moviemaster m ON r.mov_id = m.mov_id " +
	                   "JOIN moviegenreactorjoin j ON m.mov_id = j.mov_id " +
	                   "JOIN genres g ON j.gen_id = g.gen_id " +
	                   "JOIN actor a ON j.act_id = a.act_id " +
	                   "WHERE r.u_id = ?";
	    List<MovieMasterModel> movies = template.query(query, new Object[]{userId}, new RowMapper<MovieMasterModel>() {
	        @Override
	        public MovieMasterModel mapRow(ResultSet rs, int rowNum) throws SQLException {
	            MovieMasterModel movie = new MovieMasterModel();
	            movie.setMovieId(rs.getInt("mov_id"));
	            movie.setMovTitle(rs.getString("mov_title"));
	            movie.setMovDate(rs.getDate("mov_rel_date").toString());
	            movie.setGenName(rs.getString("gen_name"));
	            movie.setActName(rs.getString("act_name"));
	            return movie;
	        }
	    });
	    System.out.println("Fetched movies: " + movies); // Debugging line
	    return movies;
	}

	@Override
	public List<MovieDetail> getTopRatedMovies() {
	 
	    String query = "SELECT m.mov_id, m.mov_title, m.mov_rel_date AS release_date, " +
	                   "g.gen_name AS genre, a.act_name AS actor, " +
	                   "(SUM(r.rating) / COUNT(r.u_id)) AS overall_rating, COUNT(r.u_id) AS user_count " +
	                   "FROM rating r " +
	                   "JOIN moviemaster m ON r.mov_id = m.mov_id " +
	                   "JOIN moviegenreactorjoin mj ON m.mov_id = mj.mov_id " +
	                   "JOIN genres g ON mj.gen_id = g.gen_id " +
	                   "JOIN actor a ON mj.act_id = a.act_id " +
	                   "GROUP BY m.mov_id, m.mov_title, m.mov_rel_date, g.gen_name, a.act_name " +
	                   "HAVING COUNT(r.u_id) > 0 " +
	                   "ORDER BY user_count DESC, overall_rating DESC LIMIT 5";

	    return template.query(query, (rs, rowNum) -> {
	    
	        MovieMasterModel movie = new MovieMasterModel();
	        movie.setMovieId(rs.getInt("mov_id"));
	        movie.setMovTitle(rs.getString("mov_title"));
	        movie.setMovDate(rs.getString("release_date"));

	     
	        GenreMasterModel genre = new GenreMasterModel();
	        genre.setGenName(rs.getString("genre"));

	        ActorModel actor = new ActorModel();
	        actor.setActName(rs.getString("actor"));

	   
	        MovieDetail movieDetail = new MovieDetail();
	        movieDetail.setMovie(movie);
	        movieDetail.setGenre(genre);
	        movieDetail.setActor(actor);
	        movieDetail.setOverallRating(rs.getFloat("overall_rating"));

	        return movieDetail;
	    });
	}





	

}
