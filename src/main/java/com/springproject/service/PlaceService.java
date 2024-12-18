package com.springproject.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import org.springframework.ui.Model;

import com.springproject.domain.deleteplace;
import com.springproject.domain.Place;

public interface PlaceService {
	
	void addPlace(Place place);
	
	Place getPlace(String placeID);
	Place getApiPlace(String placeID);
	
	List<Place> getAllPlace(Model model);
	
	void updatePlace(Place place);
	
	void deletePlace(String placeID);
	
	double[] getLocation(String city, String subCity, String country);
	
	void addMapPlaceList(String city, String subCity, String country, ArrayList<Place> list);
	void addMapPlaceList(String keyword, Place place);
	void addMapPlaceList(String keyword, ArrayList<Place> list);
	
	ArrayList<Place> getListOfMap(String city, String subCity, String country);
	ArrayList<Place> getListOfMap(String keyword);
	
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
