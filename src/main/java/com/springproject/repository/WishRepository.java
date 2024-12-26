package com.springproject.repository;

import com.springproject.domain.Place;

public interface WishRepository {

	boolean addWishList(String userId, Place place);
	
}
