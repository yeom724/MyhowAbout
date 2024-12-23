package com.springproject.repository;

import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;

import com.springproject.domain.Place;

public interface PlaceRepository {
	
	void addPlace(Place place);
	
	Place getPlace(String updateNum);
	
	List<Place> getAllPlace(Model model);
	
	void updatePlace(Place place);
	
	void deletePlace(String updateNum);
	
	void run();
	void runmobum();
	
	void getCoordinates(Place obj) throws Exception;
	
	boolean matchPlace(Place place);
	
	HashMap<String,Boolean> updateMatchPlace(Place place);
	
}
