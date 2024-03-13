package myweb.webvr.WishlistLocation;

import myweb.webvr.dmdiadiem.LocationsObj;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;
import java.util.List;

@RestController
public class WishlistLocationController {

    @Autowired
    private WishlistLocationDao wishlistLocationDao;

    @RequestMapping("/new")
    public ModelAndView newView() {
        // You can add model attributes here if needed
        return new ModelAndView("wishlistMap");
    }
    @RequestMapping("/new2")
    public ModelAndView newView2() {
        // You can add model attributes here if needed
        return new ModelAndView("test");
    }
    @GetMapping("/api/getWishlistLocations")
    public List<WishlistLocation> getWishlistLocations(HttpSession session) {
        String username = (String) session.getAttribute("username");
        if (username != null) {
            return wishlistLocationDao.findByUsername(username);

        } else {
            // Xử lý khi username không có trong session
            return null;
        }
    }
}
