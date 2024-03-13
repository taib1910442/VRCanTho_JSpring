package myweb.webvr.UserProfile;

import myweb.webvr.dmdiadiem.LocationsObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class GetAllCmt {
    @Autowired
    private CommentDAO commentDAO;
    @RequestMapping("/commentAll")
    public ModelAndView getAllComments(HttpSession session) {
        List<Comment> comment = commentDAO.getAllComments();
        session.setAttribute("comment", comment);
        return new ModelAndView("redirect:/search"); // Sử dụng tên view thích hợp ở đây
    }
}
