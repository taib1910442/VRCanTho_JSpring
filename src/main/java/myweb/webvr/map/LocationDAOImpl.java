package myweb.webvr.map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class LocationDAOImpl implements LocationDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Location> getAllLocations() {
        String sql = "SELECT * FROM locations";
        return jdbcTemplate.query(sql, new LocationMapper());
    }
    public class LocationMapper implements RowMapper<Location> {
        @Override
        public Location mapRow(ResultSet rs, int rowNum) throws SQLException {
            Location location = new Location();
            location.setLocationID(rs.getInt("LocationID"));
            location.setName(rs.getString("Name"));
            location.setAddress(rs.getString("Address"));
            location.setLatitude(rs.getString("Latitude"));
            location.setLongitude(rs.getString("Longitude"));
            return location;
        }
    }

}

