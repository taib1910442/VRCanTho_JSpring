package myweb.webvr.UserProfile;


import java.util.List;

// DAO cho Ratings
    public interface RatingDAO {
        List<Rating> getRatingsByUsername(String username);
    List<Rating> getAllRatings();
    Rating getRatingById(int ratingID);
    void addRating(Rating rating);
    void updateRating(Rating rating);
    void deleteRating(int ratingID);
    List<Rating> getRatingsByLocationID(int locationID);
    }

