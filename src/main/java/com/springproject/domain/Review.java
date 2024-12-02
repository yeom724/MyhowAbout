package com.springproject.domain;

public class Review {
	String userId;
	String reviewText;
	String reviewDate;
	long millisId;		//작성일의 밀리초가 고유의 아이디가 됨

	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getReviewText() {
		return reviewText;
	}
	public void setReviewText(String reviewText) {
		this.reviewText = reviewText;
	}
	public String getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(String reviewDate) {
		this.reviewDate = reviewDate;
	}
	public long getMillisId() {
		return millisId;
	}
	public void setMillisId(long millisId) {
		this.millisId = millisId;
	}

	
	
}
