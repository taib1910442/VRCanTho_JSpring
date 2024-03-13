package myweb.webvr.UserProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
public class FeedbackController {
    private final CommentDAO commentDAO;
    private final RatingDAO ratingDAO;
    private final JdbcTemplate jdbcTemplate;
    @Autowired
    public FeedbackController(CommentDAO commentDAO, RatingDAO ratingDAO, JdbcTemplate jdbcTemplate) {
        this.commentDAO = commentDAO;
        this.ratingDAO = ratingDAO;
        this.jdbcTemplate = jdbcTemplate;
    }
    @RequestMapping("/feedback/{locationID}")
    public String showFeedback(Model model, HttpSession session, @PathVariable int locationID) {
        // Lấy username từ session
        String username = (String) session.getAttribute("username");
        String role = (String) session.getAttribute("role");
        // Lấy danh sách comments theo locationID từ DAO
        List<Comment> comments = commentDAO.getCommentsByLocationID(locationID);

        // Tạo danh sách filteredComments chỉ chứa các comment có replyTo bằng 0
        List<Comment> filteredComments = new ArrayList<>();
        // Tạo danh sách commentsWithReplyTo chỉ chứa các comment có replyTo khác 0
        List<Comment> commentsWithReplyTo = new ArrayList<>();
        for (Comment comment : comments) {
            if (comment.getReplyTo() == 0) {
                filteredComments.add(comment);
            } else {
                commentsWithReplyTo.add(comment);
            }
        }

        List<Rating> ratings = ratingDAO.getRatingsByLocationID(locationID);
        model.addAttribute("role", role);
        model.addAttribute("username", username); // Đặt username vào model
        model.addAttribute("filteredComments", filteredComments); // Chỉ truyền danh sách filteredComments
        model.addAttribute("comments", commentsWithReplyTo); // Chỉ truyền danh sách commentsWithReplyTo
        model.addAttribute("ratings", ratings);
        model.addAttribute("locationID", locationID);

        return "feedback";  // Trả về view "feedback"
    }



    @DeleteMapping("/deleteComment/{commentID}")
    @ResponseBody
    public String deleteComment(@PathVariable int commentID) {
        try {
            jdbcTemplate.update("CALL DeleteCommentByID(?)", commentID);
            return "Deleted Comment with ID: " + commentID + " successfully!";
        } catch (Exception e) {
            return "Error deleting Comment with ID: " + commentID + ", Error: " + e.getMessage();
        }
    }

    @PostMapping("/reportedComment")
    @ResponseBody
    public String saveFood(
            @RequestParam("commentID") String commentID,
            @RequestParam("reason") String reason
    ) {
        try {
            jdbcTemplate.update("CALL ReportedCommentByID(?, ?)",
                    commentID, reason);
            return "Report successfully!";
        } catch (Exception e) {
            return "Error: " + e.getMessage();
        }
    }
}
