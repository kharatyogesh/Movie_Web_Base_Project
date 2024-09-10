package org.techhub.service;

import java.util.List;

import org.techhub.model.ActorModel;

public interface ActorService {

	public boolean isAddNewActor(ActorModel model);

	public List<ActorModel> getAllActors();

	public void isDeleteActorById(int cid);

	List<ActorModel> searchActors(String actName);

	public ActorModel getActorById(int actId);

	public void updateActor(ActorModel actor);
}
