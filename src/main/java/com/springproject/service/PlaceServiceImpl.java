package com.springproject.service;

import java.util.HashMap;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.springproject.domain.deleteplace;
import com.springproject.domain.Place;
import com.springproject.repository.PlaceRepository;

@Service
public class PlaceServiceImpl implements PlaceService{
	
	@Autowired
	PlaceRepository placeRepository;
	

	@Override
	public void addPlace(Place place) { placeRepository.addPlace(place); }

	@Override
	public Place getPlace(String placeID) { return placeRepository.getPlace(placeID); }

	@Override
	public List<Place> getAllPlace(Model model) { return placeRepository.getAllPlace(model); }

	@Override
	public void updatePlace(Place place) { placeRepository.updatePlace(place); }

	@Override
	public void deletePlace(String placeID) { placeRepository.deletePlace(placeID); }


}
