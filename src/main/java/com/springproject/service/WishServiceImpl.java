package com.springproject.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Place;
import com.springproject.repository.WishRepository;

@Service
public class WishServiceImpl implements WishService{
	
	@Autowired
	WishRepository wishRepository;

	@Override
	public boolean addWishList(String userId, Place place) { return wishRepository.addWishList(userId, place); }

}
