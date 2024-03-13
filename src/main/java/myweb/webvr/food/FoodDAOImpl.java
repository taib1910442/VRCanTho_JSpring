package myweb.webvr.food;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class FoodDAOImpl implements FoodDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Food> getAllFoods() {
        String sql = "SELECT * FROM foods";
        return jdbcTemplate.query(sql, new FoodMapper());
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

}

