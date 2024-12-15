package com.springproject.service;

import java.util.List;

import com.springproject.domain.Review;

public interface ReviewService {
	
	void addReview(Review review);
	
	Review getReviewByMillis(long millis); 			
	
	List<Review> getReviewById(String userId); 		
	
	List<Review> getPlaceAllReview(String placeID);	

	void updateReview(String millisID, String reviewText);
	
	void deleteReview(long millis);
	
}
