package myweb.webvr.UserProfile;

import java.util.List;

public interface WishlistLocationDAO {
    List<WishlistLocation> getWishlistLocationsByUsername(String username);
}
