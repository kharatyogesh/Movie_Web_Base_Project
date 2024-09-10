package org.techhub.repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementSetter;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;
import org.techhub.model.AdminModel;
import org.techhub.model.GenreMasterModel;
import org.techhub.model.MovieMasterModel;


@Repository("genreRepo")
public class GenreRepositoryImpl implements GenreRepository{

	@Autowired
	JdbcTemplate template;
	
	List<GenreMasterModel> list;
	
	@Override
	 public boolean isAddNewGenre(GenreMasterModel model) {
        String sql = "INSERT INTO genres (gen_name) VALUES (?)";
        int result = template.update(sql, model.getGenName());
        return result > 0;
    }

	 public List<GenreMasterModel> getAllGenres() {
	        String sql = "SELECT * FROM genres";
	        return template.query(sql, new RowMapper<GenreMasterModel>() {
	            @Override
	            public GenreMasterModel mapRow(ResultSet rs, int rowNum) throws SQLException {
	                GenreMasterModel gm = new GenreMasterModel();
	                gm.setGenId(rs.getInt(1)); // Assuming "genId" is the column name
	                gm.setGenName(rs.getString(2)); // Assuming "genName" is the column name
	                return gm;
	            }
	        });
	    }

	 @Override
	 public void isDeleteGenreById(int gid) {
	     String sql = "DELETE FROM genres WHERE gen_id = ?";
	     template.update(sql, gid);
	 }


	public List<GenreMasterModel> searchGenres(String genName) {
	    StringBuilder sql = new StringBuilder("SELECT gen_id, gen_name FROM genres WHERE 1=1");
	    List<Object> params = new ArrayList<>();

	    if (genName != null && !genName.isEmpty()) {
	        sql.append(" AND gen_name LIKE ?");
	        params.add("%" + genName + "%");
	    }

	    sql.append(" ORDER BY gen_id");

	    return template.query(sql.toString(), params.toArray(), new GenreRowMapper());
	}

	private static class GenreRowMapper implements RowMapper<GenreMasterModel> {
	    @Override
	    public GenreMasterModel mapRow(ResultSet rs, int rowNum) throws SQLException {
	        GenreMasterModel genre = new GenreMasterModel();
	        genre.setGenId(rs.getInt("gen_id"));
	        genre.setGenName(rs.getString("gen_name"));
	        return genre;
	    }
	}

	
	@Override
	public GenreMasterModel getGenreById(int genId) {
	    String sql = "SELECT gen_id AS genId, gen_name AS genName FROM genres WHERE gen_id = ?";
	    return template.queryForObject(sql, new Object[]{genId}, (rs, rowNum) -> {
	        GenreMasterModel genre = new GenreMasterModel();
	        genre.setGenId(rs.getInt("genId"));
	        genre.setGenName(rs.getString("genName"));
	        return genre;
	    });
	}


	@Override
	public void updateGenre(GenreMasterModel genre) {
	    String updateSql = "UPDATE genres SET gen_name = ? WHERE gen_id = ?";
	    template.update(updateSql, genre.getGenName(), genre.getGenId());
	}


}
