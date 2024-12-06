package com.springproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.ui.Model;

import com.springproject.domain.Place;
import com.springproject.repository.PlaceRepository;

@Service
public class PlaceServiceImpl implements PlaceService{
	
	@Autowired
	PlaceRepository placeRepository;

	@Override
	public void addPlace(Place place) {
		System.out.println("addPlace 서비스 도착");
		placeRepository.addPlace(place);
	}

	@Override
	public Place getPlace(String updateNum) {
		System.out.println("getPlace 서비스 도착");
		return placeRepository.getPlace(updateNum);
	}

	@Override
	public void updatePlace(Place place) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deletePlace(Place place) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public boolean matchPlace(Place place) {
		
		System.out.println("matchPlace 서비스 도착");
		return placeRepository.matchPlace(place);
		
	}

	@Override
	public List<Place> getAllPlace(Model model) {
		System.out.println("getAllPlace 서비스 도착");
		return placeRepository.getAllPlace(model);
	}

	@Override
	public boolean updateMatchPlace(Place place) {
		// TODO Auto-generated method stub
		return false;
	}

}
