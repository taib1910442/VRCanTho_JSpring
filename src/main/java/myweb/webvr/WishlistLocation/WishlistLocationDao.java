package myweb.webvr.WishlistLocation;

import java.util.List;

public interface WishlistLocationDao {
    List<WishlistLocation> findByUsername(String username);
}
