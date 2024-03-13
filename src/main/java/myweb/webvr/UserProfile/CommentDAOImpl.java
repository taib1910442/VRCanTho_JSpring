package myweb.webvr.UserProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Repository;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

@Repository
public class CommentDAOImpl implements CommentDAO {
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public CommentDAOImpl(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @Override
    public List<Comment> getCommentsByUsername(String username) {
        String sql = "SELECT * FROM Comments WHERE Username = ?";
        return jdbcTemplate.query(sql, new Object[]{username}, new CommentMapper());
    }
    public class CommentMapper implements RowMapper<Comment> {
        @Override
        public Comment mapRow(ResultSet rs, int rowNum) throws SQLException {
            Comment comment = new Comment();
            comment.setCommentID(rs.getInt("CommentID"));
            comment.setUsername(rs.getString("Username"));
            comment.setLocationID(rs.getInt("LocationID"));
            comment.setReplyTo(rs.getInt("ReplyTo"));
            comment.setContent(rs.getString("Content"));
            return comment;
        }
    }
    @Override
    public Comment addComment(Comment comment) {
        String sql = "INSERT INTO Comments (Username, ReplyTo, LocationID, Content) VALUES (?, ?, ?, ?)";
        jdbcTemplate.update(sql, comment.getUsername(),comment.getReplyTo(), comment.getLocationID(), comment.getContent());
        return comment;
    }
    @Override
    public List<Comment> getAllComments() {
        String sql = "SELECT * FROM Comments";
        return jdbcTemplate.query(sql, (resultSet, rowNum) -> {
            Comment comment = new Comment();
            comment.setCommentID(resultSet.getInt("CommentID"));
            comment.setUsername(resultSet.getString("Username"));
            comment.setLocationID(resultSet.getInt("LocationID"));
            comment.setReplyTo(resultSet.getInt("ReplyTo"));
            comment.setContent(resultSet.getString("Content"));
            return comment;
        });
    }
    @Override
    public List<Comment> getCommentsByLocationID(int locationID) {
        String sql = "SELECT c.*\n" +
                "FROM comments c\n" +
                "INNER JOIN users u ON c.username = u.username\n" +
                "WHERE c.locationID = ? AND u.role <> 'BANNED'\n" +
                "ORDER BY c.CommentID DESC;";
        return jdbcTemplate.query(sql, new CommentMapper(), locationID);
    }
}