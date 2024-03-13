package myweb.webvr.UserProfile;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@CrossOrigin
@RequestMapping("/api/comments")
public class CommentController {

    @Autowired
    private CommentDAO commentDAO;
    @CrossOrigin
    @PostMapping("/add")
    public ResponseEntity<?> addComment(@RequestBody Comment commentRequest) {
        // CommentRequest là một lớp chứa thông tin comment từ máy khách
        // Bạn cần tạo lớp này để phù hợp với dữ liệu mà máy khách gửi lên

        // Xử lý và lưu trữ comment vào cơ sở dữ liệu
        Comment comment = commentDAO.addComment(commentRequest);

        if (comment != null) {
            return new ResponseEntity<>(comment, HttpStatus.CREATED);
        } else {
            return new ResponseEntity<>("Failed to add comment", HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }
}
