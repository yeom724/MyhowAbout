package com.springproject.repository;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.sql.DataSource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springproject.domain.Place;

@Repository
public class PlaceRepositoryImpl implements PlaceRepository{
	private static final String API_KEY = "20643075f94a998f4e14a1853f11935c"; // 실제 Kakao API 키로 변경하세요.
	
    private JdbcTemplate temp;

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
		// TODO Auto-generated method stub
		
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
    
}
