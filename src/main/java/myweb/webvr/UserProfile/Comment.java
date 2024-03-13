package myweb.webvr.UserProfile;

// Đối tượng cho bảng Comments
public class Comment {
    private int commentID;
    private String username;
    private int locationID;
    private int replyTo;
    private String content;
    public int getCommentID() {
        return commentID;
    }
    public void setCommentID(int commentID) {
        this.commentID = commentID;
    }
    public int getLocationID() {
        return locationID;
    }
    public void setLocationID(int locationID) {
        this.locationID = locationID;
    }
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }
    public int getReplyTo() {
        return replyTo;
    }
    public void setReplyTo(int replyTo) {
        this.replyTo = replyTo;
    }
    public String getContent() {
        return content;
    }
    public void setContent(String content) {
        this.content = content;
    }
}
