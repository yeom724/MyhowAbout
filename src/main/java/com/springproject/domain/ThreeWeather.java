package com.springproject.domain;

import com.fasterxml.jackson.annotation.JsonProperty;

public class ThreeWeather {
	
	@JsonProperty("baseDate")
	String baseDate;
	
	@JsonProperty("baseTime")
	String baseTime;
	
	@JsonProperty("fcstDate")
	String fcstDate;
	
	@JsonProperty("fcstTime")
	String fcstTime;
	
	@JsonProperty("category")
	String category;
	
	@JsonProperty("fcstValue")
	String fcstValue;
	
	@JsonProperty("nx")
	String nx;
	
	@JsonProperty("ny")
	String ny;

	public String getBaseDate() {
		return baseDate;
	}

	public void setBaseDate(String baseDate) {
		this.baseDate = baseDate;
	}

	public String getBaseTime() {
		return baseTime;
	}

	public void setBaseTime(String baseTime) {
		this.baseTime = baseTime;
	}

	public String getFcstDate() {
		return fcstDate;
	}

	public void setFcstDate(String fcstDate) {
		this.fcstDate = fcstDate;
	}

	public String getFcstTime() {
		return fcstTime;
	}

	public void setFcstTime(String fcstTime) {
		this.fcstTime = fcstTime;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getFcstValue() {
		return fcstValue;
	}

	public void setFcstValue(String fcstValue) {
		this.fcstValue = fcstValue;
	}

	public String getNx() {
		return nx;
	}

	public void setNx(String nx) {
		this.nx = nx;
	}

	public String getNy() {
		return ny;
	}

	public void setNy(String ny) {
		this.ny = ny;
	}


}
