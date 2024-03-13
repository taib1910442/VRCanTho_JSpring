package myweb.webvr.map;

public class Restaurant {
    private int restaurantID;
    private String restaurantName;
    private String restaurantLocate;
    private String lat;
    private String lng;

    public int getRestaurantID() {
        return restaurantID;
    }

    public void setRestaurantID(int restaurantID) {
        this.restaurantID = restaurantID;
    }

    public String getRestaurantName() {
        return restaurantName;
    }

    public void setRestaurantName(String restaurantName) {
        this.restaurantName = restaurantName;
    }

    public String getRestaurantLocate() {
        return restaurantLocate;
    }

    public void setRestaurantLocate(String restaurantLocate) {
        this.restaurantLocate = restaurantLocate;
    }

    public String getLat() {
        return lat;
    }

    public void setLat(String lat) {
        this.lat = lat;
    }

    public String getLng() {
        return lng;
    }

    public void setLng(String lng) {
        this.lng = lng;
    }
}
