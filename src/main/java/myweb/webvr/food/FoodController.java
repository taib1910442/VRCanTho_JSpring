package myweb.webvr.food;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/food")
public class FoodController {

    @Autowired
    private FoodDAO foodDAO;
    @Autowired
    private ResDAO resDAO;

    @GetMapping
    public String showFood(Model model) {
        // Lấy danh sách món ăn (foods) và danh sách nhà hàng (restaurants) từ cơ sở dữ liệu
        List<Food> foods = foodDAO.getAllFoods();
        List<Res> restaurants = resDAO.getAllRestaurants();

        model.addAttribute("foods", foods);
        model.addAttribute("restaurants", restaurants);

        return "food"; // Trả về view "food.jsp"
    }
}
