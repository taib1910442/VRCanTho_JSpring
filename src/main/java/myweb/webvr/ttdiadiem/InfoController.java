package myweb.webvr.ttdiadiem;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/info")
public class InfoController {
    private final InfoDAO infoDAO;

    @Autowired
    public InfoController(InfoDAO infoDAO) {
        this.infoDAO = infoDAO;
    }
    @CrossOrigin(origins = {"https://taib1910442.github.io", "http://localhost:8088"})

    @GetMapping("/{id}")
    public ModelAndView getInfo(@PathVariable("id") int infoId, HttpSession session) {
        Info info = infoDAO.getInfoById(infoId);

        // Lấy thông tin role từ session
        String role = (String) session.getAttribute("role");

        ModelAndView modelAndView = new ModelAndView("infoPage");
        modelAndView.addObject("info", info);
        modelAndView.addObject("role", role); // Đưa thông tin role vào ModelAndView
        return modelAndView;
    }

    @PostMapping("/{id}/update")
    public String updateInfoDescription(@PathVariable("id") int infoId, @RequestParam("newDescription") String newDescription) {
        infoDAO.updateInfoDescription(infoId, newDescription);
        return "redirect:/info/" + infoId;
    }
}
