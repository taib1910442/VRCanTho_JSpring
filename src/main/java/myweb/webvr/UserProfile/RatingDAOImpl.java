package myweb.webvr.UserProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class RatingDAOImpl implements RatingDAO{
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public RatingDAOImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Rating> getRatingsByUsername(String username) {
        String sql = "SELECT * FROM Ratings WHERE Username = ?";
        return jdbcTemplate.query(sql, new Object[]{username}, new RatingMapper());
    }


    public static class RatingMapper implements RowMapper<Rating> {
        @Override
        public Rating mapRow(ResultSet rs, int rowNum) throws SQLException {
            Rating rating = new Rating();
            rating.setRatingID(rs.getInt("RatingID"));
            rating.setUsername(rs.getString("Username"));
            rating.setLocationID(rs.getInt("LocationID"));
            rating.setRatingValue(rs.getDouble("RatingValue"));
            rating.setComment(rs.getString("Comment"));
            return rating;
        }
    }
    @Override
    public List<Rating> getAllRatings() {
        String sql = "SELECT * FROM ratings";
        return jdbcTemplate.query(sql, new RatingMapper());
    }

    @Override
    public Rating getRatingById(int ratingID) {
        String sql = "SELECT * FROM ratings WHERE ratingID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{ratingID}, new RatingMapper());
    }

    @Override
    public void addRating(Rating rating) {
        String sql = "INSERT INTO ratings (username, locationID, ratingValue, comment) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, rating.getUsername(), rating.getLocationID(), rating.getRatingValue(), rating.getComment());
    }

    @Override
    public void updateRating(Rating rating) {
        String sql = "UPDATE ratings SET username = ?, locationID = ?, ratingValue = ?, comment = ? WHERE ratingID = ?";
        jdbcTemplate.update(sql, rating.getUsername(), rating.getLocationID(), rating.getRatingValue(), rating.getComment(), rating.getRatingID());
    }

    @Override
    public void deleteRating(int ratingID) {
        String sql = "DELETE FROM ratings WHERE ratingID = ?";
        jdbcTemplate.update(sql, ratingID);
    }
    public List<Rating> getRatingsByLocationID(int locationID) {
        String sql = "SELECT * FROM ratings WHERE locationID = ?";
        return jdbcTemplate.query(sql, new RatingMapper(), locationID);
    }
}
