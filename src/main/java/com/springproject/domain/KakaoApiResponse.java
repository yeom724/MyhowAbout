package com.springproject.domain;

import java.util.List;

public class KakaoApiResponse {
	
	private List<Place> documents; // 장소 리스트

    public List<Place> getPlaces() {
        return documents;
    }

    public void setPlaces(List<Place> documents) {
        this.documents = documents;
    }
    
}
