package myweb.webvr.danhgiaApi;

public interface RatingDAO {
    Double getAverageRatingByLocationID(int locationID);
    Long getTotalRatingCountByLocationID(int locationID);
    void saveRating(Rating rating);

}
