package org.techhub.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.techhub.model.ActorModel;
import org.techhub.model.GenreMasterModel;
import org.techhub.repository.ActorRepository;
import org.techhub.repository.GenreRepository;

@Service("actorService")
public class ActorServiceImpl implements ActorService{

	@Autowired
	ActorRepository actorRepo;
	
	@Override
	public boolean isAddNewActor(ActorModel model) {
		// TODO Auto-generated method stub
		return actorRepo.isAddNewGenre(model);
	}

	@Override
	public List<ActorModel> getAllActors() {
		// TODO Auto-generated method stub
		return actorRepo.getAllActors();
	}

	@Override
	public void isDeleteActorById(int gid) {
		// TODO Auto-generated method stub
		actorRepo.isDeleteActorById(gid);
	}

	@Override
	public List<ActorModel> searchActors(String genName) {
		// TODO Auto-generated method stub
		return actorRepo.searchActors(genName);
	}

	@Override
	public ActorModel getActorById(int genId) {
		// TODO Auto-generated method stub
		return actorRepo.getActorById(genId);
	}

	@Override
	public void updateActor(ActorModel genre) {
		
		actorRepo.updateActor(genre);
		
	}
}
