package com.springproject.repository;

import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.IncorrectResultSizeDataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springproject.domain.Place;
import com.springproject.domain.Wish;

@Repository
public class WishRepositoryImpl implements WishRepository {
	
    private JdbcTemplate temp;
    String sql;

    @Autowired
    public void setJdbcTemplate(DataSource dataSource) {
        this.temp = new JdbcTemplate(dataSource);
    }

	@Override
	public boolean addWishList(String userId, Place place) {
		
		boolean result = false;
		
		sql = "select count(*) from aboutWishList where userId=? and placeId=?";
		int row = temp.queryForObject(sql, Integer.class, userId, place.getPlaceID());

		if(row == 0) {
			sql = "insert into aboutWishList values(?,?,?)";
			temp.update(sql, userId, place.getPlaceID(), place.getPlaceName());
			result = true;
		}
		
		return result;
	}

	@Override
	public List<Wish> getMyList(String userId) {
		
		List<Wish> list = null;
		
		sql = "select count(*) from aboutWishList where userId=?";
		int row = temp.queryForObject(sql, Integer.class, userId);
		
		if(row != 0) {
			sql = "select * from aboutWishList where userId=?";
			
			try {
				
				Wish wish = temp.queryForObject(sql, new WishRowMapper(), userId);
				list = new ArrayList<Wish>();
				list.add(wish);
				
			} catch(IncorrectResultSizeDataAccessException e) { list = temp.query(sql, new WishRowMapper(), userId); }
			
		}
		
		return list;
	}

	@Override
	public void deleteWish(String placeID, String userId) {
		
		sql = "select count(*) from aboutWishList where userId=? and placeID=?";
		int row = temp.queryForObject(sql, Integer.class, userId, placeID);
		
		if(row == 1) {
			System.out.println("삭제 실행");
			sql = "delete from aboutWishList where userId=? and placeID=?";
			temp.update(sql, userId, placeID);
		}
		
	}

}
