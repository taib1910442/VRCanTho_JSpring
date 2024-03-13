package myweb.webvr.imgdiadiem;
import myweb.webvr.dmdiadiem.LocationsObj;
import myweb.webvr.imgdiadiem.imgObj;

import java.util.List;

public interface imgDAO {
        imgObj getLocationById(int locationID);
        imgObj getCoordinatesById(int locationID);
        List<imgObj> getAllLocations();
}
