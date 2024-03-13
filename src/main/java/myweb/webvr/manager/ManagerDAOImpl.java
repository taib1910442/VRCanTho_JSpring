package myweb.webvr.manager;

import myweb.webvr.UserProfile.Comment;
import myweb.webvr.UserProfile.CommentDAOImpl;
import myweb.webvr.dmdiadiem.LocationsObj;
import myweb.webvr.food.Food;
import myweb.webvr.food.FoodDAOImpl;
import myweb.webvr.food.Res;
import myweb.webvr.food.ResDAOImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class ManagerDAOImpl implements ManagerDAO {
    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Food> getAllFoods() {
        String sql = "SELECT * FROM foods";
        return jdbcTemplate.query(sql, new ManagerDAOImpl.FoodMapper());
    }
    public class FoodMapper implements RowMapper<Food> {
        @Override
        public Food mapRow(ResultSet rs, int rowNum) throws SQLException {
            Food food = new Food();
            food.setFoodID(rs.getInt("foodID"));
            food.setFoodName(rs.getString("foodName"));
            food.setPrice(rs.getString("price"));
            food.setLink(rs.getString("link"));
            return food;
        }
    }
    @Override
    public List<Res> getAllRestaurants() {
        String sql = "SELECT * FROM restaurants";
        return jdbcTemplate.query(sql, new ManagerDAOImpl.RestaurantMapper());
    }
    public class RestaurantMapper implements RowMapper<Res> {
        @Override
        public Res mapRow(ResultSet rs, int rowNum) throws SQLException {
            Res managerRes = new Res();
            managerRes.setRestaurantID(rs.getInt("restaurantID"));
            managerRes.setRestaurantName(rs.getString("restaurantName"));
            managerRes.setRestaurantLocate(rs.getString("restaurantLocate"));
            managerRes.setLat(rs.getString("lat"));
            managerRes.setLng(rs.getString("lng"));
            managerRes.setFoodID(rs.getInt("foodID"));
            return managerRes;
        }
    }
    @Override
    public List<Manager> getAllLocations() {
        String sql = "SELECT * FROM locations";
        return jdbcTemplate.query(sql, new RowMapper<Manager>() {
            @Override
            public Manager mapRow(ResultSet rs, int rowNum) throws SQLException {
                Manager location = new Manager();
                location.setLocationID(rs.getInt("LocationID"));
                location.setName(rs.getString("Name"));
                location.setDescription(rs.getString("Description"));
                location.setAddress(rs.getString("Address"));
                location.setLatitude(rs.getString("Latitude"));
                location.setLongitude(rs.getString("Longitude"));
                location.setCategory(rs.getString("Category"));
                return location;
            }
        });
    }
    @Override
    public List<Manager> getAllUser() {
        String sql = "SELECT * FROM Users";
        return jdbcTemplate.query(sql, new RowMapper<Manager>() {
            @Override
            public Manager mapRow(ResultSet rs, int rowNum) throws SQLException {
                Manager user = new Manager();
                user.setUserID(rs.getInt("UserID"));
                user.setUsername(rs.getString("Username"));
                user.setRole(rs.getString("Role"));
                user.setEmail(rs.getString("Email"));
                return user;
            }
        });
    }
    @Override
    public List<Manager> getCommentsByUsername(String username) {
        String sql = "SELECT * FROM Comments WHERE Username = ?";
        return jdbcTemplate.query(sql, new Object[]{username}, new ManagerDAOImpl.CommentMapper());
    }
    public class CommentMapper implements RowMapper<Manager> {
        @Override
        public Manager mapRow(ResultSet rs, int rowNum) throws SQLException {
            Manager comment = new Manager();
            comment.setCommentID(rs.getInt("CommentID"));
            comment.setUsername(rs.getString("Username"));
            comment.setLocationID(rs.getInt("LocationID"));
            comment.setReplyTo(rs.getInt("ReplyTo"));
            comment.setContent(rs.getString("Content"));
            return comment;
        }
    }
}
