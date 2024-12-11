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

import com.springproject.domain.Member;
import com.springproject.domain.Place;
import com.springproject.repository.PlaceRepository;
import com.springproject.service.PlaceService;

@Controller
@RequestMapping("/place")
public class PlaceController {
	
	private static final String API_KEY = "fc7be1941eb9e2a48429965c1db39c7e";
	
	@Autowired
	PlaceRepository placeRepository;
	
	@Autowired
	PlaceService placeService;
	
	@GetMapping("/json/start")
	public void run() {
		System.out.println("함수실행");
		placeRepository.run();
	}
	
	@GetMapping("/json/jackson")
	public void runmobum() {
		System.out.println("함수실행");
		placeRepository.runmobum();
	}
	
	@GetMapping("/scrap")
	public String startScrap() {
		System.out.println("스크래핑 시작");
		return "scrapMap";
	}
	
	@GetMapping("/map")
	private void testMapURL() {
		 try {
	            // API 키 설정
	            String apiKey = API_KEY; // 본인의 REST API 키로 변경
	            String searchQuery = "한일장여관"; // 상호명
	            String address = "경상남도 거창군 거창읍 대동리 698-4 "; // 지번 주소를 입력하세요

	            // API URL 생성
	            String apiUrl = String.format(
	                    "https://dapi.kakao.com/v2/local/search/keyword.json?query=%s&size=10",
	                    java.net.URLEncoder.encode(searchQuery + " " + address, "UTF-8") // 상호명과 주소를 함께 URL 인코딩
	                );

	            // API 요청
	            URL url = new URL(apiUrl);
	            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	            conn.setRequestMethod("GET");
	            conn.setRequestProperty("Authorization", "KakaoAK" +" "+ apiKey); // Authorization 헤더 설정
	            conn.connect();
	            System.out.println(conn);

	            // 응답 읽기
	            BufferedReader reader = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	            StringBuilder response = new StringBuilder();
	            String line;
	            while ((line = reader.readLine()) != null) {
	                response.append(line);
	            }
	            reader.close();

	            // JSON 파싱
	            JSONObject jsonResponse = new JSONObject(response.toString());
	            JSONArray documents = jsonResponse.getJSONArray("documents");

	            if (documents.length() > 0) {
	                // 첫 번째 장소 정보 가져오기
	                JSONObject place = documents.getJSONObject(0);
	                String placeId = place.getString("id"); // 장소 ID
	                String placeUrl = "https://place.map.kakao.com/" + placeId; // 카카오맵 URL

	                // 결과 출력
	                System.out.println("카카오맵 URL: " + placeUrl);
	            } else {
	                System.out.println("장소를 찾을 수 없습니다.");
	            }

	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	}
	
	
	private void testWebScrap() {
		
		 // ChromeDriver 경로 설정
        System.setProperty("webdriver.chrome.driver", "C:/chromedriver-win64/chromedriver.exe"); // 경로 수정

        // ChromeOptions 설정 (옵션 필요시)
        ChromeOptions options = new ChromeOptions();
        options.addArguments("--headless"); // 브라우저를 GUI 없이 실행 (선택 사항)

        // WebDriver 초기화
        WebDriver driver = new ChromeDriver(options);
        
        try {
            // 웹 페이지 열기
            driver.get("https://place.map.kakao.com/1346301870"); // 실제 URL로 변경하세요.
            driver.manage().timeouts().implicitlyWait(10, TimeUnit.SECONDS); // 페이지 로드 대기

            // div#kakaoContent 선택
            WebElement contentDiv = driver.findElement(By.id("kakaoContent"));
            
            // outerDiv 안의 innerDiv 선택
            WebElement innerDiv = contentDiv.findElement(By.id("mArticle"));
            
            WebElement menuDiv = innerDiv.findElement(By.className("cont_menu"));

            // innerDiv 안의 ul 선택
            WebElement ulElement = menuDiv.findElement(By.tagName("ul"));

            // ul 안의 li 요소들 선택
            List<WebElement> listItems = ulElement.findElements(By.tagName("li"));

            // 각 li의 텍스트 출력
            for (WebElement item : listItems) {
                System.out.println("추출된 항목: " + item.getText()); // 각 항목의 텍스트 출력
            }
            
            String fourthListItem = (String)listItems.get(3).getText(); // 인덱스는 0부터 시작하므로 3이 4번째
            
            System.out.println("4번째 태그 : "+fourthListItem);


        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            // 브라우저 닫기
            driver.quit();
        }
    

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
		boolean code = false;
		
		Place place = new Place();
		
		String jusoPattern = (String)map.get("juso");
		if(jusoPattern.substring(0, 4).contains("경남")) {
			jusoPattern = jusoPattern.replaceFirst("경남", "경상남도");
		}
		
		place.setJuso(jusoPattern);
		
		String jibunPattern = (String)map.get("jibun");
		if(jibunPattern.substring(0, 4).contains("경남")) {
			jibunPattern = jibunPattern.replaceFirst("경남", "경상남도");
		}
		
		place.setJibun(jibunPattern);
		place.setTitle((String)map.get("title"));
		DecimalFormat df = new DecimalFormat("#.####");
		double lax =  Math.floor((Double.parseDouble((String)map.get("latitude"))) * 10000) / 10000;
		double loy = Math.floor((Double.parseDouble((String)map.get("longitude"))) * 10000) / 10000;
		place.setLatitude(lax);
		place.setLongitude(loy);
		
		
		if(map.get("update").equals("ok")) {
			System.out.println("시설 업데이트 함수로 이동합니다.");
			place.setUpdateNum(Integer.parseInt((String)map.get("updateNum")));
			place.setCategory((String)map.get("category"));
			place.setStatus((String)map.get("status"));
			place.setFoodCategory((String)map.get("foodCategory"));
			result = placeService.updateMatchPlace(place);
			
		} else {
			code = placeService.matchPlace(place);
			result.put("status", code);
		}

		return result;
	}
	
	@GetMapping("/allPlace/{range}/{pageNum}")
	public String getPlaceList(@PathVariable("range") String category, @PathVariable("pageNum") String pageNum, Model model,
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
	public String updatePlaceForm(@PathVariable String updateNum, @ModelAttribute Place place, HttpServletRequest req, Model model) {
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
		
		System.out.println("시설 업데이트 Form 화면으로 이동합니다.");
	
		Place conPlace = placeService.getPlace(updateNum);
		
		
		if(place == null) {
			System.out.println("받아온 정보가 없습니다.");
			result = "/allPlace/all/1";
		} else {
			req.setAttribute("update", "ok");
			model.addAttribute("place",conPlace);
		}
		
		System.out.println(place);
		return result;
	}
	
	@PostMapping("/update/{updateNum}")
	public String updatePlace(@PathVariable String updateNum, @ModelAttribute Place place) {
		System.out.println("업데이트 정보를 받아왔습니다.");
		
		if(place.getJuso().substring(0,4).contains("경남")) {
			place.setJuso(place.getJuso().replaceFirst("경남", "경상남도"));
		}
		
		if(place.getJibun().substring(0,4).contains("경남")) {
			place.setJibun(place.getJibun().replaceFirst("경남", "경상남도"));
		}
		
		placeService.updatePlace(place);
		System.out.println("업데이트가 완료되었습니다.");
		
		return "redirect:/user/home";
	}
	
	@GetMapping("/delete/{updateNum}")
	public String deletePlace(@PathVariable String updateNum) {
		System.out.println("삭제를 진행합니다.");
		
		placeService.deletePlace(updateNum);
		
		return "redirect:/user/home";
	}
	
	@GetMapping("/getOne/{updateNum}")
	public String getOnePlaceView(@PathVariable String updateNum, Model model) {
		
		Place place = placeService.getPlace(updateNum);
		model.addAttribute("place", place);
		
		Properties properties = new Properties();
        
		//파일 위치를 알기 위해서 src/main/java 에 속하는 클래스면 아무거나 가져와도 된다.
        try (InputStream input = PlaceController.class.getClassLoader().getResourceAsStream("properties/application-API-KEY.properties")) {
            if (input == null) {
                System.out.println("죄송합니다, 파일을 찾을 수 없습니다.");
            }
            
            properties.load(input);
            
            // 데이터 가져오기
            String value1 = properties.getProperty("kakao-javaScript-key");
            model.addAttribute("apiKey", value1);
            
            System.out.println("key1: " + value1);
        } catch (Exception e) {
            e.printStackTrace();
        }

		return "onePlace";
	}
	
}
