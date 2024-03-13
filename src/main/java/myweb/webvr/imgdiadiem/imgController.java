package myweb.webvr.imgdiadiem;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@CrossOrigin
@RequestMapping("/api")
public class imgController {

    @Qualifier("imgDAOImpl")
    @Autowired
    private imgDAO imgDAO;
    @CrossOrigin
    @RequestMapping(value = "/location/{id}", method = RequestMethod.GET)
    public ResponseEntity<imgObj> getLocationById(@PathVariable int id) {
        imgObj img = imgDAO.getLocationById(id);
        if (img != null) {
            return new ResponseEntity<>(img, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @RequestMapping(value = "/locationCoor/{id}", method = RequestMethod.GET)
    public ResponseEntity<imgObj> getCoordinatesById(@PathVariable int id) {
        imgObj Coo = imgDAO.getCoordinatesById(id);
        if (Coo != null) {
            return new ResponseEntity<>(Coo, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
    @GetMapping("/locations")
    public ResponseEntity<List<imgObj>> getAllLocations() {
        List<imgObj> img = imgDAO.getAllLocations();
        if (!img.isEmpty()) {
            return new ResponseEntity<>(img, HttpStatus.OK);
        } else {
            return new ResponseEntity<>(HttpStatus.NOT_FOUND);
        }
    }
}
