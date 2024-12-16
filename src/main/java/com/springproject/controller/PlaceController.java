package com.springproject.controller;


import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;

import com.springproject.domain.Member;
import com.springproject.domain.Place;
import com.springproject.service.PlaceService;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	private static final String API_KEY = "14cdbb863b4c2d47cee16ab2b06356c6";
	
	@Autowired
	PlaceService placeService;
	
	@GetMapping("/scrap")
	public String startScrap() {
		
		return "placeex";
	}
	
	@PostMapping("/DBconn")
	public ResponseEntity<String> testWebScrap(@RequestBody List<Place> restaurants) {
		
		for(Place rest: restaurants) {
			
			try {
				placeService.addPlace(rest);
			} catch(Exception e) {
				System.out.println("중복데이터가 있으므로 넘어갑니다.");
			}
			
			
		}

        return ResponseEntity.ok("데이터가 성공적으로 저장되었습니다.");
        
	}
	
	@GetMapping("/location")
	public void getLocationInfo(String placeName) {
		
		RestTemplate restTemplate = new RestTemplate();
		
		placeName = "통영시 산양읍 연대도";
        String url = "https://dapi.kakao.com/v2/local/search/keyword.json?query=" + placeName;

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "KakaoAK " + API_KEY);
        HttpEntity<String> entity = new HttpEntity<>(headers);

        ResponseEntity<String> response = restTemplate.exchange(url, HttpMethod.GET, entity, String.class);

        System.out.println(response.getBody());
    }
	
	
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
		
		List<Place> place_list = placeService.getAllPlace(model);
		model.addAttribute("place_list", place_list);
		System.out.println("페이지로 이동합니다.");
		
		return "place/newAllPlace";
	}
	
	//하나의 장소 정보를 반환
	@GetMapping("/newGetOne/placeID/{placeID}")
	public String newGetOnePlace(@PathVariable String placeID, Model model) {
		
		Place place = (Place)placeService.getPlace(placeID);
		model.addAttribute("place", place);
		
		return "place/newOnePlace";
	}
	
	@ResponseBody
	@PostMapping("/newGetOne/placeID/{placeID}")
	public HashMap<String, Boolean> newGetOnePlace(@PathVariable String placeID, @RequestBody HashMap<String,Object> map) {
		
		HashMap<String, Boolean> result = new HashMap<String, Boolean>();
		Place place = null;
		
		if(placeID.equals(map.get("placeID"))) {

			if(map.get("status").equals("update")) {
				place = (Place)placeService.getPlace(placeID);
				if(place != null) { result.put("status", true); }
			}
			
			else if (map.get("status").equals("add")) {
				place = (Place)placeService.getPlace(placeID);
				if(place != null) { 
					result.put("status", false);
					result.put("error01", true);
				} else { result.put("status", true); }
			}
			
		} else {
			result.put("status", false);
			result.put("error02", true);
		}
		
		return result;
	}
	
	//장소추가 페이지, 관리자만 접근 가능
	@GetMapping("/placeAdd")
	public String placeAddForm(@ModelAttribute Place place, HttpServletRequest req, Model model) {
		
		HttpSession session = req.getSession(false);
		String result = "redirect:/user/home";
		
		if(session != null) {
			Member member = (Member)session.getAttribute("userStatus");
			if(member != null) {
				if(member.getUserId().equals("admin")) {
					result = "place/newAddPlace";
				} else { result = "redirect:/error/403"; }
			} else { result = "redirect:/error/401"; }
		} else { result = "redirect:/error/401"; }
		
		return result;
	
	}
	
	@PostMapping("/placeAdd")
	public String placeAdd(@ModelAttribute Place place, HttpServletRequest req) {
		
		String home = "redirect:/user/home";
		
		HttpSession session = req.getSession(false);
		Member member = null;
		
		if(session != null) {
			member = (Member)session.getAttribute("userStatus");
			if(member != null) {
				if(member.getUserId().equals("admin")) {
					placeService.addPlace(place);
				} else { home = "redirect:/error/403"; }
			} else { home = "redirect:/error/401"; }
		} else { home = "redirect:/error/401"; }
		
		return home;
		
	}
	
	//장소 수정 페이지
	@GetMapping("/placeUpdate/{placeID}")
	public String placeUpdateForm(@PathVariable String placeID, @ModelAttribute Place place, Model model) {
		
		Place oldPlace = placeService.getPlace(placeID);
		model.addAttribute("update","update");
		model.addAttribute("oldPlace", oldPlace);
		
		return "place/newAddPlace";
	}
	
	@PostMapping("/placeUpdate/{placeID}")
	public String placeUpdate(@PathVariable String placeID, @ModelAttribute Place place, HttpServletRequest req) {
		
		String home = "redirect:/user/home";
		
		HttpSession session = req.getSession(false);
		Member member = null;
		
		if(session != null) {
			member = (Member)session.getAttribute("userStatus");
			if(member != null) {
				if(member.getUserId().equals("admin")) {
					String oldPlaceID = (String)session.getAttribute("oldPlaceID");
					if(oldPlaceID != null) {
						
						if(place.getPlaceID().equals(oldPlaceID)) {
							
							session.removeAttribute("oldPlaceID");
							placeService.updatePlace(place);
							
						} else { home = "redirect:/error/400"; }	
					} else { home = "redirect:/error/400"; }
				} else { home = "redirect:/error/403"; }
			} else { home = "redirect:/error/401"; }
		} else { home = "redirect:/error/401"; }
		
		return home;
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

	
}
