package com.springproject.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.mysql.cj.Session;
import com.springproject.domain.Member;
import com.springproject.domain.ThreeWeather;

@Controller
@RequestMapping("/weather")
public class WeatherController {
	
	@ResponseBody
	@GetMapping("/callThree")
	public Map<String, ArrayList> wheather(HttpServletRequest req) throws IOException {
		
		HttpSession session = req.getSession(false);
		Map<String, ArrayList> data = new HashMap<String, ArrayList>();
		String userNx = "90";
		String userNy = "77";
		
		if(session != null) {
			Member user = (Member)session.getAttribute("userStatus");
			if(user != null) {
				userNx = String.valueOf(user.getNx());
				userNy = String.valueOf(user.getNy());
			}
		}

        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMdd");
        String formattedDate = today.format(formatter);
        
        String one = (today.plusDays(1)).format(formatter);
        String two = (today.plusDays(2)).format(formatter);
        String three = (today.plusDays(3)).format(formatter);

        try {
        	
        	StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
        	
			urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=8a5yxDAXFyOyai1ZLcXy%2FdG0jSa2vqtKlUPxIBP1aELcn7jSpmLosDgAM%2BAVZJ8P2ELqQf8EejHNeyb3e5W3wQ%3D%3D");
			urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("1000", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("dataType","UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
	        urlBuilder.append("&" + URLEncoder.encode("base_date","UTF-8") + "=" + URLEncoder.encode(formattedDate, "UTF-8")); /*‘21년 6월 28일 발표*/
	        urlBuilder.append("&" + URLEncoder.encode("base_time","UTF-8") + "=" + URLEncoder.encode("0500", "UTF-8")); /*06시30분 발표(30분 단위)*/
	        urlBuilder.append("&" + URLEncoder.encode("nx","UTF-8") + "=" + URLEncoder.encode(userNx, "UTF-8")); /*예보지점 X 좌표값*/
	        urlBuilder.append("&" + URLEncoder.encode("ny","UTF-8") + "=" + URLEncoder.encode(userNy, "UTF-8")); /*예보지점 Y 좌표값*/
	        URL url = new URL(urlBuilder.toString());
	        
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        
	        StringBuilder sb = new StringBuilder();
	        String line;
	        
	        while ((line = rd.readLine()) != null) { sb.append(line); }
	        
	        rd.close();
	        conn.disconnect();
	        
	        JSONObject json = new JSONObject(sb.toString());
	        JSONObject response = json.getJSONObject("response");
	        JSONObject body = response.getJSONObject("body");
	        JSONObject items = body.getJSONObject("items");
	        JSONArray item = items.getJSONArray("item");
	        
	        List<ThreeWeather> list = new ArrayList<ThreeWeather>();
	        ObjectMapper objectMapper = new ObjectMapper(); //JACKSON objectMapper 생성, 이게 있어야 파싱이 가능함
	        
	        for(int i=0; i<item.length(); i++) {
	        	
	        	JSONObject we = item.getJSONObject(i);
	        	String jsonString = we.toString(); //받아온 JSON객체를 문자열로 출력
	        	ThreeWeather whe = objectMapper.readValue(jsonString, ThreeWeather.class); //저장한 문자열을 객체에 파싱
	        	
	        	list.add(whe);
	        }
	        
	        ArrayList<ThreeWeather> listOne = new ArrayList<ThreeWeather>();
	        ArrayList<ThreeWeather> listTwo = new ArrayList<ThreeWeather>();
	        ArrayList<ThreeWeather> listThree = new ArrayList<ThreeWeather>();
	        
	        
	        for(int i=0; i<list.size(); i++) {
	        	ThreeWeather whe = list.get(i);
	        	
	        	if((whe.getFcstDate().equals(one))&&(whe.getCategory().equals("TMX")||whe.getCategory().equals("TMN"))) { listOne.add(whe); }
	        	if((whe.getFcstDate().equals(two))&&(whe.getCategory().equals("TMX")||whe.getCategory().equals("TMN"))) { listTwo.add(whe); }
	        	if((whe.getFcstDate().equals(three))&&(whe.getCategory().equals("TMX")||whe.getCategory().equals("TMN"))) { listThree.add(whe); }	
	        	
	        }
	        
	        data.put("one", listOne);
	        data.put("two", listTwo);
	        data.put("three", listThree);
	        
		} catch (UnsupportedEncodingException e) { e.printStackTrace(); }
        
        return data;
        
	}
}
