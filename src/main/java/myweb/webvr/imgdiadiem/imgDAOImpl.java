package myweb.webvr.imgdiadiem;


import myweb.webvr.imgdiadiem.imgObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class imgDAOImpl implements imgDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public imgObj getLocationById(int locationID) {
        String sql = "SELECT Image1, Thumb1, Image2, Thumb2, Image3, Thumb3 FROM locations WHERE locationID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{locationID}, (rs, rowNum) -> {
            imgObj img = new imgObj();
            img.setLocationID(locationID);
            img.setImage1(rs.getString("Image1"));
            img.setThumbImage1(rs.getString("Thumb1"));
            img.setImage2(rs.getString("Image2"));
            img.setThumbImage2(rs.getString("Thumb2"));
            img.setImage3(rs.getString("Image3"));
            img.setThumbImage3(rs.getString("Thumb3"));
            return img;
        });
    }
    @Override
    public imgObj getCoordinatesById(int locationID) {
        String sql = "SELECT Latitude, Longitude FROM locations WHERE locationID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{locationID}, (rs, rowNum) -> {
            imgObj Coo = new imgObj();
            Coo.setLocationID(locationID);
            Coo.setLatitude(rs.getString("Latitude"));
            Coo.setLongitude(rs.getString("Longitude"));
            return Coo;
        });
    }
    @Override
    public List<imgObj> getAllLocations() {
        String query = "SELECT locationID, Image1, Thumb1, Latitude, Longitude FROM locations";
        return jdbcTemplate.query(query, (resultSet, rowNum) -> {
            imgObj img = new imgObj();
            img.setLocationID(resultSet.getInt("locationID"));
            img.setImage1(resultSet.getString("Image1"));
            img.setThumbImage1(resultSet.getString("Thumb1"));
            img.setLatitude(resultSet.getString("Latitude"));
            img.setLongitude(resultSet.getString("Longitude"));
            return img;
        });
    }
}
