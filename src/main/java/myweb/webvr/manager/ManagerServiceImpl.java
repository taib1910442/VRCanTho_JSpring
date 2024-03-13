package myweb.webvr.manager;

import myweb.webvr.events.Event;
import myweb.webvr.food.Food;
import myweb.webvr.food.Res;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
@Service
public class ManagerServiceImpl implements ManagerService{
    @Autowired
    private ManagerDAO managerDAO;
    @Override
    public List<Food> getAllFoods() {
        return managerDAO.getAllFoods();
    }
    @Override
    public List<Res> getAllRestaurants() {
        return managerDAO.getAllRestaurants();
    }
    @Override
    public List<Manager> getAllLocations() {
        return managerDAO.getAllLocations();
    }
    @Override
    public List<Manager> getAllUser() {
        return managerDAO.getAllUser();
    }
}
