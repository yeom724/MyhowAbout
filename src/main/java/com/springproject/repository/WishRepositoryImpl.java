package com.springproject.repository;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

import com.springproject.domain.Place;

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

}
