package com.springproject.repository;

import com.springproject.domain.Place;

public interface PlaceRepository {
	
	void addPlace(Place place);
	
	Place getPlace(Place place);
	
	void updatePlace(Place place);
	
	void deletePlace(Place place);
	
	void run();
	
	void getCoordinates(Place obj) throws Exception;
	
}
