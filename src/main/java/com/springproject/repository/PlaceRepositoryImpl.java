package com.springproject.repository;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.List;

import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.springproject.domain.Member;
import com.springproject.domain.Place;

@Repository
public class PlaceRepositoryImpl implements PlaceRepository{
	private static final String API_KEY = "20643075f94a998f4e14a1853f11935c"; // 실제 Kakao API 키로 변경하세요.
	
    private JdbcTemplate temp;
    String sql;

    @Autowired
    public void setJdbcTemplate(DataSource dataSource) {
        this.temp = new JdbcTemplate(dataSource);
    }
    
    public void run() {
        String filePath = "json/food.json"; // JSON 파일 경로

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
                
                obj.setJuso(place.getString("도로명주소"));
                obj.setCategory(place.getString("음식점 구분"));
                obj.setJibun(place.getString("지번주소"));
                obj.setTitle(place.getString("사업장명"));
                obj.setStatus(place.getString("영업상태"));
                obj.setFoodCategory(place.getString("업태구분"));
                
                String address = place.getString("지번주소");
                System.out.println("주소: " + address);

                // Kakao API로 위도와 경도 받아오기
                try {
                	
                    getCoordinates(obj);
                    
                } catch (Exception e) {
                    System.out.println("위치 정보를 가져오는 데 실패했습니다: " + address);
                    e.printStackTrace();
                }
            }

        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void getCoordinates(Place obj) throws Exception {
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
            String sql = "INSERT INTO aboutPlace VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            temp.update(sql, obj.getJuso(), obj.getJibun(), obj.getCategory(), obj.getTitle(), obj.getStatus(), obj.getFoodCategory(), latitude, longitude);
        } else {
            System.out.println("주소: " + address + " - 결과가 없습니다.");
        }
    }

	@Override
	public void addPlace(Place place) {
		
		System.out.println("addPlace aboutPlace 레파지토리 도착");
		
		sql = "insert into aboutPlace values(?,?,?,?,?,?,?,?,null)";
		temp.update(sql, place.getJuso(), place.getJibun(), place.getCategory(), place.getTitle(), place.getStatus(), place.getFoodCategory(), place.getLatitude(), place.getLongitude());
		
		System.out.println("aboutPlace 테이블에 새 시설 정보를 입력했습니다.");
		
	}

	@Override
	public Place getPlace(String updateNum) {
		// TODO Auto-generated method stub
		return null;
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
	public List<Place> getAllPlace(Model model) {
		
		String category = (String)model.getAttribute("category");
		int count = 0;
		int pageNum = Integer.parseInt((String)model.getAttribute("pageNum"));
		int offset = (pageNum - 1)*20;
		
		String city = null;
		String big = null;
		String sub = null;
		String foodsub = null;
		
		List<Place> place_list = null;
		
		if(category.equals("all")) {
			System.out.println("Place 전체 조회");
			sql = "select count(*) from aboutPlace";
			count = temp.queryForObject(sql, Integer.class);
			System.out.println(count);
			model.addAttribute("Count",count);
			
			sql = "select * from aboutPlace limit 20 offset ?";
			place_list = temp.query(sql, new PlaceRowMapper(), offset);
			
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
				place_list = temp.query(sql, new PlaceRowMapper(), '%'+city+'%', offset);
				
			} else if(big != null){
				
				if(big.equals("hotel") && sub == null) {
					sql = "select count(*) from aboutPlace where juso Like ? and category IN ('숙박업','일반야영장업','외국인관광도시민박업','한옥체험업','관광펜션업','자동차야영장업','관광숙박업','농어촌민박업')";
					count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
					System.out.println(count);
					model.addAttribute("Count",count);
					
					sql = "select * from aboutPlace where juso Like ? and category IN ('숙박업','일반야영장업','외국인관광도시민박업','한옥체험업','관광펜션업','자동차야영장업','관광숙박업','농어촌민박업') limit 20 offset ?";
					place_list = temp.query(sql, new PlaceRowMapper(), '%'+city+'%', offset);
					
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
					place_list = temp.query(sql, new PlaceRowMapper(), '%'+city+'%', offset);
					
				} else if(big.equals("food") && sub == null) {
					
					sql = "select count(*) from aboutPlace where juso Like ? and category IN ('일반음식점', '휴게음식점', '관광식당', '외국인전용유흥음식점업')";
					count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
					System.out.println(count);
					model.addAttribute("Count",count);
					
					sql = "select * from aboutPlace where juso Like ? and category IN ('일반음식점', '휴게음식점', '관광식당', '외국인전용유흥음식점업') limit 20 offset ?";
					place_list = temp.query(sql, new PlaceRowMapper(), '%'+city+'%', offset);
					
					
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
						
					}

					count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
					System.out.println(count);
					model.addAttribute("Count",count);
					
					sql = "select * from aboutPlace where juso Like ? and category IN ("+foodCategory+") limit 20 offset ?";
					
					if(foodsub != null) {
						sql = "select * from aboutPlace where juso Like ? and category IN ("+foodCategory+") and foodCategory IN ("+subfood+") limit 20 offset ?";
					}
					
					place_list = temp.query(sql, new PlaceRowMapper(), '%'+city+'%', offset);

				}
			}
		}
		
		System.out.println("카테고리별 목록이 반환되었습니다.");
	    
		return place_list;
	}
    
}
