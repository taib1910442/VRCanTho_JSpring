package myweb.webvr.manager;

import myweb.webvr.food.Food;
import myweb.webvr.food.Res;

import java.util.List;

public interface ManagerService {
    List<Manager> getAllLocations();
    //void addLocation(Manager location);
    List<Food> getAllFoods();
    List<Res> getAllRestaurants();
    List<Manager> getAllUser();
    //void addFood(Manager food);
    //void addRestaurant(Manager restaurant);
}
