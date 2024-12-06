package com.springproject.Jackson;

import com.fasterxml.jackson.annotation.JsonProperty;

public class MobumResultSet {
	
	@JsonProperty("gyeongnamgoodrestaurantlist")
	private GyeongnamGoodRestaurantList gyeongnamGoodRestaurantList;

	public GyeongnamGoodRestaurantList getGyeongnamGoodRestaurantList() {
		return gyeongnamGoodRestaurantList;
	}

	public void setGyeongnamGoodRestaurantList(GyeongnamGoodRestaurantList gyeongnamGoodRestaurantList) {
		this.gyeongnamGoodRestaurantList = gyeongnamGoodRestaurantList;
	}
	
}

