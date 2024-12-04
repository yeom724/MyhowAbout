package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.springproject.domain.Place;


public class PlaceRowMapper implements RowMapper<Place>{

	@Override
	public Place mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		Place place = new Place();
		
		place.setJuso(rs.getString(1));
		place.setJibun(rs.getString(2));
		place.setCategory(rs.getString(3));
		place.setTitle(rs.getString(4));
		place.setStatus(rs.getString(5));
		place.setFoodCategory(rs.getString(6));
		place.setLatitude(rs.getDouble(7));
		place.setLongitude(rs.getDouble(8));

		return place;
	}

	

}