package myweb.webvr.manager;

import myweb.webvr.events.Event;
import myweb.webvr.food.Food;
import myweb.webvr.food.Res;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.Collections;
import java.util.List;
@Controller
public class ManagerController {
    @Autowired
    private ManagerService managerService;

    @RequestMapping("/manager")
    public String getAllEvents(Model model, HttpSession session) {
        List<Food> food = managerService.getAllFoods();
        List<Res> res = managerService.getAllRestaurants();
        List<Manager> locations = managerService.getAllLocations();
        List<Manager> users = managerService.getAllUser();
        // Lấy thông tin role từ session
        String role = (String) session.getAttribute("role");
        model.addAttribute("foods", food);
        model.addAttribute("res", res);
        model.addAttribute("locations", locations);
        model.addAttribute("users", users);
        model.addAttribute("role", role); // Đưa thông tin role vào Model

        return "manager";
    }
    private final JdbcTemplate jdbcTemplate;

    @Autowired
    public ManagerController(JdbcTemplate jdbcTemplate) {
        this.jdbcTemplate = jdbcTemplate;
    }

    @PostMapping("/saveFood")
    @ResponseBody
    public String saveFood(
            @RequestParam("foodName") String foodName,
            @RequestParam("foodRestaurant") String foodRestaurant,
            @RequestParam("foodPrice") String foodPrice,
            @RequestParam("foodImgLink") String foodImgLink
    ) {
        try {
            jdbcTemplate.update("CALL AddFoodAndMultipleRestaurants(?, ?, ?, ?)",
                    foodName, foodRestaurant, foodPrice, foodImgLink);
            return "Saved successfully!";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }

    @DeleteMapping("/deleteFood/{foodID}")
    @ResponseBody
    public String deleteFood(@PathVariable int foodID) {
        try {
            jdbcTemplate.update("CALL DeleteFoodAndLinks(?)", foodID);
            return "Deleted food with ID: " + foodID + " successfully!";
        } catch (Exception e) {
            return "Error deleting food with ID: " + foodID + ", Error: " + e.getMessage();
        }
    }

    @GetMapping("/comments/{username}")
    @ResponseBody
    public List<Manager> getCommentsByUsername(@PathVariable String username) {
        try {
            String sql = "SELECT * FROM comments WHERE username = ?";
            return jdbcTemplate.query(sql, new Object[]{username}, new BeanPropertyRowMapper<>(Manager.class));
        } catch (Exception e) {
            // Xử lý ngoại lệ nếu có
            e.printStackTrace();
            return Collections.emptyList(); // Trả về danh sách rỗng nếu có lỗi
        }
    }

    @GetMapping("/reported-comments/{username}")
    @ResponseBody
    public List<Manager> getReportedCommentsByUsername(@PathVariable String username) {
        try {
            String sql = "SELECT commentID, username, content, GROUP_CONCAT(DISTINCT reason SEPARATOR ', ') AS reason\n" +
                    "FROM reportedComments\n" +
                    "WHERE username = ? \n" +
                    "GROUP BY commentID, username, content;";
            return jdbcTemplate.query(sql, new Object[]{username}, new BeanPropertyRowMapper<>(Manager.class));
        } catch (Exception e) {
            // Xử lý ngoại lệ nếu có
            e.printStackTrace();
            return Collections.emptyList(); // Trả về danh sách rỗng nếu có lỗi
        }
    }
    @PostMapping("/ban/{name}")
    @ResponseBody
    public String banUser(@PathVariable String name) {
        try {
            jdbcTemplate.update("CALL Ban(?);", name);
            return "Banned user with name: " + name + " successfully!";
        } catch (Exception e) {
            return "Error ban user with name: " + name + ", Error: " + e.getMessage();
        }
    }
    @DeleteMapping("/remove/{name}")
    @ResponseBody
    public String removeUser(@PathVariable String name) {
        try {
            jdbcTemplate.update("CALL DeleteUserAndCommentsByUsername(?)", name);
            return "Deleted user with name: " + name + " successfully!";
        } catch (Exception e) {
            return "Error deleting user with name: " + name + ", Error: " + e.getMessage();
        }
    }
    @PostMapping("/saveLocation")
    @ResponseBody
    public String saveLocationManager(
            @RequestParam("locationName") String locationName,
            @RequestParam("locationLatitude") String locationLatitude,
            @RequestParam("locationLongitude") String locationLongitude
    ) {
        try {
            jdbcTemplate.update("INSERT INTO locations (Name, Latitude, Longitude)\n" +
                            "    VALUES (?, ?, ?);",
                    locationName, locationLatitude, locationLongitude);
            return "Saved successfully!";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
    @PostMapping("/saveRestaurant")
    @ResponseBody
    public String saveRestaurant(
            @RequestParam("restaurantName") String restaurantName,
            @RequestParam("restaurantLatitude") String restaurantLatitude,
            @RequestParam("restaurantLongitude") String restaurantLongitude,
            @RequestParam("restaurantLocate") String restaurantLocate
    ) {
        try {
            jdbcTemplate.update("INSERT INTO restaurants (restaurantName, restaurantLocate, lat, lng)\n" +
                            "    VALUES (?, ?, ?, ?);",
                    restaurantName, restaurantLocate, restaurantLatitude, restaurantLongitude);
            return "Saved successfully!";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
    @DeleteMapping("/deleteRestaurant/{resID}")
    @ResponseBody
    public String deleteRestaurant(@PathVariable int resID) {
        try {
            jdbcTemplate.update("CALL DeleteRestaurantAndFoodRestaurantsByRestaurantID(?)", resID);
            return "Deleted restaurant with ID: " + resID + " successfully!";
        } catch (Exception e) {
            return "Error deleting restaurant with ID: " + resID + ", Error: " + e.getMessage();
        }
    }
    @DeleteMapping("/deleteLocation/{locationID}")
    @ResponseBody
    public String deleteLocation(@PathVariable int locationID) {
        try {
            jdbcTemplate.update("DELETE FROM locations WHERE LocationID = ?", locationID);
            return "Deleted restaurant with ID: " + locationID + " successfully!";
        } catch (Exception e) {
            return "Error deleting restaurant with ID: " + locationID + ", Error: " + e.getMessage();
        }
    }
}
