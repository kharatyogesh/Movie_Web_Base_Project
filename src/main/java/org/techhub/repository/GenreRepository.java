package org.techhub.repository;

import java.util.List;

import org.techhub.model.GenreMasterModel;

public interface GenreRepository {

	public boolean isAddNewGenre(GenreMasterModel model);

	public List<GenreMasterModel> getAllGenres();

	public void isDeleteGenreById(int gid);

	List<GenreMasterModel> searchGenres(String genName);

	public GenreMasterModel getGenreById(int genId);

	public void updateGenre(GenreMasterModel genre);
}
