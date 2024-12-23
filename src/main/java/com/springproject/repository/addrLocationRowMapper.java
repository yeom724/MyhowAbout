package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springproject.domain.Member;
import com.springproject.domain.addrLocation;

public class addrLocationRowMapper implements RowMapper<addrLocation>{

	@Override
	public addrLocation mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		addrLocation location = new addrLocation();
		
		location.setAddress(rs.getString(2));
		location.setLongitude(rs.getDouble(3));
		location.setLatitude(rs.getDouble(4));
		location.setNx(rs.getInt(5));
		location.setNy(rs.getInt(6));
		
		return location;
	}

	

}
