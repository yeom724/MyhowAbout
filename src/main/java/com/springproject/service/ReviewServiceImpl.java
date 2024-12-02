package com.springproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Review;
import com.springproject.repository.ReviewRepository;

@Service
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	ReviewRepository reviewRepository;

	@Override
	public void addReview(Review review) {
		System.out.println("addReview 서비스 도착");
		reviewRepository.addReview(review);
	}

	@Override
	public Review getReviewByMillis(long millis) {
		System.out.println("getReviewByMillis 서비스 도착");
		return reviewRepository.getReviewByMillis(millis);
	}

	@Override
	public List<Review> getReviewById(String userId) {
		System.out.println("getReviewById 서비스 도착");
		
		List<Review> rev_list = reviewRepository.getReviewById(userId);
		
		return rev_list;
	}

	@Override
	public List<Review> getAllReview() {
		System.out.println("getAllReview() 서비스 도착");
		
		List<Review> rev_list = reviewRepository.getAllReview();
		
		return rev_list;
	}

	@Override
	public void updateReview(Review review) {
		System.out.println("updateReview 서비스 도착");
		reviewRepository.updateReview(review);
	}

	@Override
	public void deleteReview(long millis) {
		System.out.println("deleteReview 서비스 도착");
		reviewRepository.deleteReview(millis);
	}

}
