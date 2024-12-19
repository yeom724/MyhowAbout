package com.springproject.repository;

import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.Duration;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.openqa.selenium.By;
import org.openqa.selenium.ElementClickInterceptedException;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.chrome.ChromeOptions;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.springproject.Jackson.*;
import com.springproject.domain.Member;
import com.springproject.domain.deleteplace;
import com.springproject.domain.Place;


public class PlaceRepositoryImpl implements PlaceRepository{
	private static final String API_KEY = "20643075f94a998f4e14a1853f11935c"; // 실제 Kakao API 키로 변경하세요.
	
    private JdbcTemplate temp;
    String sql;

    @Autowired
    public void setJdbcTemplate(DataSource dataSource) {
        this.temp = new JdbcTemplate(dataSource);
    }
    
    public void run() {
        String filePath = "json/restaurant.json"; // JSON 파일 경로

        try {
            // 리소스 폴더에서 JSON 파일 읽기
            InputStream inputStream = PlaceRepositoryImpl.class.getClassLoader().getResourceAsStream(filePath);
            if (inputStream == null) {
                System.out.println("파일을 찾을 수 없습니다: " + filePath);
                return;
            }

            BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
            StringBuilder jsonBuilder = new StringBuilder();
            String line;
            while ((line = reader.readLine()) != null) {
                jsonBuilder.append(line);
            }
            reader.close();

            // JSON 배열 파싱
            JSONArray jsonArray = new JSONArray(jsonBuilder.toString());

            // 도로명주소 추출 및 API 호출
            for (int i = 0; i < jsonArray.length(); i++) {
                Place obj = new Place();
                JSONObject place = jsonArray.getJSONObject(i);
                System.out.println(place);
                
                obj.setAddressName(place.getString("address_name"));
                obj.setRoadAddress(place.getString("road_address_name"));
                obj.setPlaceName(place.getString("place_name"));
                obj.setCategory(place.getString("category_group_name"));
                obj.setCategoryAll(place.getString("category_name"));
                obj.setPhone(place.getString("phone"));
                obj.setPlaceUrl(place.getString("place_url"));
                obj.setPlaceID(place.getString("id"));
                obj.setLongitude(place.getString("x"));
                obj.setLatitude(place.getString("y"));
                
                sql = "INSERT INTO Place VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                temp.update(sql, obj.getAddressName(), obj.getRoadAddress(), obj.getPlaceName(), obj.getCategory(), obj.getCategoryAll(), obj.getPhone(), obj.getPlaceUrl(), obj.getPlaceID(), obj.getLongitude(), obj.getLatitude());
                System.out.println(i+"번째 저장완료");

                // Kakao API로 위도와 경도 받아오기
                try {
                	
                    getCoordinates(obj);
                    
                } catch (Exception e) {
                    System.out.println("정보를 가져오는 데 실패했습니다");
                    e.printStackTrace();
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }
    
	public void runmobum(){
		//잭슨 사용
		ObjectMapper objectMapper = new ObjectMapper();
		String filePath = "json/mobum.json";
		
		try {
            
			InputStream inputStream = PlaceRepositoryImpl.class.getClassLoader().getResourceAsStream(filePath);
            if (inputStream == null) {
                System.out.println("파일을 찾을 수 없습니다: " + filePath);
                return;
            }
			
			//json을 java로 파싱중...
            MobumResultSet mobumResultSet = objectMapper.readValue(inputStream, MobumResultSet.class);
            // 아이템 리스트 가져오기
            List<Item> items = mobumResultSet.getGyeongnamGoodRestaurantList().getBody().getItems().getItem();
            
            for(int i=0; i<items.size(); i++) {
            	Item item = items.get(i);
            	deleteplace place = new deleteplace();
            	place.setFoodCategory(item.getMainMenu());
            	place.setTitle(item.getEntrprsNm());
            	place.setJuso(item.getRdnmadr());
            	
            	try { jacksonDB(place); }
            	catch (Exception e) {
                    System.out.println("정보를 가져오는 데 실패했습니다");
                    e.printStackTrace();
                }
            	
            }
   
        } catch (IOException e) {
            e.printStackTrace();
        }
		
		
	}

    public void getCoordinates(deleteplace obj) throws Exception {
        String address = obj.getJibun();
        
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
            double latitude = location.getDouble("y"); // 위도
            double longitude = location.getDouble("x"); // 경도
            
            System.out.println("위도: " + latitude + ", 경도: " + longitude);

            // SQL 쿼리 실행
            String sql = "INSERT INTO aboutPlace VALUES (?, ?, ?, ?, ?, ?, ?, ?, null)";
            temp.update(sql, obj.getJuso(), obj.getJibun(), obj.getCategory(), obj.getTitle(), obj.getStatus(), obj.getFoodCategory(), latitude, longitude);
        } else {
        	
            System.out.println("주소: " + address + " - 결과가 없습니다.");
            
        }
    }
    
    public void jacksonDB(deleteplace obj) throws Exception{
    	
    	sql = "select count(*) from aboutPlace where juso LIKE ? and title=?";
    	int row = temp.queryForObject(sql, Integer.class, '%'+obj.getJuso()+'%', obj.getTitle());
    	
    	if(row == 1) {
    		
    		sql = "update aboutPlace set category='모범음식점' where juso LIKE ? and title=?";
    		temp.update(sql, '%'+obj.getJuso()+'%', obj.getTitle());
    		
    	} else if (row > 1) {
    		
    		System.out.println("중복된 데이터가 존재합니다. 업데이트를 할 수 없습니다.");
    		
    	} else if (row == 0) {
    		
        	String address = obj.getJuso();
            
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
                double latitude = location.getDouble("y"); // 위도
                double longitude = location.getDouble("x"); // 경도
                JSONObject jsonAddr = location.getJSONObject("address");
                System.out.println("위도: " + latitude + ", 경도: " + longitude);

                // SQL 쿼리 실행
                String sql = "INSERT INTO aboutPlace VALUES (?, ?, ?, ?, ?, ?, ?, ?, null)";
                temp.update(sql, obj.getJuso(), jsonAddr.getString("address_name"), "모범음식점", obj.getTitle(), "영업/정상", obj.getFoodCategory(), latitude, longitude);
            } else {
                System.out.println("주소: " + address + " - 결과가 없습니다.");
            }
    		
    	}
    	

    }
    

	@Override
	public void addRestaurant(Place restaurant) {
		
		sql = "insert into Place values(?,?,?,?,?,?,?,?,?,?)";
		temp.update(sql, restaurant.getAddressName(), restaurant.getRoadAddress(), restaurant.getPlaceName(), restaurant.getCategory(), restaurant.getCategoryAll() ,restaurant.getPhone(), restaurant.getPlaceUrl(), restaurant.getPlaceID(), restaurant.getLongitude(), restaurant.getLatitude());
		
//		// ChromeDriver 경로 설정
//        System.setProperty("webdriver.chrome.driver", "C:/chromedriver-win64/chromedriver.exe"); // 경로 수정
//
//        
//        
//        // ChromeOptions 설정 (옵션 필요시)
//        ChromeOptions options = new ChromeOptions();
//        options.addArguments("--headless"); // 브라우저를 GUI 없이 실행 (선택 사항)
//
//        // WebDriver 초기화
//        WebDriver driver = new ChromeDriver(options);
//        
//        try {
//            // 웹 페이지 열기
//            driver.get(restaurant.getPlaceUrl());
//            
//            driver.manage().timeouts().implicitlyWait(5, TimeUnit.SECONDS); // 페이지 로드 대기
//            
//            // div#kakaoContent 선택
//            WebElement contentDiv = driver.findElement(By.id("kakaoContent"));
//            WebElement innerDiv = contentDiv.findElement(By.id("mArticle"));
//            WebElement menuDiv = innerDiv.findElement(By.className("cont_menu"));
//            
//            WebElement ulElement = menuDiv.findElement(By.tagName("ul"));
//            WebElement item = ulElement.findElement(By.cssSelector("li:first-of-type"));
//  
////            WebElement foldDiv = driver.findElement(By.cssSelector("div.fold_floor"));
////            WebElement timeItems = foldDiv.findElement(By.cssSelector("ul.list_operation > li"));
//            
//            //sql = "insert into PlaceMenu values(?,null,?,?)";
//            //temp.update(sql, restaurant.getPlaceID(),item.findElement(By.className("loss_word")).getText(), item.findElement(By.className("price_menu")).getText());
//            
//            System.out.println("메인 메뉴 : " + item.findElement(By.className("loss_word")).getText());
//            
//            // 각 li의 텍스트 출력
////            for (WebElement item : listItems) {
////            	System.out.println("메뉴 저장중");
////            	
////            	//메뉴저장
////                sql = "insert into PlaceMenu values(?,null,?,?)";
////                temp.update(sql, restaurant.getPlaceID(),item.findElement(By.className("loss_word")).getText(), item.findElement(By.className("price_menu")).getText());
////                
////            }
//            
//
//
//
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            // 브라우저 닫기
//            driver.quit();
//        }
		
	}
    

	@Override
	public void addPlace(deleteplace place) {
		
		System.out.println("addPlace aboutPlace 레파지토리 도착");
		
		sql = "insert into aboutPlace values(?,?,?,?,?,?,?,?,null)";
		temp.update(sql, place.getJuso(), place.getJibun(), place.getCategory(), place.getTitle(), place.getStatus(), place.getFoodCategory(), place.getLatitude(), place.getLongitude());
		
		System.out.println("aboutPlace 테이블에 새 시설 정보를 입력했습니다.");
		
	}

	@Override
	public deleteplace getPlace(String updateNum) {
		System.out.println("주소지 조회중... : "+updateNum);
		deleteplace place = null;
		
		sql = "select * from aboutPlace where updateNum=?";
		place = temp.queryForObject(sql, new deleteRowMapper(), updateNum);
		
		return place;
	}

	@Override
	public void updatePlace(deleteplace place) {
		System.out.println("시설 정보 업데이트를 시작합니다.");
		
		sql = "update aboutPlace set juso=?, jibun=?, category=?, title=?, status=?, foodCategory=?, latitude=?, longitude=? where updateNum=?";
		temp.update(sql, place.getJuso(), place.getJibun(), place.getCategory(), place.getTitle(), place.getStatus(), place.getFoodCategory(), place.getLatitude(), place.getLongitude(), place.getUpdateNum());
		System.out.println("시설 업데이트가 완료되었습니다.");
	
	}

	@Override
	public void deletePlace(String updateNum) {
		System.out.println("시설 정보 삭제를 시작합니다.");
		
		sql = "delete from aboutPlace where updateNum=?";
		temp.update(sql, updateNum);
		
	}

	@Override
	public boolean matchPlace(deleteplace place) {
		
		boolean result = false;
		
		sql="select count(*) from aboutPlace where juso Like ?";
		int rowJuso = temp.queryForObject(sql, Integer.class, '%'+place.getJuso()+'%');
		sql="select count(*) from aboutPlace where jibun Like ?";
		int rowJibun = temp.queryForObject(sql, Integer.class, '%'+place.getJibun()+'%');
		sql="select count(*) from aboutPlace where title=?";
		int rowTitle = temp.queryForObject(sql, Integer.class, place.getTitle());
		
		
		String latitudeP = String.valueOf(place.getLatitude())+'%';
		String longitudeP = String.valueOf(place.getLongitude())+'%';
		
		sql="select count(*) from aboutPlace where CAST(latitude AS CHAR) LIKE ? AND CAST(longitude AS CHAR) LIKE ?";
		int rowXY = temp.queryForObject(sql, Integer.class, latitudeP, longitudeP);
		
		if(rowXY>=1) {
			System.out.println("해당 위도와 경도를 가진 장소가 저장되어 있습니다.");
			if(rowJibun>=1) {
				System.out.println("해당 지번을 가진 장소가 저장되어 있습니다.");
				if(rowJuso>=1) {
					System.out.println("해당 도로명 주소를 가진 장소가 저장되어 있습니다.");
					if(rowTitle>=1) {
						System.out.println("해당 타이틀을 가진 장소가 저장되어 있습니다. 등록할 수 없습니다.");
					} else {
						System.out.println("상호명이 다릅니다, 등록대상입니다.");
						result = true;
					}
				}
			}
		} else {
			System.out.println("등록대상입니다.");
			result = true;
		}
		
		return result;
	}
	
	@Override
	public HashMap<String,Boolean> updateMatchPlace(deleteplace place) {
		System.out.println("업데이트 유효성 도착");
		
		HashMap<String,Boolean> result = new HashMap<String, Boolean>();
		result.put("status", false);
		
		deleteplace oldPlace = getPlace(String.valueOf(place.getUpdateNum()));
		System.out.println("기존주소 " + oldPlace.getJuso());
		System.out.println("수정주소 " + place.getJuso());
		
		if(oldPlace.getJuso().equals(place.getJuso())) {
			System.out.println("도로명 주소 유지 확인");
			
			if(oldPlace.getJibun().equals(place.getJibun())) {
				System.out.println("지번 주소 유지 확인");
				
				sql ="select count(*) from aboutPlace where title=? and juso Like ?";
				int rowTitle = temp.queryForObject(sql, Integer.class, place.getTitle(), '%'+place.getJuso()+'%');
				
				if(rowTitle == 0) {
					result.put("status", true);
					System.out.println("상호명을 변경합니다.");
				} else {
					
					System.out.println("같은 장소에 동일한 상호명이 존재합니다.");
					
					if( !(oldPlace.getCategory().equals(place.getCategory()))||
						!(oldPlace.getStatus().equals(place.getStatus()))) {
						System.out.println("수정된 카테고리"+place.getCategory()+" 기존 카테고리 : "+oldPlace.getCategory());
						System.out.println("수정된 영업상태"+place.getStatus()+" 기존 영업상태 : "+oldPlace.getStatus());
						if(place.getFoodCategory() != null) {
							if(!(oldPlace.getFoodCategory().equals(place.getFoodCategory()))) {
								System.out.println("수정된 푸드카테고리"+place.getFoodCategory()+" 기존 푸드카테고리 : "+oldPlace.getFoodCategory());
							}
						}

						System.out.println("수정 사항이 존재합니다.");
						result.put("status", true);
					} else {
						System.out.println("변동 사항이 없습니다.");
						result.put("status", false);
						result.put("error01", true);
					}
				}
				
				System.out.println("위도"+place.getLatitude());
				System.out.println("위도"+place.getLongitude());
				String rowX = String.valueOf(place.getLatitude());
				String rowY = String.valueOf(place.getLongitude());
				
				sql = "select count(*) from aboutPlace where latitude Like ? and longitude Like ? and updateNum=?";
				int rowXY = temp.queryForObject(sql, Integer.class, rowX+'%', rowY+'%', place.getUpdateNum());
				if(rowXY != 0) {
					System.out.println("위도 경도 유지 확인");
				} else {
					System.out.println("위도 경도가 잘못되었습니다.");
					result.put("status", false);
					result.put("error02", true);
				}
				
			}
			
		} else {
			
			sql = "select count(*) from aboutPlace where jibun Like ?";
			int rowJibun = temp.queryForObject(sql, Integer.class, '%'+place.getJibun()+'%');
			
			if(rowJibun != 0) {
				sql ="select count(*) from aboutPlace where title=?";
				int rowTitle = temp.queryForObject(sql, Integer.class, place.getTitle());
				
				if(rowTitle != 0) {
					System.out.println("같은 장소에 동일한 상호명이 존재합니다. 수정할 수 없습니다.");
					result.put("error03", true);
				} else {
					result.put("status", true);
					System.out.println("장소는 같지만 상호명이 다릅니다. 수정합니다.");
				}
			} else {
				result.put("status", true);
				System.out.println("동일한 주소가 존재하지 않습니다. 수정합니다.");
			}
			
		}
		
		return result;
	}
	

	@Override
	public List<deleteplace> getAllPlace(Model model) {
		
		String category = (String)model.getAttribute("category");
		int count = 0;
		int pageNum = Integer.parseInt((String)model.getAttribute("pageNum"));
		int offset = (pageNum - 1)*20;
		
		String city = null;
		String big = null;
		String sub = null;
		String foodsub = null;
		
		List<deleteplace> place_list = null;
		
		if(category.equals("all")) {
			System.out.println("Place 전체 조회");
			sql = "select count(*) from aboutPlace";
			count = temp.queryForObject(sql, Integer.class);
			System.out.println(count);
			model.addAttribute("Count",count);
			
			sql = "select * from aboutPlace limit 20 offset ?";
			place_list = temp.query(sql, new deleteRowMapper(), offset);
			
		} else if(category.equals("category")) {
			System.out.println("category별 조회");
			
			city = (String)model.getAttribute("city");
			
			if (model.asMap().containsKey("big")) { big = (String)model.getAttribute("big");}
			if (model.asMap().containsKey("sub")) { sub = (String)model.getAttribute("sub");}
			if (model.asMap().containsKey("foodsub")) { foodsub = (String)model.getAttribute("foodsub");}
			
			if (big == null) {
				System.out.println(city + "지역의 조회를 시작합니다.");
				
				sql = "select count(*) from aboutPlace where juso Like ?";
				count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
				System.out.println(count);
				model.addAttribute("Count",count);
				
				sql = "select * from aboutPlace where juso Like ? limit 20 offset ?";
				place_list = temp.query(sql, new deleteRowMapper(), '%'+city+'%', offset);
				
			} else if(big != null){
				
				if(big.equals("hotel") && sub == null) {
					sql = "select count(*) from aboutPlace where juso Like ? and category IN ('숙박업','일반야영장업','외국인관광도시민박업','한옥체험업','관광펜션업','자동차야영장업','관광숙박업','농어촌민박업')";
					count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
					System.out.println(count);
					model.addAttribute("Count",count);
					
					sql = "select * from aboutPlace where juso Like ? and category IN ('숙박업','일반야영장업','외국인관광도시민박업','한옥체험업','관광펜션업','자동차야영장업','관광숙박업','농어촌민박업') limit 20 offset ?";
					place_list = temp.query(sql, new deleteRowMapper(), '%'+city+'%', offset);
					
				} else if(big.equals("hotel") && sub != null) {
					
					String hotelCategory = null;
					
					if(sub.equals("0100_0700")) { hotelCategory = "'숙박업','관광숙박업'"; }
					if(sub.equals("0200_0600")) { hotelCategory = "'일반야영장업','자동차야영장업'"; }
					if(sub.equals("0400")) { hotelCategory = "'한옥체험업'"; }
					if(sub.equals("0500")) { hotelCategory = "'관광펜션업'"; }
					if(sub.equals("0300_0800")) { hotelCategory = "'외국인관광도시민박업','농어촌민박업'"; }
					
					sql = "select count(*) from aboutPlace where juso Like ? and category IN ("+hotelCategory+")";
					count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
					System.out.println(count);
					model.addAttribute("Count",count);
					
					sql = "select * from aboutPlace where juso Like ? and category IN ("+hotelCategory+") limit 20 offset ?";
					place_list = temp.query(sql, new deleteRowMapper(), '%'+city+'%', offset);
					
				} else if(big.equals("food") && sub == null) {
					
					sql = "select count(*) from aboutPlace where juso Like ? and category IN ('일반음식점', '휴게음식점', '관광식당', '외국인전용유흥음식점업')";
					count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
					System.out.println(count);
					model.addAttribute("Count",count);
					
					sql = "select * from aboutPlace where juso Like ? and category IN ('일반음식점', '휴게음식점', '관광식당', '외국인전용유흥음식점업') limit 20 offset ?";
					place_list = temp.query(sql, new deleteRowMapper(), '%'+city+'%', offset);
					
					
				} else if(big.equals("food") && sub != null) {
					
					String foodCategory = null;
					String subfood = null;
					
					if(sub.equals("1100_1400")) { foodCategory = "'일반음식점','관광식당'"; }
					if(sub.equals("1200")) { foodCategory = "'휴게음식점'"; }
					
					sql = "select count(*) from aboutPlace where juso Like ? and category IN ("+foodCategory+")";
					
					if(foodsub != null) {
						
						if(foodsub.equals("3900")) { subfood = "'기타','극장','유원지','철도역구내','관광호텔'"; }
						if(foodsub.equals("4000")) { subfood = "'일반조리판매','기타 휴게음식점','백화점','한식','탕류(보신용)','식육(숯불구이)'"; }
						if(foodsub.equals("4400")) { subfood = "'일식','복어취급'"; }
						if(foodsub.equals("4450")) { subfood = "'회집','횟집'"; }
						if(foodsub.equals("4500")) { subfood = "'중국식'"; }
						if(foodsub.equals("4600")) { subfood = "'외국음식전문점(인도,태국등)'"; }
						if(foodsub.equals("4700")) { subfood = "'분식','김밥(도시락)','냉면집'"; }
						if(foodsub.equals("4800")) { subfood = "'패스트푸드','패밀리레스트랑','경양식','통닭(치킨)'"; }
						if(foodsub.equals("4100")) { subfood = "'호프/통닭','정종/대포집/소주방','감성주점','라이브카페'"; }
						if(foodsub.equals("4200")) { subfood = "'커피숍','전통찻집','까페','다방','아이스크림','편의점','푸드트럭','키즈카페','과자점','떡카페'"; }
						if(foodsub.equals("4300")) { subfood = "'뷔페식'"; }
						
						sql = "select count(*) from aboutPlace where juso Like ? and category IN ("+foodCategory+") and foodCategory IN ("+subfood+")";
						
						if(foodsub.equals("3500")) { 
							sql = "select count(*) from aboutPlace where juso Like ? and category='모범음식점'";
						}
						
					}

					count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
					System.out.println("너니?"+count);
					model.addAttribute("Count",count);
					
					sql = "select * from aboutPlace where juso Like ? and category IN ("+foodCategory+") limit 20 offset ?";
					
					if(foodsub != null) {
						sql = "select * from aboutPlace where juso Like ? and category IN ("+foodCategory+") and foodCategory IN ("+subfood+") limit 20 offset ?";
						
						if(foodsub.equals("3500")) {
							sql = "select * from aboutPlace where juso Like ? and category='모범음식점' limit 20 offset ?";
						}
						
					}
					
					place_list = temp.query(sql, new deleteRowMapper(), '%'+city+'%', offset);

				}
			}
		}
		
		System.out.println("카테고리별 목록이 반환되었습니다.");
	    
		return place_list;
	}

	@Override
	public void fetchDataFromDatabase() {
		
		List<Place> dataList = null;

        sql = "SELECT * from place limit 21000"; // 필요한 컬럼 선택
        dataList = temp.query(sql, new PlaceRowMapper());
        
        ObjectMapper objectMapper = new ObjectMapper();
        try {
            objectMapper.writeValue(new File("C:/logs/data.json"), dataList); // data.json 파일로 저장
            System.out.println("데이터가 JSON 파일로 저장되었습니다.");
        } catch (IOException e) {
            e.printStackTrace();
        }

	}

	@Override
	public List<? extends Object> newGetAllPlace(Model model) {
		
	}

	@Override
	public Place getNewPlace(String placeID) {
		
		Place restaurant = null;
		
		try {
			
			sql = "select * from Place where placeID=?";
			restaurant = temp.queryForObject(sql, new PlaceRowMapper(), placeID);
			
		} catch(Exception e){ System.out.println("해당 시설을 발견할 수 없었습니다."); }

		
		return restaurant;
	}




    
}
