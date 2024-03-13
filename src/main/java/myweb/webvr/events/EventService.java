package myweb.webvr.events;

import java.util.List;

public interface EventService {
    List<Event> getAllEvents();
    List<Event> getRandomEvents();
    Event getEventById(int eventID);
    void addEvent(Event event);
    void updateEvent(int eventID, String newContent);
    boolean deleteEventById(int eventID);
}
