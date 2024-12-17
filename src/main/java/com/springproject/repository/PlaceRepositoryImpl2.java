package com.springproject.repository;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.springproject.domain.deleteplace;
import com.springproject.domain.Place;

@Repository
public class PlaceRepositoryImpl2 implements PlaceRepository{
	
    private JdbcTemplate temp;
    String sql;

    @Autowired
    public void setJdbcTemplate(DataSource dataSource) {
        this.temp = new JdbcTemplate(dataSource);
    }
   
    HashMap<String, ArrayList<Place>> mapOfPlace;
    
    //기본 생성자에 싱글톤 추가
    PlaceRepositoryImpl2() { mapOfPlace = new HashMap<String, ArrayList<Place>>(); }
    

	@Override
	public void addMapPlaceList(String city, String subCity, String country, ArrayList<Place> list) {
		
		String keyWord = city;
		if(subCity != null) { keyWord = city+" "+subCity; }
		if(country != null) { keyWord = city+" "+subCity+" "+country; }
		
		mapOfPlace.put(keyWord, list);
		
	}
	
	@Override
	public ArrayList<Place> getListOfMap(String city, String subCity, String country) {
		
		String keyWord = city;
		if(subCity != null) { keyWord = city+" "+subCity; }
		if(country != null) { keyWord = city+" "+subCity+" "+country; }
		
		ArrayList<Place> list = null;
		
		if(mapOfPlace.get(keyWord) != null) {
			list = mapOfPlace.get(keyWord);
			System.out.println("기존 저장된 파일을 반환합니다.");
		}
		
		return list;
	}
    

	@Override
	public Place getPlace(String placeID) {
		
		Place restaurant = null;
		try {
			sql = "select * from Place where placeID=?";
			restaurant = temp.queryForObject(sql, new RestaurantRowMapper(), placeID);
		} catch(Exception e){ System.out.println("해당 시설을 발견할 수 없었습니다."); }

		return restaurant;
		
	}

