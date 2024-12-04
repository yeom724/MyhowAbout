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
		
		sql = "insert into aboutPlace values(?,?,?,?,?,?,?,?)";
		temp.update(sql, place.getJuso(), place.getJibun(), place.getCategory(), place.getTitle(), place.getStatus(), place.getFoodCategory(), place.getLatitude(), place.getLongitude());
		
		System.out.println("aboutPlace 테이블에 새 시설 정보를 입력했습니다.");
		
	}

	@Override
	public Place getPlace(Place place) {
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
		int offset = (pageNum - 1)*50;
		
		List<Place> place_list = null;
		
		if(category.equals("all")) {
			System.out.println("Place 전체 조회");
			sql = "select count(*) from aboutPlace";
			count = temp.queryForObject(sql, Integer.class);
			model.addAttribute("Count",count);
			
			sql = "select * from aboutPlace limit 50 offset ?";
			place_list = temp.query(sql, new PlaceRowMapper(), offset);
			
		} else if(category.equals("hotel")) {
			System.out.println("Place 숙박 조회");
			sql = "select count(*) from aboutPlace where category IN ('숙박업','일반야영장업','외국인관광도시민박업','한옥체험업','관광펜션업','자동차야영장업','관광숙박업','농어촌민박업')";
			count = temp.queryForObject(sql, Integer.class);
			model.addAttribute("Count",count);
			
			sql = "select * from aboutPlace where category IN ('숙박업','일반야영장업','외국인관광도시민박업','한옥체험업','관광펜션업','자동차야영장업','관광숙박업','농어촌민박업') limit 50 offset ?";
			place_list = temp.query(sql, new PlaceRowMapper(), offset);
			
		} else if(category.equals("food")) {
			System.out.println("Place 식당 조회");
			sql = "select count(*) from aboutPlace where category IN ('일반음식점','휴게음식점','외국인전용유흥음식점업','관광식당')";
			count = temp.queryForObject(sql, Integer.class);
			model.addAttribute("Count",count);
			
			sql = "select * from aboutPlace where category IN ('일반음식점','휴게음식점','외국인전용유흥음식점업','관광식당') limit 50 offset ?";
			place_list = temp.query(sql, new PlaceRowMapper(), offset);
		}
		
		System.out.println("카테고리별 목록이 반환되었습니다.");
	    
		return place_list;
	}
    
}
