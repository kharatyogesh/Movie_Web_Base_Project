package org.techhub.model;

public class GenreMasterModel extends ActorModel {

	private int genId;
	protected String genName;

	public int getGenId() {
		return genId;
	}

	public void setGenId(int genId) {
		this.genId = genId;
	}

	public String getGenName() {
		return genName;
	}

	public void setGenName(String genName) {
		this.genName = genName;
	}
}
