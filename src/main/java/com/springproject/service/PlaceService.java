package com.springproject.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;

import com.springproject.domain.Place;
import com.springproject.domain.Restaurant;

public interface PlaceService {
	
	void addPlace(Place place);
	
	void addRestaurant(Restaurant restaurant);
	
	Object getPlace(String placeID);
	
	List<? extends Object> getAllPlace(Model model);
	
	void updatePlace(Place place);
	
	void deletePlace(String placeID);
	
	boolean matchPlace(Place place);
	
	HashMap<String,Boolean> updateMatchPlace(Place place);
	
//	void addPlace(Place place);
//	
//	Place getPlace(String updateNum);
//	Restaurant getNewPlace(String placeID);
//	
//	List<Place> getAllPlace(Model model);
//	List<? extends Object> newGetAllPlace(Model model);
//	
//	void updatePlace(Place place);
//	
//	void deletePlace(String updateNum);
//	
//	boolean matchPlace(Place place);
//	
//	HashMap<String,Boolean> updateMatchPlace(Place place);
	
	
}
