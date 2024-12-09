package com.springproject.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;

import com.springproject.domain.Place;

public interface PlaceService {
	
	void addPlace(Place place);
	
	Place getPlace(String updateNum);
	
	List<Place> getAllPlace(Model model);
	
	void updatePlace(Place place);
	
	void deletePlace(String updateNum);
	
	boolean matchPlace(Place place);
	
	HashMap<String,Boolean> updateMatchPlace(Place place);
}
