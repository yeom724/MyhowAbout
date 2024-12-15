package com.springproject.repository;

import java.util.List;
import org.springframework.ui.Model;
import com.springproject.domain.Place;

public interface PlaceRepository {
	
	void addPlace(Place place);
	
	Place getPlace(String placeID);
	
	List<Place> getAllPlace(Model model);
	
	void updatePlace(Place place);
	
	void deletePlace(String placeID);
	
}
