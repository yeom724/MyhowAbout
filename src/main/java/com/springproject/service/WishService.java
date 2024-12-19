package com.springproject.service;

import com.springproject.domain.Place;

public interface WishService {
	
	void addWishList(String userId, Place place);
	
}
