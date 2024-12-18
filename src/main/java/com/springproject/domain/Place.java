package com.springproject.domain;

import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import com.fasterxml.jackson.annotation.JsonProperty;

@JsonIgnoreProperties(ignoreUnknown = true)
public class Place {
	
	@JsonProperty("address_name")
	private String addressName;
	
	@JsonProperty("road_address_name")
	private String roadAddress;
	
	@JsonProperty("place_name")
	private String placeName;

	@JsonProperty("category_group_name")
	private String category;
	
	@JsonProperty("category_name")
	private String categoryAll;

	@JsonProperty("phone")
	private String phone;

	@JsonProperty("place_url")
	private String placeUrl;
	
	@JsonProperty("id")
	private String placeID;
	
	@JsonProperty("x")
	private String longitude;
	
	@JsonProperty("y")
	private String latitude;
	
	@JsonProperty("key")
	private String keyword;

	public String getAddressName() {
		return addressName;
	}

	public void setAddressName(String addressName) {
		this.addressName = addressName;
	}

	public String getRoadAddress() {
		return roadAddress;
	}

	public void setRoadAddress(String roadAddress) {
		this.roadAddress = roadAddress;
	}

	public String getPlaceName() {
		return placeName;
	}

	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}

	public String getCategory() {
		return category;
	}

	public void setCategory(String category) {
		this.category = category;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getPlaceUrl() {
		return placeUrl;
	}

	public void setPlaceUrl(String placeUrl) {
		this.placeUrl = placeUrl;
	}

	public String getPlaceID() {
		return placeID;
	}

	public void setPlaceID(String placeID) {
		this.placeID = placeID;
	}

	public String getLongitude() {
		return longitude;
	}

	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}

	public String getLatitude() {
		return latitude;
	}

	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	
	public String getCategoryAll() {
		return categoryAll;
	}

	public void setCategoryAll(String categoryAll) {
		this.categoryAll = categoryAll;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
}
