package com.springproject.repository;

import java.util.List;

import com.springproject.domain.Place;
import com.springproject.domain.Wish;

public interface WishRepository {

	boolean addWishList(String userId, Place place);
	
	List<Wish> getMyList(String userId);
	
	void deleteWish(String placeID, String userId);
	
}
