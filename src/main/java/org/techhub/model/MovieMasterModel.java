package org.techhub.model;
public class MovieMasterModel extends GenreMasterModel{

	private int movieId;
	private String movTitle;
	private String movDate;
	

	public int getMovieId() {
		return movieId;
	}

	public void setMovieId(int movieId) {
		this.movieId = movieId;
	}

	public String getMovTitle() {
		return movTitle;
	}

	public void setMovTitle(String movTitle) {
		this.movTitle = movTitle;
	}

	public String getMovDate() {
		return movDate;
	}

	public void setMovDate(String movDate) {
		this.movDate = movDate;
	}
	  @Override
	    public String toString() {
	        return "MovieMasterModel [movieId=" + movieId + ", movTitle=" + movTitle + 
	               ", movDate=" + movDate + ", genName=" + genName + "]";
	    }
}
