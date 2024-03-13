package myweb.webvr.user;

import org.springframework.beans.factory.annotation.Autowired;

public class UserServiceImpl implements UserService{
    @Autowired
    UserDao userDao;
    @Override
    public void register(User user) {
        userDao.register(user);
    }
    @Override
    public User validateUser(Login login) {
        return userDao.validateUser(login);

    }
    public boolean isUsernameExists(String username) {
        return userDao.isUsernameExists(username);
    }

}
