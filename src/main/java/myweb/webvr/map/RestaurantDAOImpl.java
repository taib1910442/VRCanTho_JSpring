package myweb.webvr.map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class RestaurantDAOImpl implements RestaurantDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Restaurant> getAllRestaurants() {
        String sql = "SELECT * FROM restaurants";
        return jdbcTemplate.query(sql, new RestaurantMapper());
    }
    public class RestaurantMapper implements RowMapper<Restaurant> {
        @Override
        public Restaurant mapRow(ResultSet rs, int rowNum) throws SQLException {
            Restaurant restaurant = new Restaurant();
            restaurant.setRestaurantID(rs.getInt("restaurantID"));
            restaurant.setRestaurantName(rs.getString("restaurantName"));
            restaurant.setRestaurantLocate(rs.getString("restaurantLocate"));
            restaurant.setLat(rs.getString("lat"));
            restaurant.setLng(rs.getString("lng"));
            return restaurant;
        }
    }

}

