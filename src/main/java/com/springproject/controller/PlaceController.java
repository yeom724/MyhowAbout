package com.springproject.controller;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Properties;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.jsoup.Jsoup;
import org.jsoup.nodes.Document;
import org.jsoup.nodes.Element;
import org.jsoup.select.Elements;
import org.openqa.selenium.By;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springproject.domain.Member;
import com.springproject.domain.Place;
import com.springproject.domain.Restaurant;
import com.springproject.repository.PlaceRepository;
import com.springproject.service.PlaceService;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	private static final String API_KEY = "14cdbb863b4c2d47cee16ab2b06356c6";
	
	@Autowired
	PlaceRepository placeRepository;
	
	@Autowired
	PlaceService placeService;
	
	//모든 페이지 반환 (혹 카테고리별 조회 후 반환)
	@GetMapping("/serchPlaceAll/{range}/{pageNum}")
	public String newGetPlaceList( @PathVariable("range") String select, @PathVariable String pageNum, Model model,
								   @RequestParam(required = false) String city,
								   @RequestParam(required = false) String category,
								   @RequestParam(required = false) String sub) {
		
		if(select.equals("select")) {
			model.addAttribute("city", city);
			model.addAttribute("serchAddr1","/howAbout/place/serchPlaceAll/select/");
			model.addAttribute("serchAddr2", "?city="+city);
			System.out.println("지역 정보를 저장합니다.");
			
			if(category != null && !(category.isEmpty())) {
				model.addAttribute("category", category);
				System.out.println("대분류를 저장합니다.");
				model.addAttribute("serchAddr","/howAbout/place/serchPlaceAll/select/");
				model.addAttribute("serchAddr2", "?city="+city+"&category="+category);
				
				if(sub != null && !(sub.isEmpty())) {
					model.addAttribute("sub", sub);
					System.out.println("소분류 저장합니다.");
					model.addAttribute("serchAddr","/howAbout/place/serchPlaceAll/select/");
					model.addAttribute("serchAddr2", "?city="+city+"&category="+category+"&sub="+sub);

				}
			}
		}
		
		model.addAttribute("select", select);
		model.addAttribute("pageNum", pageNum);
		
		List<? extends Object> place_list = placeService.getAllPlace(model);
		model.addAttribute("place_list", place_list);
		System.out.println("페이지로 이동합니다.");
		
		return "newAllPlace";
	}
	
	//하나의 장소 정보를 반환
	@GetMapping("/newGetOne/{placeID}")
	public String newGetOnePlace(@PathVariable String placeID, Model model) {
		
		Restaurant restaurant = (Restaurant)placeService.getPlace(placeID);
		model.addAttribute("place", restaurant);
		
		return "newOnePlace";
	}
	
	//장소추가 페이지, 관리자만 접근 가능
	@GetMapping("/placeAdd")
	public String placeAddForm(@ModelAttribute Restaurant restaurant, HttpServletRequest req, Model model) {
		
		HttpSession session = req.getSession(false);
		//String result = "redirect:/user/home";
		String result = "newAddPlace";
			
		if(session != null) {
			Member member = (Member)session.getAttribute("userStatus");
			
			if(member != null) {
				
				if(member.getUserId().equals("admin")) {
					result = "newAddPlace";
					
				} else { System.out.println("관리자가 아닙니다."); }
	
			} else { System.out.println("멤버 정보가 없습니다."); };
			
		} else { System.out.println("세션 정보가 없습니다."); };
		
		return result;
	
	}
	
	@ResponseBody
	@PostMapping("/addAPIserch")
	public Object serchAddr(@RequestBody HashMap<String,Object> map) {
		
		try
		{
			
			String address = (String)map.get("address");
			String placeName = (String)map.get("placeName");
			String urlStr = "https://dapi.kakao.com/v2/local/search/address.json?query=" + URLEncoder.encode(address, "UTF-8");
	        URL url = new URL(urlStr);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Authorization", "KakaoAK " + API_KEY);

	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        StringBuilder response = new StringBuilder();
	        String line;
	        
	        while ((line = br.readLine()) != null) { response.append(line); }
	        br.close();
			
		} catch(Exception e) { System.out.println("정보 불러오기에 실패하였습니다."); }
		
		
		
        return null;
		
	}
	
	
