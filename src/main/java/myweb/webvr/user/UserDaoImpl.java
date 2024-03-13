package myweb.webvr.user;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;


public class UserDaoImpl implements UserDao {

    @Autowired
    DataSource datasource;

    @Autowired
    JdbcTemplate jdbcTemplate;

    private String hashPassword(String plainPassword) {
        BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
        return passwordEncoder.encode(plainPassword);
    }
    public void register(User user) {
        if (!isUsernameExists(user.getUsername())) {
            String hashedPassword = hashPassword(user.getPassword()); // Mã hóa mật khẩu trước khi lưu vào cơ sở dữ liệu
            String sql = "insert into users (Username, Password, Email) values(?,?,?)";
            jdbcTemplate.update(sql, user.getUsername(), hashedPassword, user.getEmail());
        }
    }

    public User validateUser(Login login) {
        String sql = "select * from users where username='" + login.getUsername() + "'";

        List<User> users = jdbcTemplate.query(sql, new UserMapper());

        if (!users.isEmpty()) {
            User user = users.get(0);
            String hashedPasswordFromDB = user.getPassword(); // Lấy mật khẩu đã mã hóa từ cơ sở dữ liệu

            // So sánh mật khẩu người dùng nhập vào với mật khẩu đã mã hóa từ cơ sở dữ liệu
            if (BCrypt.checkpw(login.getPassword(), hashedPasswordFromDB)) {
                return user;
            }
        }

        return null;
    }

    @Override
    public boolean isUsernameExists(String username) {
        String sql = "select count(*) from users where username = ?";
        int count = jdbcTemplate.queryForObject(sql, Integer.class, username);
        return count > 0;
    }
}

class UserMapper implements RowMapper<User> {

    public User mapRow(ResultSet rs, int arg1) throws SQLException {
        User user = new User();

        user.setUsername(rs.getString("username"));
        user.setPassword(rs.getString("password"));
        user.setEmail(rs.getString("email"));
        user.setRole(rs.getString("role"));
        return user;
    }
}