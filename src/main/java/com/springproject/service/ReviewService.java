package com.springproject.service;

import java.util.List;

import com.springproject.domain.Review;

public interface ReviewService {
	
	void addReview(Review review);
	
	Review getReviewByMillis(long millis); 			//리뷰 한 개 불러오기
	
	List<Review> getReviewById(String userId); 		//작성한 아이디 기준으로 리뷰목록 불러오기
	
	List<Review> getAllReview();					//모든 리뷰 불러오기 (추후 장소가 추가되면 좌표값 받아야 함)

	void updateReview(Review review);
	
	void deleteReview(long millis);
	
}
