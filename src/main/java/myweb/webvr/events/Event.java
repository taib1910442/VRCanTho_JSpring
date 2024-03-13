package myweb.webvr.events;


public class Event {

    private int eventID;
    private String evName;
    private String evDes;
    private String evContent;
    private Boolean isAnnual;
    private Boolean isLunar;
    private int evDay;
    private int evMonth;
    private String evLocation;

    public int getEventID() {
        return eventID;
    }
    public void setEventID(int eventID) {
        this.eventID = eventID;
    }

    public String getEvName() {
        return evName;
    }
    public void setEvName(String evName) {
        this.evName = evName;
    }

    public String getEvDes() {
        return evDes;
    }
    public void setEvDes(String evDes) {
        this.evDes = evDes;
    }

    public String getEvContent() {
        return evContent;
    }
    public void setEvContent(String evContent) {
        this.evContent = evContent;
    }
    public Boolean getIsAnnual() {
        return isAnnual;
    }
    public void setIsAnnual(Boolean isAnnual) {
        this.isAnnual = isAnnual;
    }
    public Boolean getIsLunar() {
        return isLunar;
    }
    public void setIsLunar(Boolean isLunar) {
        this.isLunar = isLunar;
    }
    public int getEvDay() {
        return evDay;
    }
    public void setEvDay(int evDay) {
        this.evDay = evDay;
    }

    public int getEvMonth() {
        return evMonth;
    }
    public void setEvMonth(int evMonth) {
        this.evMonth = evMonth;
    }

    public String getEvLocation() {
        return evLocation;
    }
    public void setEvLocation(String evLocation) {
        this.evLocation = evLocation;
    }
}
