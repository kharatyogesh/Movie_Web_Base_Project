package org.techhub.model;

public class MovieDetail {
    private MovieMasterModel movie;
    private GenreMasterModel genre;
    private ActorModel actor;
    private float overallRating;

    // Getters and setters
    public MovieMasterModel getMovie() {
        return movie;
    }

    public void setMovie(MovieMasterModel movie) {
        this.movie = movie;
    }

    public GenreMasterModel getGenre() {
        return genre;
    }

    public void setGenre(GenreMasterModel genre) {
        this.genre = genre;
    }

    public ActorModel getActor() {
        return actor;
    }

    public void setActor(ActorModel actor) {
        this.actor = actor;
    }

    public float getOverallRating() {
        return overallRating;
    }

    public void setOverallRating(float overallRating) {
        this.overallRating = overallRating;
    }
    @Override
    public String toString() {
        return "MovieDetail{" +
                "movie=" + movie +
                ", genre=" + genre +
                ", actor=" + actor +
                ", overallRating=" + overallRating +
                '}';
    }

    
}
