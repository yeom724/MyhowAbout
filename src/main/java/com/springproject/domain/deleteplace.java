package com.springproject.domain;

import com.springproject.Jackson.GyeongnamGoodRestaurantList;

public class deleteplace {
	
	private Place restaurant;
	
	String juso;
	String jibun;
	String category;
	String title;
	String status;
	String foodCategory;
	double latitude;
	double longitude;
	int updateNum;
	
	public String getJuso() {
		return juso;
	}
	public void setJuso(String juso) {
		this.juso = juso;
	}
	public String getJibun() {
		return jibun;
	}
	public void setJibun(String jibun) {
		this.jibun = jibun;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public String getFoodCategory() {
		return foodCategory;
	}
	public void setFoodCategory(String foodCategory) {
		this.foodCategory = foodCategory;
	}
	public int getUpdateNum() {
		return updateNum;
	}
	public void setUpdateNum(int updateNum) {
		this.updateNum = updateNum;
	}
	public Place getRestaurant() {
		return restaurant;
	}
	public void setRestaurant(Place restaurant) {
		this.restaurant = restaurant;
	}
	
	
	
}
