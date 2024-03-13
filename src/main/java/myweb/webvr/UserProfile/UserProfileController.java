package myweb.webvr.UserProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserProfileController {

    @Autowired
    private RatingDAO ratingDAO;

    @Autowired
    private WishlistLocationDAO wishlistLocationDAO;

    @Autowired
    private CommentDAO commentDAO;

    @GetMapping("/profile")
    public ModelAndView getUserProfile(HttpSession session) {
        String username = (String) session.getAttribute("username");

        List<Rating> ratings = ratingDAO.getRatingsByUsername(username);

        // Lấy danh sách địa điểm yêu thích
        List<WishlistLocation> wishlistLocations = wishlistLocationDAO.getWishlistLocationsByUsername(username);

        // Lấy danh sách bình luận
        List<Comment> comments = commentDAO.getCommentsByUsername(username);

        // Lưu danh sách vào session
        session.setAttribute("ratings", ratings);
        session.setAttribute("wishlistLocations", wishlistLocations);
        session.setAttribute("comments", comments);

        return new ModelAndView("redirect:/");
    }

}
