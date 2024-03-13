package myweb.webvr.danhgiaApi;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@RestController
@RequestMapping("/rate")
public class RatingController {

    private final RatingDAO ratingDAO;

    @Autowired
    public RatingController(RatingDAO ratingDAO) {
        this.ratingDAO = ratingDAO;
    }

    @GetMapping("/location")
    public Double getAverageRatingByLocationID(@RequestParam("locationID") int locationID) {
        return ratingDAO.getAverageRatingByLocationID(locationID);
    }
    @GetMapping("/locationTotalRate")
    public Long getTotalRatingCountByLocationID(@RequestParam("locationID") int locationID) {
        return ratingDAO.getTotalRatingCountByLocationID(locationID);
    }
}

