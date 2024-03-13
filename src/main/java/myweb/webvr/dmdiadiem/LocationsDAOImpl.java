package myweb.webvr.dmdiadiem;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.stereotype.Repository;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.client.RestTemplate;

import javax.servlet.ServletContext;
import java.io.File;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
@PropertySource("classpath:application.properties")
public class LocationsDAOImpl implements LocationsDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;
    @Autowired
    private ServletContext servletContext;
    @Autowired
    private RestTemplate restTemplate;

    @Value("${api.url}")
    private String apiUrl;
    @Override
    public List<LocationsObj> getAllLocations() {
        String sql = "SELECT * FROM locations";
        return jdbcTemplate.query(sql, new RowMapper<LocationsObj>() {
            @Override
            public LocationsObj mapRow(ResultSet rs, int rowNum) throws SQLException {
                LocationsObj location = new LocationsObj();
                location.setLocationID(rs.getInt("LocationID"));
                location.setName(rs.getString("Name"));
                location.setDescription(rs.getString("Description"));
                location.setAddress(rs.getString("Address"));
                location.setLatitude(rs.getString("Latitude"));
                location.setLongitude(rs.getString("Longitude"));
                location.setCategory(rs.getString("Category"));
                location.setImage(rs.getString("Image1"));
                location.setImageThumb(rs.getString("Thumb1"));
                return location;
            }
        });
    }
    @Override
    public List<LocationsObj> searchLocations(String keyword) {
        String sql = "SELECT * FROM locations";

        if (keyword != null && !keyword.isEmpty()) {
            sql += " WHERE Name LIKE ?";
            keyword = "%" + keyword + "%";
        }

        return jdbcTemplate.query(sql, new Object[]{keyword}, this::mapRow);
    }

    private LocationsObj mapRow(ResultSet rs, int rowNum) throws SQLException {
        LocationsObj location = new LocationsObj();
        location.setLocationID(rs.getInt("LocationID"));
        location.setName(rs.getString("Name"));
        location.setDescription(rs.getString("Description"));
        location.setAddress(rs.getString("Address"));
        location.setLatitude(rs.getString("Latitude"));
        location.setLongitude(rs.getString("Longitude"));
        location.setCategory(rs.getString("Category"));
        location.setImage(rs.getString("Image1"));
        location.setImageThumb(rs.getString("Thumb1"));
        return location;
    }
    @Override
    public LocationsObj getLocationByID(int locationID) {
        String sql = "SELECT * FROM locations WHERE locationID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{locationID}, new BeanPropertyRowMapper<>(LocationsObj.class));
    }
    @Override
    public LocationsObj getLocationCoorById(int id) {
        String sql = "SELECT LocationID, Name, Address, Latitude, Longitude FROM Locations WHERE LocationID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{id}, (rs, rowNum) -> {
            LocationsObj location = new LocationsObj();
            location.setLocationID(rs.getInt("LocationID"));
            location.setName(rs.getString("Name"));
            location.setAddress(rs.getString("Address"));
            location.setLatitude(rs.getString("Latitude"));
            location.setLongitude(rs.getString("Longitude"));
            return location;
        });
    }
    @Override
    public void updateImageURL(int locationID, String imageURL) {
        String sql = "UPDATE locations SET Image1 = ? WHERE LocationID = ?";
        jdbcTemplate.update(sql, imageURL, locationID);
    }

    @Override
    public void addLocation(LocationsObj location) {
        String sql = "INSERT INTO locations (Name, Description, Address, Latitude, Longitude, Category, Image1) VALUES (?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql, location.getName(), location.getDescription(), location.getAddress(), location.getLatitude(), location.getLongitude(), location.getCategory(), location.getImageFile().getOriginalFilename());

    }
}