//	@GetMapping("/addPlaceForm")
//	public String addPlaceForm(@ModelAttribute Place place, HttpServletRequest req) {
//		System.out.println("권한 확인중...");
//		
//		HttpSession session = req.getSession(false);
//		String result = "redirect:/user/home";
//		
//		if(session != null) {
//			Member member = (Member)session.getAttribute("userStatus");
//			if(member != null) {
//				System.out.println("접근 아이디 : "+member.getUserId());
//				if(member.getUserId().equals("admin")) {
//					System.out.println("관리자 권환 확인 완료");
//					result = "addPlace";
//				} else { System.out.println("관리자가 아닙니다."); }
//
//			} else { System.out.println("멤버 정보가 없습니다."); };
//		} else { System.out.println("세션 정보가 없습니다."); };
//		
//		return result;
//	}
//	
//	@PostMapping("/addPlaceForm")
//	public String addPlace(@ModelAttribute Place place) {
//		System.out.println("시설 정보 생성 컨트롤러 도착");
//		
//		placeService.addPlace(place);
//		
//		return "redirect:/user/home";
//	}
//
//	@ResponseBody
//	@PostMapping("/addAPIserch")
//	public Place serchAddr(@RequestBody HashMap<String,Object> map) {
//		
//		System.out.println("주소 조회를 시작합니다.");
//		String address;
//		
//		if(map.containsKey("juso")) {
//			address = (String)map.get("juso");
//			System.out.println("juso 확인");
//		} else {
//			address = (String)map.get("jibun");
//			System.out.println("jibun 확인");
//		}
//		
//		
//		Place place = null;
//		
//		try {
//			
//			String urlStr = "https://dapi.kakao.com/v2/local/search/address.json?query=" + URLEncoder.encode(address, "UTF-8");
//	        URL url = new URL(urlStr);
//	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
//	        conn.setRequestMethod("GET");
//	        conn.setRequestProperty("Authorization", "KakaoAK " + API_KEY);
//
//	        // 응답 읽기
//	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
//	        StringBuilder response = new StringBuilder();
//	        String line;
//	        while ((line = br.readLine()) != null) {
//	            response.append(line);
//	        }
//	        br.close();
//
//	        // JSON 파싱
//	        JSONObject jsonResponse = new JSONObject(response.toString());
//	        JSONArray documents = jsonResponse.getJSONArray("documents");
//	        
//	        
//	        
//	        if (documents.length() > 0) {
//	            JSONObject location = documents.getJSONObject(0);
//	            place = new Place();
//	            
//	            place.setLatitude(location.getDouble("y"));
//	            place.setLongitude(location.getDouble("x"));
//	            
//	            System.out.println("위도경도 조회 완료, 주소 확인 진입합니다.");
//	            System.out.println(map.containsKey("juso"));
//	            System.out.println(map.containsKey("jibun"));
//	            
//	    		if(map.containsKey("jibun")) {
//	    			JSONObject jsonAddr = location.getJSONObject("road_address");
//	    			System.out.println("지번으로 검색하셨습니다, 도로명 주소를 반환합니다.");
//	    			
//	    			place.setJuso(jsonAddr.getString("address_name"));
//	    			
//	    		} else {
//	    			JSONObject jsonAddr = location.getJSONObject("address");
//	    			System.out.println("도로명 주소로 검색하셨습니다, 지번을 반환합니다.");
//	    			
//	    			place.setJibun(jsonAddr.getString("address_name"));
//	    			
//	    		}
//	            
//	            double latitude = location.getDouble("y"); // 위도
//	            double longitude = location.getDouble("x"); // 경도
//	            System.out.println("위도: " + latitude + ", 경도: " + longitude);
//
//	        } else {
//	            System.out.println("주소: " + address + " - 결과가 없습니다.");
//	        }
//	        
//	        
//		} catch(Exception e) { 
//			System.out.println("조회실패");
//			e.printStackTrace();
//		}
//		
//		return place;
//	}
//	
//	@ResponseBody
//	@PostMapping("/placeAPIserch")
//	public HashMap<String,Boolean> placeAPIserch(@RequestBody HashMap<String,Object> map) {
//		
//		HashMap<String,Boolean> result = new HashMap<String, Boolean>();
//		boolean code = false;
//		
//		Place place = new Place();
//		
//		String jusoPattern = (String)map.get("juso");
//		if(jusoPattern.substring(0, 4).contains("경남")) {
//			jusoPattern = jusoPattern.replaceFirst("경남", "경상남도");
//		}
//		
//		place.setJuso(jusoPattern);
//		
//		String jibunPattern = (String)map.get("jibun");
//		if(jibunPattern.substring(0, 4).contains("경남")) {
//			jibunPattern = jibunPattern.replaceFirst("경남", "경상남도");
//		}
//		
//		place.setJibun(jibunPattern);
//		place.setTitle((String)map.get("title"));
//		DecimalFormat df = new DecimalFormat("#.####");
//		double lax =  Math.floor((Double.parseDouble((String)map.get("latitude"))) * 10000) / 10000;
//		double loy = Math.floor((Double.parseDouble((String)map.get("longitude"))) * 10000) / 10000;
//		place.setLatitude(lax);
//		place.setLongitude(loy);
//		
//		
//		if(map.get("update").equals("ok")) {
//			System.out.println("시설 업데이트 함수로 이동합니다.");
//			place.setUpdateNum(Integer.parseInt((String)map.get("updateNum")));
//			place.setCategory((String)map.get("category"));
//			place.setStatus((String)map.get("status"));
//			place.setFoodCategory((String)map.get("foodCategory"));
//			result = placeService.updateMatchPlace(place);
//			
//		} else {
//			code = placeService.matchPlace(place);
//			result.put("status", code);
//		}
//
//		return result;
//	}
//	
//	@GetMapping("/allPlace/{range}/{pageNum}")
//	public String getPlaceList(@PathVariable("range") String category, @PathVariable("pageNum") String pageNum, Model model,
//							   @RequestParam(value = "city", required = false) String city,
//							   @RequestParam(value = "big", required = false) String big,
//							   @RequestParam(value = "sub", required = false) String sub,
//							   @RequestParam(value = "foodsub", required = false) String foodsub) {
//		
//		if(category.equals("category")) {
//			model.addAttribute("city", city);
//			model.addAttribute("serchAddr1","/howAbout/place/allPlace/"+category+"/");
//			model.addAttribute("serchAddr2", "?city="+city);
//			System.out.println("지역 정보를 저장합니다.");
//			
//			if(big != null && !(big.isEmpty())) {
//				model.addAttribute("big", big);
//				System.out.println("대분류를 저장합니다.");
//				model.addAttribute("serchAddr","/howAbout/place/allPlace/"+category+"/");
//				model.addAttribute("serchAddr2", "?city="+city+"&big="+big);
//				
//				if(sub != null && !(sub.isEmpty())) {
//					model.addAttribute("sub", sub);
//					System.out.println("소분류 저장합니다.");
//					model.addAttribute("serchAddr","/howAbout/place/allPlace/"+category+"/");
//					model.addAttribute("serchAddr2", "?city="+city+"&big="+big+"&sub="+sub);
//					
//					if(foodsub != null && !(foodsub.isEmpty())) {
//						model.addAttribute("foodsub", foodsub);
//						System.out.println("음식분류를 저장합니다.");
//						model.addAttribute("serchAddr","/howAbout/place/allPlace/"+category+"/");
//						model.addAttribute("serchAddr2", "?city="+city+"&big="+big+"&sub="+sub+"&foodsub="+foodsub);
//					}
//				}
//			}
//		}
//		
//		model.addAttribute("category", category);
//		model.addAttribute("pageNum", pageNum);
//		List<Place> place_list = placeService.getAllPlace(model);
//		
//		model.addAttribute("place_list", place_list);
//		System.out.println("페이지로 이동합니다.");
//		
//		return "allPlace";
//	}
//
//	
//	
//	@GetMapping("/update/{updateNum}")
//	public String updatePlaceForm(@PathVariable String updateNum, @ModelAttribute Place place, HttpServletRequest req, Model model) {
//		System.out.println("권한 확인중...");
//		
//		HttpSession session = req.getSession(false);
//		String result = "redirect:/user/home";
//		
//		if(session != null) {
//			Member member = (Member)session.getAttribute("userStatus");
//			if(member != null) {
//				System.out.println("접근 아이디 : "+member.getUserId());
//				if(member.getUserId().equals("admin")) {
//					System.out.println("관리자 권환 확인 완료");
//					result = "addPlace";
//				} else { System.out.println("관리자가 아닙니다."); }
//
//			} else { System.out.println("멤버 정보가 없습니다."); };
//		} else { System.out.println("세션 정보가 없습니다."); };
//		
//		System.out.println("시설 업데이트 Form 화면으로 이동합니다.");
//	
//		Place conPlace = placeService.getPlace(updateNum);
//		
//		
//		if(place == null) {
//			System.out.println("받아온 정보가 없습니다.");
//			result = "/allPlace/all/1";
//		} else {
//			req.setAttribute("update", "ok");
//			model.addAttribute("place",conPlace);
//		}
//		
//		System.out.println(place);
//		return result;
//	}
//	
//	@PostMapping("/update/{updateNum}")
//	public String updatePlace(@PathVariable String updateNum, @ModelAttribute Place place) {
//		System.out.println("업데이트 정보를 받아왔습니다.");
//		
//		if(place.getJuso().substring(0,4).contains("경남")) {
//			place.setJuso(place.getJuso().replaceFirst("경남", "경상남도"));
//		}
//		
//		if(place.getJibun().substring(0,4).contains("경남")) {
//			place.setJibun(place.getJibun().replaceFirst("경남", "경상남도"));
//		}
//		
//		placeService.updatePlace(place);
//		System.out.println("업데이트가 완료되었습니다.");
//		
//		return "redirect:/user/home";
//	}
//	
//	@GetMapping("/delete/{updateNum}")
//	public String deletePlace(@PathVariable String updateNum) {
//		System.out.println("삭제를 진행합니다.");
//		
//		placeService.deletePlace(updateNum);
//		
//		return "redirect:/user/home";
//	}
//	
//	@GetMapping("/getOne/{updateNum}")
//	public String getOnePlaceView(@PathVariable String updateNum, Model model) {
//		
//		Place place = placeService.getPlace(updateNum);
//		model.addAttribute("place", place);
//		
//		Properties properties = new Properties();
//        
//		//파일 위치를 알기 위해서 src/main/java 에 속하는 클래스면 아무거나 가져와도 된다.
//        try (InputStream input = PlaceController.class.getClassLoader().getResourceAsStream("properties/application-API-KEY.properties")) {
//            if (input == null) {
//                System.out.println("죄송합니다, 파일을 찾을 수 없습니다.");
//            }
//            
//            properties.load(input);
//            
//            // 데이터 가져오기
//            String value1 = properties.getProperty("kakao-javaScript-key");
//            model.addAttribute("apiKey", value1);
//            
//            System.out.println("key1: " + value1);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//		return "onePlace";
//	}
//	@GetMapping("/json/start")
//	public void run() {
//		System.out.println("함수실행");
//		placeRepository.run();
//	}
//	
//	@GetMapping("/json/jackson")
//	public void runmobum() {
//		System.out.println("함수실행");
//		placeRepository.runmobum();
//	}
//	
//	@GetMapping("/scrap")
//	public String startScrap() {
//		
//		return "placeex";
//	}
//	
//	@GetMapping("/json/rest")
//	public void jsonRest() {
//		
//		placeRepository.fetchDataFromDatabase();
//		
//	}

//	@GetMapping("/testjsonmenu")
//	public void testjsonmenu(Model model) {
//		
//		model.addAttribute("select","all");
//		model.addAttribute("pageNum", "1");
//		
//		List<? extends Object> list = placeService.newGetAllPlace(model);
//		
//		for(int i=0; i<list.size(); i++) {
//			
//			Restaurant rest = (Restaurant)list.get(i);
//			placeRepository.addRestaurant(rest);
//			System.out.println(rest.getPlaceName() + "끝");
//			
//		}
//	}
//	
//	@PostMapping("/DBconn")
//	public ResponseEntity<String> testWebScrap(@RequestBody List<Restaurant> restaurants) {
//		
//		for(Restaurant rest: restaurants) {
//			
//			try {
//				placeRepository.addRestaurant(rest);
//			} catch(Exception e) {
//				System.out.println("중복데이터가 있으므로 넘어갑니다.");
//			}
//			
//			
//		}
//
//        return ResponseEntity.ok("데이터가 성공적으로 저장되었습니다.");
//        
//	}
	
}
