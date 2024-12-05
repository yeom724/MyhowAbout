package com.springproject.controller;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DecimalFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
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

import com.springproject.domain.Member;
import com.springproject.domain.Place;
import com.springproject.repository.PlaceRepository;
import com.springproject.service.PlaceService;

@Controller
@RequestMapping("/place")
public class PlcaeController {
	
	private static final String API_KEY = "20643075f94a998f4e14a1853f11935c";
	
	@Autowired
	PlaceRepository placeRepository;
	
	@Autowired
	PlaceService placeService;
	
	@GetMapping("/json/start")
	public void run() {
		System.out.println("함수실행");
		placeRepository.run();
	}
	
	@GetMapping("/addPlaceForm")
	public String addPlaceForm(@ModelAttribute Place place, HttpServletRequest req) {
		System.out.println("권한 확인중...");
		
		HttpSession session = req.getSession(false);
		String result = "redirect:/user/home";
		
		if(session != null) {
			Member member = (Member)session.getAttribute("userStatus");
			if(member != null) {
				System.out.println("접근 아이디 : "+member.getUserId());
				if(member.getUserId().equals("admin")) {
					System.out.println("관리자 권환 확인 완료");
					result = "addPlace";
				} else { System.out.println("관리자가 아닙니다."); }

			} else { System.out.println("멤버 정보가 없습니다."); };
		} else { System.out.println("세션 정보가 없습니다."); };
		
		return result;
	}
	
	@PostMapping("/addPlaceForm")
	public String addPlace(@ModelAttribute Place place) {
		System.out.println("시설 정보 생성 컨트롤러 도착");
		
		placeService.addPlace(place);
		
		return "redirect:/user/home";
	}

	@ResponseBody
	@PostMapping("/addAPIserch")
	public Place serchAddr(@RequestBody HashMap<String,Object> map) {
		
		System.out.println("주소 조회를 시작합니다.");
		String address;
		
		if(map.containsKey("juso")) {
			address = (String)map.get("juso");
			System.out.println("juso 확인");
		} else {
			address = (String)map.get("jibun");
			System.out.println("jibun 확인");
		}
		
		
		Place place = null;
		
		try {
			
			String urlStr = "https://dapi.kakao.com/v2/local/search/address.json?query=" + URLEncoder.encode(address, "UTF-8");
	        URL url = new URL(urlStr);
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Authorization", "KakaoAK " + API_KEY);

	        // 응답 읽기
	        BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        StringBuilder response = new StringBuilder();
	        String line;
	        while ((line = br.readLine()) != null) {
	            response.append(line);
	        }
	        br.close();

	        // JSON 파싱
	        JSONObject jsonResponse = new JSONObject(response.toString());
	        JSONArray documents = jsonResponse.getJSONArray("documents");
	        
	        
	        
	        if (documents.length() > 0) {
	            JSONObject location = documents.getJSONObject(0);
	            place = new Place();
	            
	            place.setLatitude(location.getDouble("y"));
	            place.setLongitude(location.getDouble("x"));
	            
	            System.out.println("위도경도 조회 완료, 주소 확인 진입합니다.");
	            System.out.println(map.containsKey("juso"));
	            System.out.println(map.containsKey("jibun"));
	            
	    		if(map.containsKey("jibun")) {
	    			JSONObject jsonAddr = location.getJSONObject("road_address");
	    			System.out.println("지번으로 검색하셨습니다, 도로명 주소를 반환합니다.");
	    			
	    			place.setJuso(jsonAddr.getString("address_name"));
	    			
	    		} else {
	    			JSONObject jsonAddr = location.getJSONObject("address");
	    			System.out.println("도로명 주소로 검색하셨습니다, 지번을 반환합니다.");
	    			
	    			place.setJibun(jsonAddr.getString("address_name"));
	    			
	    		}
	            
	            double latitude = location.getDouble("y"); // 위도
	            double longitude = location.getDouble("x"); // 경도
	            System.out.println("위도: " + latitude + ", 경도: " + longitude);

	        } else {
	            System.out.println("주소: " + address + " - 결과가 없습니다.");
	        }
	        
	        
		} catch(Exception e) { 
			System.out.println("조회실패");
			e.printStackTrace();
		}
		
		return place;
	}
	
