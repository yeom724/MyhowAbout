package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;
import com.springproject.domain.Wish;

public class WishRowMapper implements RowMapper<Wish>{

	@Override
	public Wish mapRow(ResultSet rs, int rowNum) throws SQLException {
		
		Wish wish = new Wish();
		
		wish.setUserId(rs.getString(1));
		wish.setPlaceId(rs.getString(2));
		wish.setPlaceName(rs.getString(3));

		return wish;
	}

	

}
