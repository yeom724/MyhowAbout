package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springproject.domain.Review;

public class ReviewRowMapper implements RowMapper<Review>{

	@Override
	public Review mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		Review review = new Review();
		
		review.setUserId(rs.getString(1));
		review.setReviewText(rs.getString(2));
		review.setReviewDate(rs.getString(3));
		review.setMillisId(rs.getLong(4));
		review.setPlaceID(rs.getString(5));
		review.setIconName(rs.getString(6));

		return review;
	}

	

}
