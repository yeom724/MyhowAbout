package com.springproject.service;

import java.util.List;

import com.springproject.domain.Place;
import com.springproject.domain.Wish;

public interface WishService {
	
	boolean addWishList(String userId, Place place);
	
	List<Wish> getMyList(String userId);

	void deleteWish(String placeID, String userId);
}
