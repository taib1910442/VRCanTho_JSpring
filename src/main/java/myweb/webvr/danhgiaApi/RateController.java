package myweb.webvr.danhgiaApi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/rate")
public class RateController {
    private RatingDAO ratingDAO;

    @Autowired
    public void RatingController(RatingDAO ratingDAO) {
        this.ratingDAO = ratingDAO;
    }

    public RateController(RatingDAO ratingDAO) {
        this.ratingDAO = ratingDAO;
    }

    @PostMapping("/rating")
    public ModelAndView submitRating(@RequestParam("locationID") int locationID,
                                     @RequestParam("rate") Integer ratingValue,
                                     @RequestParam("comment") String comment,
                                     HttpSession session) {
        // Lấy username từ session
        String username = (String) session.getAttribute("username");

        // Tạo một đối tượng Rating
        Rating rating = new Rating();
        rating.setUsername(username);
        rating.setLocationID(locationID);
        rating.setRatingValue(ratingValue);
        rating.setComment(comment);

        // Lưu đánh giá vào cơ sở dữ liệu
        ratingDAO.saveRating(rating);

        // Chuyển hướng hoặc trả về trang mà bạn muốn sau khi gửi đánh giá thành công
        ModelAndView modelAndView = new ModelAndView("redirect:/search");
        modelAndView.addObject("resultMessage", "Đánh giá đã được gửi thành công!");
        return modelAndView;
    }
}
