package myweb.webvr.WishlistLocation;

import myweb.webvr.imgdiadiem.imgObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public class WishlistLocationDaoImpl implements WishlistLocationDao {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<WishlistLocation> findByUsername(String username) {
        String sql = "SELECT LocationID, Username, Name, Latitude, Longitude FROM wishlistlocations WHERE username = ?";
        return jdbcTemplate.query(sql, new Object[]{username}, new BeanPropertyRowMapper<>(WishlistLocation.class));
    }
}
