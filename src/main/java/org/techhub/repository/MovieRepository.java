package org.techhub.repository;

import java.sql.Date;
import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.techhub.model.MovieDetail;
import org.techhub.model.MovieMasterModel;



public interface MovieRepository {

	public boolean isAddNewMovie(MovieMasterModel model);
	public List<MovieMasterModel> getMovieList();
	public void isDeleteMovieById(int movid);	
    List<MovieMasterModel> searchMovies(String movieTitle, String movieGenre, String yearFrom, String yearTo,String movieActor);
	public MovieMasterModel getMovieById(int movieId);
	public void updateMovie(MovieMasterModel movie);
	public MovieMasterModel findByName(String movieName);
	 public List<MovieMasterModel> getWatchedMoviesByUser(int userId);
	 public List<MovieDetail> getTopRatedMovies();
	 public Integer getMaxMovieId();
}
