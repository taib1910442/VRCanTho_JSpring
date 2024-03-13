package myweb.webvr.UserProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class WishlistLocationDAOImpl implements WishlistLocationDAO {
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public WishlistLocationDAOImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<WishlistLocation> getWishlistLocationsByUsername(String username) {
        String sql = "SELECT * FROM Wishlistlocations WHERE Username = ?";
        return jdbcTemplate.query(sql, new Object[]{username}, new WishlistLocationMapper());
    }
    public static class WishlistLocationMapper implements RowMapper<WishlistLocation> {
        @Override
        public WishlistLocation mapRow(ResultSet rs, int rowNum) throws SQLException {
            WishlistLocation Wishlist = new WishlistLocation();
            Wishlist.setUsername(rs.getString("Username"));
            Wishlist.setLocationID(rs.getInt("LocationID"));
            Wishlist.setName(rs.getString("Name"));
            Wishlist.setLatitude(rs.getString("Latitude"));
            Wishlist.setLongitude(rs.getString("Longitude"));
            return Wishlist;
        }
    }
}
