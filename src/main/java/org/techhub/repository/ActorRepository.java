package org.techhub.repository;

import java.util.List;

import org.techhub.model.ActorModel;



public interface ActorRepository {

	public boolean isAddNewGenre(ActorModel model);

	public List<ActorModel> getAllActors();

	public void isDeleteActorById(int cid);

	List<ActorModel> searchActors(String actName);

	public ActorModel getActorById(int actId);

	public void updateActor(ActorModel actor);
}
