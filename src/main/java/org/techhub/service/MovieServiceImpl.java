package org.techhub.service;

import java.sql.Date;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.techhub.model.MovieDetail;
import org.techhub.model.MovieMasterModel;
import org.techhub.repository.MovieRepository;

@Service("movieService")
public class MovieServiceImpl implements MovieService{

	@Autowired 
	MovieRepository movieRepo;
	
	
	
	@Override
	public boolean isAddNewMovie(MovieMasterModel model) {
		// TODO Auto-generated method stub
		return movieRepo.isAddNewMovie(model);
	}

	@Override
	public List<MovieMasterModel> getMovieList() {
		// TODO Auto-generated method stub
		return movieRepo.getMovieList();
	}

	@Override
	public void isDeleteMovieById(int movid) {
		// TODO Auto-generated method stub
		movieRepo.isDeleteMovieById(movid);
	}

	@Override
	public List<MovieMasterModel> searchMovies(String movieTitle, String movieGenre, String yearFrom, String yearTo,String movieActor) {
	    return movieRepo.searchMovies(movieTitle, movieGenre, yearFrom, yearTo,movieActor);
	}

	@Override
	public MovieMasterModel getMovieById(int movieId) {
		// TODO Auto-generated method stub
		return movieRepo.getMovieById(movieId);
	}
	public void updateMovie(MovieMasterModel movie) {
		movieRepo.updateMovie(movie);  // Assume you have an updateMovie method in your DAO
	}

	public MovieMasterModel findByName(String movieName) {
	    // Assuming you have a repository to interact with the database
	    return movieRepo.findByName(movieName);
	}

	 public List<MovieMasterModel> getWatchedMoviesByUser(int userId) {
	        return movieRepo.getWatchedMoviesByUser(userId);
	    }

	@Override
	public List<MovieDetail> getTopRatedMovies() {
		// TODO Auto-generated method stub
		return movieRepo.getTopRatedMovies();
	}

	@Override
	public Integer getMaxMovieId() {
		// TODO Auto-generated method stub
		return movieRepo.getMaxMovieId();
	}
	


	   
	}



