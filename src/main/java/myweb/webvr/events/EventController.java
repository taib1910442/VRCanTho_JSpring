package myweb.webvr.events;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class EventController {

    @Autowired
    private EventService eventService;

    @CrossOrigin(origins = {"https://taib1910442.github.io", "http://localhost:8088"})

    @RequestMapping("/events")
    public String getAllEvents(Model model, HttpSession session) {
        List<Event> events = eventService.getAllEvents();
        List<Event> randomEvents = eventService.getRandomEvents();

        // Lấy thông tin role từ session
        String role = (String) session.getAttribute("role");

        model.addAttribute("randomEvents", randomEvents);
        model.addAttribute("events", events);
        model.addAttribute("role", role); // Đưa thông tin role vào Model

        return "event";
    }

    @GetMapping("/events/details")
    @ResponseBody
    public ResponseEntity<Event> getEventDetails(@RequestParam int id) {
        Event event = eventService.getEventById(id);

        if (event != null) {
            return new ResponseEntity<>(event, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @PostMapping("/events/add")
    public String addEvent(@ModelAttribute("event") Event event) {
        eventService.addEvent(event);
        return "redirect:../events#expand";
    }
    @PostMapping("/events/{id}/update")
    public String updateInfoDescription(@PathVariable("id") int eventID, @RequestParam("newContent") String newContent) {
        eventService.updateEvent(eventID, newContent);
        return "redirect:/events#expand";
    }
    @PostMapping("/events/{id}/delete")
    public String deleteEvent(@PathVariable int id, RedirectAttributes redirectAttributes) {
        boolean isDeleted = eventService.deleteEventById(id);

        if (isDeleted) {
            redirectAttributes.addFlashAttribute("successMessage", "Sự kiện đã được xóa thành công.");
        } else {
            redirectAttributes.addFlashAttribute("errorMessage", "Không thể xóa sự kiện. Vui lòng thử lại.");
        }

        return "redirect:/events#expand";
    }

}

