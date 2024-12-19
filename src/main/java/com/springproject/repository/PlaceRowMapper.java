package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;

import com.springproject.domain.deleteplace;
import com.springproject.domain.Place;


public class PlaceRowMapper implements RowMapper<Place>{

	@Override
	public Place mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		Place rest = new Place();
		
		rest.setAddressName(rs.getString(1));
		rest.setRoadAddress(rs.getString(2));
		rest.setPlaceName(rs.getString(3));
		rest.setCategory(rs.getString(4));
		rest.setCategoryAll(rs.getString(5));
		rest.setPhone(rs.getString(6));
		rest.setPlaceUrl(rs.getString(7));
		rest.setPlaceID(rs.getString(8));
		rest.setLongitude(rs.getString(9));
		rest.setLatitude(rs.getString(10));

		return rest;
	}

	

}
