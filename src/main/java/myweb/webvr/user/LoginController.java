package myweb.webvr.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class LoginController {

    @Autowired
    UserService userService;

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public ModelAndView showLogin(HttpServletRequest request, HttpServletResponse response) {
        ModelAndView mav = new ModelAndView("login");
        mav.addObject("login", new Login());

        return mav;
    }
    @CrossOrigin(origins = {"https://taib1910442.github.io", "http://localhost:8088"})
    @RequestMapping(value = "/loginProcess", method = RequestMethod.POST)
    public ModelAndView loginProcess(HttpServletRequest request, HttpServletResponse response,
                                     @ModelAttribute("login") Login login) {
        ModelAndView mav = null;

        User user = userService.validateUser(login);

        if (null != user) {
            HttpSession session = request.getSession();
            session.setAttribute("username", user.getUsername());
            session.setAttribute("role", user.getRole());
            if (user.getRole().equals("ROLE_USER")) {
                mav = new ModelAndView("redirect:/");
            } else if (user.getRole().equals("ROLE_ADMIN") || user.getRole().equals("ROLE_MANAGER")) {
                mav = new ModelAndView("redirect:/manager");
            } else if (user.getRole().equals("BANNED")){
                mav = new ModelAndView("login");
                mav.addObject("message", "Tài khoản của bạn đã bị đình chỉ!!");
            }
        } else {
            mav = new ModelAndView("login");
            mav.addObject("message", "Tài khoản hoặc mật khẩu không đúng!!");
        }
        return mav;
    }
    @RequestMapping("/logout")
    public ModelAndView logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.invalidate();

        return new ModelAndView("redirect:/");
    }

}