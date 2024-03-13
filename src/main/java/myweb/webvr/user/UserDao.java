package myweb.webvr.user;

public interface UserDao {

    void register(User user);

    User validateUser(Login login);
    boolean isUsernameExists(String username);
}