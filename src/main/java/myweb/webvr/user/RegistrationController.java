package myweb.webvr.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class RegistrationController {
    @Autowired
    public UserService userService;

    @RequestMapping(value = "/register", method = RequestMethod.GET)
    public ModelAndView showRegister() {
        ModelAndView mav = new ModelAndView("register");
        mav.addObject("user", new User());

        return mav;
    }

    /*@RequestMapping(value = "/registerProcess", method = RequestMethod.POST)
    public ModelAndView addUser(HttpServletRequest request,
                                @ModelAttribute("user") User user) {

        userService.register(user);
        HttpSession session = request.getSession();
        session.setAttribute("username", user.getUsername());
        return new ModelAndView("welcome");
    }*/
    @RequestMapping(value = "/registerProcess", method = RequestMethod.POST)
    public ModelAndView addUser(HttpServletRequest request, HttpServletResponse response,
                                @ModelAttribute("user") User user) {
        ModelAndView mav = new ModelAndView();
        HttpSession session = request.getSession();
        session.setAttribute("username", user.getUsername());
        if (userService.isUsernameExists(user.getUsername())) {
            mav.setViewName("register");
            mav.addObject("user", user);
            mav.addObject("message", "Tên đã được đăng ký hoặc chứa ký tự không hợp lệ!");
        } else {
            userService.register(user);
            mav.setViewName("redirect:/");
            mav.addObject("name", user.getUsername());
        }

        return mav;
    }

}
