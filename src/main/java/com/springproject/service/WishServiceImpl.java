package com.springproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Place;
import com.springproject.domain.Wish;
import com.springproject.repository.WishRepository;

@Service
public class WishServiceImpl implements WishService{
	
	@Autowired
	WishRepository wishRepository;

	@Override
	public boolean addWishList(String userId, Place place) { return wishRepository.addWishList(userId, place); }

	@Override
	public List<Wish> getMyList(String userId) { return wishRepository.getMyList(userId); }

	@Override
	public void deleteWish(String placeID, String userId) { wishRepository.deleteWish(placeID, userId); }

}
