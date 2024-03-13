package myweb.webvr.UserProfile;


public class Rating {
    private int ratingID;
    private String username;
    private int locationID;
    private String comment;
    private double ratingValue;
    public int getRatingID() {
        return ratingID;
    }
    public void setRatingID(int ratingID) {
        this.ratingID = ratingID;
    }
    public int getLocationID() {
        return locationID;
    }
    public void setLocationID(int locationID) {
        this.locationID = locationID;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public double getRatingValue() {
        return ratingValue;
    }
    public void setRatingValue(double ratingValue) {
        this.ratingValue = ratingValue;
    }
    public String getComment() {
        return comment;
    }
    public void setComment(String comment) {
        this.comment = comment;
    }
}

