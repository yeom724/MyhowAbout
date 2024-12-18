package com.springproject.service;

import java.util.ArrayList;
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
	public Place getApiPlace(String placeID) { return placeRepository.getApiPlace(placeID); }

	@Override
	public List<Place> getAllPlace(Model model) { return placeRepository.getAllPlace(model); }

	@Override
	public void updatePlace(Place place) { placeRepository.updatePlace(place); }

	@Override
	public void deletePlace(String placeID) { placeRepository.deletePlace(placeID); }

	@Override
	public double[] getLocation(String city, String subCity, String country) { return placeRepository.getLocation(city, subCity, country); }

	@Override
	public void addMapPlaceList(String city, String subCity, String country, ArrayList<Place> list) { placeRepository.addMapPlaceList(city, subCity, country, list); }
	
	@Override
	public void addMapPlaceList(String keyword, ArrayList<Place> list) { placeRepository.addMapPlaceList(keyword, list); }
	
	@Override
	public void addMapPlaceList(String keyword, Place place) { placeRepository.addMapPlaceList(keyword, place); }
	
	@Override
	public ArrayList<Place> getListOfMap(String city, String subCity, String country) { return placeRepository.getListOfMap(city, subCity, country); }

	@Override
	public ArrayList<Place> getListOfMap(String keyword) { return placeRepository.getListOfMap(keyword); }





	


}
