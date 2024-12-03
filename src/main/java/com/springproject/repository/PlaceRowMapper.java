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

		return place;
	}

	

}
