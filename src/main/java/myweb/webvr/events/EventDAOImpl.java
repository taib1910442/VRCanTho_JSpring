package myweb.webvr.events;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.stereotype.Repository;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import javax.sql.DataSource;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class EventDAOImpl implements EventDAO {

    @Autowired
    private JdbcTemplate jdbcTemplate;

    @Override
    public List<Event> getAllEvents() {
        String sql = "SELECT * FROM Events ORDER BY CASE WHEN evMonth >= 12 THEN 0 ELSE 1 END, evMonth ASC, evDay ASC";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Event.class));
    }
    @Override
    public List<Event> getRandomEvents() {
        String sql = "SELECT * FROM Events ORDER BY RAND() LIMIT 5";
        return jdbcTemplate.query(sql, new BeanPropertyRowMapper<>(Event.class));
    }
    @Override
    public Event getEventById(int eventID) {
        String sql = "SELECT * FROM Events WHERE eventID = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{eventID}, new BeanPropertyRowMapper<>(Event.class));
    }
    @Override
    public void addEvent(Event event) {
        String sql = "INSERT INTO Events (evName, evDes, isAnnual, isLunar, evDay, evMonth, evLocation) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?)";
        jdbcTemplate.update(sql,
                event.getEvName(),
                event.getEvDes(),
                event.getIsAnnual(),
                event.getIsLunar(),
                event.getEvDay(),
                event.getEvMonth(),
                event.getEvLocation());
    }
    @Override
    public void updateEvent(int eventID, String newContent) {
        String sql = "UPDATE Events SET evContent = ? WHERE eventID = ?";
        jdbcTemplate.update(sql, newContent, eventID);
    }
    @Override
    public void deleteEventById(int eventId) {
        String sql = "DELETE FROM Events WHERE eventID = ?";
        jdbcTemplate.update(sql, eventId);
    }
}
