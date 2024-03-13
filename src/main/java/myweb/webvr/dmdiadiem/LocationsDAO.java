package myweb.webvr.dmdiadiem;

import java.util.List;

public interface LocationsDAO {
    List<LocationsObj> getAllLocations();
    void addLocation(LocationsObj location);
    LocationsObj getLocationByID(int locationID);
    LocationsObj getLocationCoorById(int locationID);
    //void updateLocation(LocationsObj location);
    void updateImageURL(int locationID, String imageURL);
    //List<LocationsObj> searchLocationsByName(String name);
    List<LocationsObj> searchLocations(String keyword);
}