	@Override
	public List<Place> getAllPlace(Model model) {
		
		List<Place> place_list = null;
		String select = (String)model.getAttribute("select");
		
		//페이지 계산
		int count = 0;
		int pageNum = Integer.parseInt((String)model.getAttribute("pageNum"));
		int offset = (pageNum - 1)*20;
		
		String city = null;
		String category = null;
		String sub = null;
		
		if(select.equals("select")) {
			
			if (model.asMap().containsKey("city")) {
				city = (String)model.getAttribute("city");
				
				switch (city) {
				
					case "1001" : city = "창원시"; break;
					case "1002" : city = "김해시"; break;
					case "1003" : city = "진주시"; break;
					case "1004" : city = "양산시"; break;
					case "1005" : city = "거제시"; break;
					case "1006" : city = "통영시"; break;
					case "1007" : city = "사천시"; break;
					case "1008" : city = "밀양시"; break;
					case "1009" : city = "함안군"; break;
					case "1010" : city = "거창군"; break;
					case "1011" : city = "창녕군"; break;
					case "1012" : city = "고성군"; break;
					case "1013" : city = "하동군"; break;
					case "1014" : city = "합천군"; break;
					case "1015" : city = "남해군"; break;
					case "1016" : city = "함양군"; break;
					case "1017" : city = "산청군"; break;
					case "1018" : city = "의령군"; break;

				}

			}
			
			if (model.asMap().containsKey("category")) {
				category = (String)model.getAttribute("category");
				
				switch (category) {
				
					case "101" : category = "음식점"; break;
					case "102" : category = "카페"; break;

				}

			}
			
			if (model.asMap().containsKey("sub")) { 
				sub = (String)model.getAttribute("sub");
				
				switch (sub) {
					
					case "100" : sub = "한식"; break;
					case "200" : sub = "중식"; break;
					case "300" : sub = "일식"; break;
					case "400" : sub = "양식"; break;
					case "500" : sub = "동남아"; break;
					case "600" : sub = "치킨"; break;
					case "700" : sub = "분식"; break;
					case "800" : sub = "술집"; break;
					case "900" : sub = "뷔페"; break;
	
				}
			}
			
			//지역별 조회
			if(category == null) {
				sql = "select count(*) from Place where roadAddress Like ?";
				count = temp.queryForObject(sql, Integer.class, '%'+city+'%');
				
				model.addAttribute("Count",count);
				
				sql = "select * from Place where roadAddress Like ? limit 20 offset ?";
				place_list = temp.query(sql, new RestaurantRowMapper(), '%'+city+'%', offset);
			}
			
			//지역별 카테고리 조회
			else if(category != null && sub == null) {
				sql = "select count(*) from Place where roadAddress Like ? and category=?";
				count = temp.queryForObject(sql, Integer.class, '%'+city+'%', category);
				
				model.addAttribute("Count",count);
				
				sql = "select * from Place where roadAddress Like ? and category=? limit 20 offset ?";
				place_list = temp.query(sql, new RestaurantRowMapper(), '%'+city+'%', category, offset);
			}
			
			//지역 및 카테고리 세분류 조회
			else if(sub != null) {
				sql = "select count(*) from Place where roadAddress Like ? and category=? and categoryAll Like ?";
				count = temp.queryForObject(sql, Integer.class, '%'+city+'%', category, '%'+sub+'%');
				
				model.addAttribute("Count",count);
				
				sql = "select * from Place where roadAddress Like ? and category=? and categoryAll Like ? limit 20 offset ?";
				place_list = temp.query(sql, new RestaurantRowMapper(), '%'+city+'%', category, '%'+sub+'%', offset);
			}
			
		}
		
		//전체 조회
		else if(select.equals("all")) {
			sql = "select count(*) from Place";
			count = temp.queryForObject(sql, Integer.class);

			model.addAttribute("Count",count);
			
			sql = "select * from Place limit 20 offset ?";
			place_list = temp.query(sql, new RestaurantRowMapper(), offset);
		}
		
		return place_list;
		
	}
	
	@Override
	public void addPlace(Place place) { 
		sql = "insert into place values(?,?,?,?,?,?,?,?,?,?)";
		temp.update(sql, place.getAddressName(), place.getRoadAddress(), place.getPlaceName(), place.getCategory(), place.getCategoryAll(), place.getPhone(), place.getPlaceUrl(), place.getPlaceID(), place.getLongitude(), place.getLatitude());
	}
	
	@Override
	public void updatePlace(Place place) {
		sql = "select count(*) from Place where placeID=?";
		int row = temp.queryForObject(sql, Integer.class, place.getPlaceID());
		
		if(row != 0) {
			sql = "update Place set placeName=?, addressName=?, roadAddress=?, category=?, categoryAll=?, phone=?, placeUrl=? where placeID=?";
			temp.update(sql, place.getPlaceName(), place.getAddressName(), place.getRoadAddress(), place.getCategory(), place.getCategoryAll(), place.getPhone(),place.getPlaceUrl(), place.getPlaceID());
		}
	}

	@Override
	public void deletePlace(String placeID) {
		sql = "select count(*) from Place where placeID=?";
		int row = temp.queryForObject(sql, Integer.class, placeID);
		
		if(row != 0) {
			sql = "delete from Place where placeID=?";
			temp.update(sql, placeID);
		}
		
	}


	@Override
	public double[] getLocation(String city, String subCity, String country) {
		
		String keyword = city;
		
		if(subCity != null) { keyword = city + " " + subCity; }
		if(country != null) { keyword = city + " " + subCity + " " + country; }
		
		System.out.println(keyword);
		
		sql = "select longitude from locations where address=?";
		double x = temp.queryForObject(sql, Double.class, keyword);
		
		sql = "select latitude from locations where address=?";
		double y = temp.queryForObject(sql, Double.class, keyword);
		
		double[] result = new double[] { x, y };
		
		return result;
	}






}
