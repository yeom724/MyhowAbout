package com.springproject.repository;

import java.net.URLDecoder;
import java.nio.charset.StandardCharsets;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springproject.domain.Review;

@Repository
public class ReviewRepositoryImpl implements ReviewRepository{
	
	private JdbcTemplate temp;
	String sql;
	
	
	@Autowired
	public void setJdbcTemplate(DataSource dataSource) {
		this.temp = new JdbcTemplate(dataSource);
	}

	@Override
	public void addReview(Review review) {

		sql = "insert into aboutReview values(?,?,?,?,?,?)";
		temp.update(sql, review.getUserId(), review.getReviewText(), review.getReviewDate(), review.getMillisId(), review.getPlaceID(), review.getIconName());

	}

	@Override
	public void updateReview(String millisID, String reviewText) {
		
		sql = "select count(*) from aboutReview where millisId=?";
		int row = temp.queryForObject(sql, Integer.class, millisID);
		
		if(row != 0) {
			
			try { reviewText = URLDecoder.decode(reviewText, StandardCharsets.UTF_8.toString()); }
			catch (Exception e) { e.printStackTrace(); }
			
			sql = "update aboutReview set reviewText=? where millisId=?";
			temp.update(sql, reviewText, millisID);
		}		
	}

	@Override
	public void deleteReview(long millis) {

		sql = "delete from aboutReview where millisId=?";
		temp.update(sql, millis);

	}
	
	@Override
	public Review getReviewByMillis(long millis) {

		Review review = null;
		
		sql="select count(*) from aboutReview where millisId=?";
		int row = temp.queryForObject(sql, Integer.class, millis);
		if(row != 0) {
			System.out.println("일치하는 리뷰를 발견했습니다.");
			sql = "select * from aboutReview where millisId=?";
			review = temp.queryForObject(sql, new ReviewRowMapper(), millis);
		} else { System.out.println("일치하는 리뷰를 발견할 수 없었습니다."); }
		
		return review;
	}

	@Override
	public List<Review> getReviewById(String userId) {
		System.out.println(userId + " : 해당 멤버의 리뷰를 조회합니다.");
		
		sql = "select * from aboutReview where userId=?";
		List<Review> rev_list = temp.query(sql, new ReviewRowMapper(), userId);
		
		if(rev_list.isEmpty() || rev_list == null) {
			System.out.println("리뷰가 존재하지 않습니다.");
			rev_list = null;
		}
		
		System.out.println("해당 멤버 리뷰를 반환합니다.");
		
		return rev_list;
	}

	@Override
	public List<Review> getPlaceAllReview(String placeID) {

		sql = "select * from aboutReview where placeID=?";
		List<Review> rev_list = temp.query(sql, new ReviewRowMapper(), placeID);
		
		if(rev_list.isEmpty() || rev_list == null) {
			rev_list = null;
		}
		
		return rev_list;
	}



}
