package myweb.webvr.food;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ResDAOImpl implements ResDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Res> getAllRestaurants() {
        String sql = "SELECT r.restaurantID, r.restaurantName, r.restaurantLocate, r.lat, r.lng, f.foodID, f.foodName\n" +
                "FROM restaurants r\n" +
                "         INNER JOIN foodrestaurant fr ON r.restaurantID = fr.restaurantID\n" +
                "         INNER JOIN foods f ON fr.foodID = f.foodID;";
        return jdbcTemplate.query(sql, new RestaurantMapper());
    }
    public class RestaurantMapper implements RowMapper<Res> {
        @Override
        public Res mapRow(ResultSet rs, int rowNum) throws SQLException {
            Res restaurant = new Res();
            restaurant.setRestaurantID(rs.getInt("restaurantID"));
            restaurant.setRestaurantName(rs.getString("restaurantName"));
            restaurant.setRestaurantLocate(rs.getString("restaurantLocate"));
            restaurant.setLat(rs.getString("lat"));
            restaurant.setLng(rs.getString("lng"));
            restaurant.setFoodID(rs.getInt("foodID"));
            restaurant.setFoodName(rs.getString("foodName"));
            return restaurant;
        }
    }

}

