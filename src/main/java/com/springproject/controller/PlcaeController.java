package com.springproject.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springproject.repository.PlaceRepository;

@Controller
@RequestMapping("/json")
public class PlcaeController {
	
	@Autowired
	PlaceRepository placeRepository;
	
	@GetMapping("/start")
	public void run() {
		System.out.println("함수실행");
		placeRepository.run();
	}
}
