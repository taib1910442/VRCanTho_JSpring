package myweb.webvr.user;


public interface UserService {
    void register(User user);

    User validateUser(Login login);
    boolean isUsernameExists(String username);
}



