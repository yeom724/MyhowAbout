package com.springproject.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/map")
public class ProjectController {
	
	@GetMapping("/serch")
	public String test() {
		return "mapAdd";
	}
	
	@GetMapping("/length")
	public String test2() {
		return "maplength";
	}
	
	@GetMapping("/abc")
	public String test3() {
		return "maptest";
	}
}
