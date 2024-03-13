package myweb.webvr.dmdiadiem;

import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.ObjectMetadata;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.List;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.ResponseBody;
@Controller
public class LocationsController {

    @Qualifier("locationsDAOImpl")
    @Autowired
    private LocationsDAO locationsDAO;

    @RequestMapping("/locations")
    public ModelAndView showLocations() {
        List<LocationsObj> locationsList = locationsDAO.getAllLocations();
        ModelAndView mav = new ModelAndView("locationsPage");
        mav.addObject("locations", locationsList);
        return mav;
    }
    @RequestMapping("/locationsList")
    public ModelAndView showLocationsList() {
        List<LocationsObj> locationsList = locationsDAO.getAllLocations();
        ModelAndView mav = new ModelAndView("locations");
        mav.addObject("locationsList", locationsList);
        return mav;
    }
   /*@PostMapping("/search")
   public String searchLocations(@RequestParam("keyword") String keyword, Model model) throws UnsupportedEncodingException {
       String decodedKeyword = URLDecoder.decode(keyword, "UTF-8"); // Giải mã từ khóa
       List<LocationsObj> location = locationsDAO.searchLocations(decodedKeyword);
       model.addAttribute("location", location);
       return "searchResults"; // Trả về trang hiển thị kết quả
   }*/

    @RequestMapping("/search")
    public ModelAndView searchLocations(@RequestParam(value = "keyword", required = false) String keyword, Model model, HttpSession session) {
        if (session.getAttribute("comment") == null) {
            return new ModelAndView("redirect:/commentAll");
        }
        List<LocationsObj> locationsList;
        if (keyword != null && !keyword.isEmpty()) {
            locationsList = locationsDAO.searchLocations(keyword);
            model.addAttribute("location", locationsList);
            return new ModelAndView("locations");
        } else {
            locationsList = locationsDAO.getAllLocations();
            model.addAttribute("locationsList", locationsList);
            return new ModelAndView("locations");
        }
    }

    @RequestMapping("/addLocation")
    public String showAddLocationForm(Model model) {
        model.addAttribute("location", new LocationsObj());
        return "addLocationForm";
    }

    @RequestMapping(value = "/saveL", method = RequestMethod.POST)
    public String saveLocation(@ModelAttribute("location") LocationsObj location) {
        locationsDAO.addLocation(location);
        return "manager";
    }
    @Autowired
    private AmazonS3Client amazonS3Client; // Inject your AmazonS3Client bean here

    @RequestMapping(value = "/uploadImage", method = RequestMethod.POST)
    public String uploadImage(@RequestParam("locationID") int locationID,
                              @RequestParam("imageFile") MultipartFile imageFile,
                              HttpServletRequest request) {
        LocationsObj location = locationsDAO.getLocationByID(locationID);

        if (location != null) {
            String imageName = "location_" + locationID + "_" + imageFile.getOriginalFilename();
            // ...
            try {
                // Lưu hình ảnh vào thư mục tạm trên server
                String tempImagePath = request.getServletContext().getRealPath("/resoures/img/") + "/" + imageName; // Đường dẫn tới thư mục tạm
                File tempImageFile = new File(tempImagePath);
                imageFile.transferTo(tempImageFile);

                // Cập nhật tên hình vào cơ sở dữ liệu
                locationsDAO.updateImageURL(locationID, imageName);

                return "redirect:/locations"; // Redirect về trang danh sách địa điểm
            } catch (IOException e) {
                e.printStackTrace();
                // Xử lý exception
            }
// ...

        }

        return "error"; // Xử lý khi không tìm thấy địa điểm
    }

    @GetMapping("/location/{id}")
    public String getLocationCoorById(@PathVariable int id, Model model) {
        LocationsObj location = locationsDAO.getLocationCoorById(id);
        model.addAttribute("location", location);
        return "map"; //
    }
}

