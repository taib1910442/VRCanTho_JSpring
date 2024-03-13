package myweb.webvr.events;

import java.util.List;

public interface EventDAO {
    List<Event> getAllEvents();
    List<Event> getRandomEvents();
    Event getEventById(int eventID);
    void addEvent(Event event);
    void updateEvent(int eventID, String newContent);
    void deleteEventById(int eventID);
}

