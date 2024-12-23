package com.springproject.repository;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.springproject.domain.Member;

public class MemberRowMapper implements RowMapper<Member>{

	@Override
	public Member mapRow(ResultSet rs, int rowNum) throws SQLException {
		System.out.println("MySQL에서 Member 정보를 받아오는 중...");
		
		Member member = new Member();
		
		member.setUserName(rs.getString(1));
		member.setUserId(rs.getString(2));
		member.setUserPw(rs.getString(3));
		member.setUserTel(rs.getString(4));
		member.setUserAddr(rs.getString(5));
		member.setNx(rs.getInt(6));
		member.setNy(rs.getInt(7));
		member.setUserDate(rs.getString(8));
		member.setUserEmail(rs.getString(9));
		member.setEnabled(rs.getBoolean(10));
		member.setIconName(rs.getString(11));
		
		System.out.println("Member 정보 반환완료");
		return member;
	}

	

}
