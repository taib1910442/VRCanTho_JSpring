package myweb.webvr.ttdiadiem;

public interface InfoDAO {
    Info getInfoById(int infoId);
    void updateInfoDescription(int infoId, String newDescription);
}

