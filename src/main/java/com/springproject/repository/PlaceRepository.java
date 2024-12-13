package com.springproject.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;

import com.springproject.domain.Place;
import com.springproject.domain.Restaurant;

public interface PlaceRepository {
	
	void addPlace(Place place);
	
	void addRestaurant(Restaurant restaurant);
	
	Object getPlace(String placeID);
	
	List<? extends Object> getAllPlace(Model model);
	
	void updatePlace(Place place);
	
	void deletePlace(String placeID);
	
	boolean matchPlace(Place place);
	
	HashMap<String,Boolean> updateMatchPlace(Place place);
	
}
