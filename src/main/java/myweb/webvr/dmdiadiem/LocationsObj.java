package myweb.webvr.dmdiadiem;


import org.springframework.web.multipart.MultipartFile;

public class LocationsObj {
    private int locationID;
    private String name;
    private String description;
    private String address;
    private String latitude;
    private String longitude;
    private String category;
    private MultipartFile ImageFile;
    private String image;
    private String imageThumb;
    public int getLocationID() {
        return locationID;
    }
    public void setLocationID(int locationID) {
        this.locationID = locationID;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public String getDescription() {
        return description;
    }
    public void setDescription(String description) {
        this.description = description;
    }
    public String getAddress() {
        return address;
    }
    public void setAddress(String address) {
        this.address = address;
    }
    public String getLatitude() {
        return latitude;
    }
    public void setLatitude(String latitude) {
        this.latitude = latitude;
    }
    public String getLongitude() {
        return longitude;
    }
    public void setLongitude(String longitude) {
        this.longitude = longitude;
    }
    public String getCategory() {
        return category;
    }
    public void setCategory(String category) {
        this.category = category;
    }
    public void setImage(String image) {
        this.image = image;
    }
    public String getImage() {
        return image;
    }
    public void setImageThumb(String imageThumb) {
        this.imageThumb = imageThumb;
    }
    public String getImageThumb() {
        return imageThumb;
    }
    public MultipartFile getImageFile() {
        return ImageFile;
    }

    public void setImageFile(MultipartFile ImageFile) {
        this.ImageFile = ImageFile;
    }
}


