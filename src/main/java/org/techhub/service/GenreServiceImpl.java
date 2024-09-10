package org.techhub.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.techhub.model.GenreMasterModel;
import org.techhub.model.MovieMasterModel;
import org.techhub.repository.GenreRepository;

@Service("genreService")
public class GenreServiceImpl implements GenreService {

	@Autowired
	GenreRepository genreRepo;
	
	@Override
	public boolean isAddNewGenre(GenreMasterModel model) {
		// TODO Auto-generated method stub
		return genreRepo.isAddNewGenre(model);
	}

	@Override
	public List<GenreMasterModel> getAllGenres() {
		// TODO Auto-generated method stub
		return genreRepo.getAllGenres();
	}

	@Override
	public void isDeleteGenreById(int gid) {
		// TODO Auto-generated method stub
		 genreRepo.isDeleteGenreById(gid);
	}

	@Override
	public List<GenreMasterModel> searchGenres(String genName) {
		// TODO Auto-generated method stub
		return genreRepo.searchGenres(genName);
	}

	@Override
	public GenreMasterModel getGenreById(int genId) {
		// TODO Auto-generated method stub
		return genreRepo.getGenreById(genId);
	}

	@Override
	public void updateGenre(GenreMasterModel genre) {
		
		genreRepo.updateGenre(genre);
		
	}

}
