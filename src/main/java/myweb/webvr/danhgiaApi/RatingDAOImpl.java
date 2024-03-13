package myweb.webvr.danhgiaApi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class RatingDAOImpl implements RatingDAO {
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public RatingDAOImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Double getAverageRatingByLocationID(int locationID) {
        String sql = "SELECT AVG(RatingValue) FROM ratings WHERE LocationID = ?";
        return jdbcTemplate.queryForObject(sql, Double.class, locationID);
    }
    @Override
    public Long getTotalRatingCountByLocationID(int locationID) {
        String sql = "SELECT COUNT(*) FROM ratings WHERE LocationID = ?";
        return jdbcTemplate.queryForObject(sql, Long.class, locationID);
    }
    @Override
    public void saveRating(Rating rating) {
        String sql = "INSERT INTO ratings (Username, LocationID, RatingValue, Comment) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, rating.getUsername(), rating.getLocationID(), rating.getRatingValue(), rating.getComment());
    }

}
