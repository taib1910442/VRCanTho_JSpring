package myweb.webvr.UserProfile;

import java.util.List;

// DAO cho Comments
public interface CommentDAO {
    List<Comment> getCommentsByUsername(String username);
    Comment addComment(Comment comment);
    List<Comment> getAllComments();
    List<Comment> getCommentsByLocationID(int locationID);
}
