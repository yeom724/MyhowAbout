package com.springproject.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.springproject.domain.Place;
import com.springproject.domain.Restaurant;
import com.springproject.repository.PlaceRepository;

@Service
public class PlaceServiceImpl implements PlaceService{
	
	@Autowired
	PlaceRepository placeRepository;

	@Override
	public void addPlace(Place place) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void addRestaurant(Restaurant restaurant) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public Object getPlace(String placeID) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<? extends Object> getAllPlace(Model model) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updatePlace(Place place) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePlace(String placeID) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean matchPlace(Place place) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public HashMap<String, Boolean> updateMatchPlace(Place place) {
		// TODO Auto-generated method stub
		return null;
	}
	
	
//	@Override
//	public Place getPlace(String updateNum) {
//		System.out.println("getPlace 서비스 도착");
//		return placeRepository.getPlace(updateNum);
//	}
//
//	@Override
//	public List<Place> getAllPlace(Model model) {
//		System.out.println("getAllPlace 서비스 도착");
//		return placeRepository.getAllPlace(model);
//	}
//
//	@Override
//	public List<? extends Object> newGetAllPlace(Model model) {
//		System.out.println("newGetAllPlace");
//		return placeRepository.newGetAllPlace(model);
//	}
//
//	@Override
//	public Restaurant getNewPlace(String placeID) {
//		System.out.println("getNewPlace");
//		return placeRepository.getNewPlace(placeID);
//	}

}
