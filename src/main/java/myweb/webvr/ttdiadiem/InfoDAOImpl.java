package myweb.webvr.ttdiadiem;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

@Repository
public class InfoDAOImpl implements InfoDAO {
    private final JdbcTemplate jdbcTemplate;

    public InfoDAOImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public Info getInfoById(int infoId) {
        String sql = "SELECT Info_id, Des, Image FROM info WHERE Info_id = ?";
        return jdbcTemplate.queryForObject(sql, new Object[]{infoId}, (rs, rowNum) -> {
            Info info = new Info();
            info.setInfoId(rs.getInt("Info_id"));
            info.setDescription(rs.getString("Des"));
            info.setImage(rs.getString("Image"));
            return info;
        });
    }
    @Override
    public void updateInfoDescription(int infoId, String newDescription) {
        String sql = "UPDATE Info SET Des = ? WHERE Info_id = ?";
        jdbcTemplate.update(sql, newDescription, infoId);
    }

}
