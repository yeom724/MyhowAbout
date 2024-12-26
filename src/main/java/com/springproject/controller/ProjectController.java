package com.springproject.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.net.URL;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springproject.domain.ThreeWeather;

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