	@ResponseBody
	@PostMapping("/placeAPIserch")
	public HashMap<String,Boolean> placeAPIserch(@RequestBody HashMap<String,Object> map) {
		
		HashMap<String,Boolean> result = new HashMap<String, Boolean>();
		
		Place place = new Place();
		
		System.out.println();
		
		String jusoPattern = (String)map.get("juso");
		if(jusoPattern.contains("경남")) {
			jusoPattern = jusoPattern.replace("경남", "경상남도");
		}
		
		place.setJuso(jusoPattern);
		
		String jibunPattern = (String)map.get("jibun");
		if(jibunPattern.contains("경남")) {
			jibunPattern = jibunPattern.replace("경남", "경상남도");
		}
		
		place.setJibun(jibunPattern);
		
		System.out.println(place.getJuso());
		System.out.println(place.getJibun());
		
		place.setTitle((String)map.get("title"));
		
		DecimalFormat df = new DecimalFormat("#.####");
		String lax = df.format(Double.parseDouble((String)map.get("latitude")));
		String loy = df.format(Double.parseDouble((String)map.get("longitude")));
		
		place.setLatitude(Double.parseDouble(lax));
		place.setLongitude(Double.parseDouble(loy));
		System.out.println(place.getLatitude());
		System.out.println(place.getLongitude());
		boolean code = placeService.matchPlace(place);
		
		
		result.put("status", code);
		
		return result;
	}
	
	@GetMapping("/allPlace/{range}/{pageNum}")
	public String getPlaceView(@PathVariable("range") String category, @PathVariable("pageNum") String pageNum, Model model,
							   @RequestParam(value = "city", required = false) String city,
							   @RequestParam(value = "big", required = false) String big,
							   @RequestParam(value = "sub", required = false) String sub,
							   @RequestParam(value = "foodsub", required = false) String foodsub) {
		
		if(category.equals("category")) {
			model.addAttribute("city", city);
			model.addAttribute("serchAddr1","/howAbout/place/allPlace/"+category+"/");
			model.addAttribute("serchAddr2", "?city="+city);
			System.out.println("지역 정보를 저장합니다.");
			
			if(big != null && !(big.isEmpty())) {
				model.addAttribute("big", big);
				System.out.println("대분류를 저장합니다.");
				model.addAttribute("serchAddr","/howAbout/place/allPlace/"+category+"/");
				model.addAttribute("serchAddr2", "?city="+city+"&big="+big);
				
				if(sub != null && !(sub.isEmpty())) {
					model.addAttribute("sub", sub);
					System.out.println("소분류 저장합니다.");
					model.addAttribute("serchAddr","/howAbout/place/allPlace/"+category+"/");
					model.addAttribute("serchAddr2", "?city="+city+"&big="+big+"&sub="+sub);
					
					if(foodsub != null && !(foodsub.isEmpty())) {
						model.addAttribute("foodsub", foodsub);
						System.out.println("음식분류를 저장합니다.");
						model.addAttribute("serchAddr","/howAbout/place/allPlace/"+category+"/");
						model.addAttribute("serchAddr2", "?city="+city+"&big="+big+"&sub="+sub+"&foodsub="+foodsub);
					}
				}
			}
		}
		
		model.addAttribute("category", category);
		model.addAttribute("pageNum", pageNum);
		List<Place> place_list = placeService.getAllPlace(model);
		
		model.addAttribute("place_list", place_list);
		System.out.println("페이지로 이동합니다.");
		
		return "allPlace";
	}
	
	@GetMapping("/update/{updateNum}")
	public String updatePlace(@PathVariable String updateNum, @ModelAttribute Place place) {
		System.out.println("시설 업데이트 Form 화면으로 이동합니다.");
		
		placeService.getPlace(updateNum);
		
		return "placeUpdateForm";
	}
	
	
}
