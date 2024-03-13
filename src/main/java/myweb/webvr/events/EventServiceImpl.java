package myweb.webvr.events;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EventServiceImpl implements EventService {

    @Autowired
    private EventDAO eventDAO;

    @Override
    public List<Event> getAllEvents() {
        return eventDAO.getAllEvents();
    }
    @Override
    public List<Event> getRandomEvents() {
        return eventDAO.getRandomEvents();
    }
    @Override
    public Event getEventById(int eventID) {
        return eventDAO.getEventById(eventID);
    }
    @Override
    public void addEvent(Event event) {
        eventDAO.addEvent(event);
    }
    @Override
    public void updateEvent(int eventID, String newContent) {
        eventDAO.updateEvent(eventID,newContent);
    }
    @Override
    public boolean deleteEventById(int eventID) {
        eventDAO.deleteEventById(eventID);
        return false;
    }
}
