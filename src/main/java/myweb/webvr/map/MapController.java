package myweb.webvr.map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/map")
public class MapController {

    @Autowired
    private LocationDAO locationDAO;
    @Autowired
    private RestaurantDAO restaurantDAO;

    @GetMapping
    public String showMap(Model model) {
        // Lấy danh sách địa điểm (locations) và nhà hàng (restaurants) từ cơ sở dữ liệu
        List<Location> locations = locationDAO.getAllLocations();
        List<Restaurant> restaurants = restaurantDAO.getAllRestaurants();

        model.addAttribute("locations", locations);
        model.addAttribute("restaurants", restaurants);

        return "map"; // Trả về view "map.jsp"
    }
}

