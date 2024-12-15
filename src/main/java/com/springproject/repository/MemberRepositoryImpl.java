package com.springproject.repository;

import java.util.List;

import javax.annotation.PreDestroy;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.ui.Model;

import com.springproject.domain.Member;

@Repository
public class MemberRepositoryImpl implements MemberRepository{
	
	private JdbcTemplate temp;
	String sql;
	
	@Autowired
	public void setJdbcTemplate(DataSource dataSource) {
		this.temp = new JdbcTemplate(dataSource);
	}
	

	@Override
	public void addMember(Member member) {

		sql = "insert into aboutMember values(?,?,?,?,?,?,?,?,?)";
		
		if(member.isEnabled()) {
			temp.update(sql, member.getUserName(), member.getUserId(), member.getUserPw(), member.getUserTel(), member.getUserAddr(), member.getUserDate(), member.getUserEmail(), true, member.getIconName());
			
		} else {
			temp.update(sql, member.getUserName(), member.getUserId(), member.getUserPw(), member.getUserTel(), member.getUserAddr(), member.getUserDate(), member.getUserEmail(), false, member.getIconName());
		}

	}
	
	@Override
	public void certification(String email) {
		
		sql="select count(*) from aboutMember where userEmail=?";
		int row = temp.queryForObject(sql, Integer.class, email);
		
		if(row != 0) {
			sql = "update aboutMember set enabled=true where userEmail=?";
			temp.update(sql, email);
		}

	}

	@Override
	public Member getMember(String userId) {
		
		Member member = null;
		
		sql="select count(*) from aboutMember where userId=?";
		int row = temp.queryForObject(sql, Integer.class, userId);
		if(row != 0) {
			sql = "select * from aboutMember where userId=?";
			member = temp.queryForObject(sql, new MemberRowMapper(), userId);
		}
		
		return member;
	}
	
	@Override
	public Member getMemberEmail(String email) {
		
		Member member = null;
		
		sql="select count(*) from aboutMember where userEmail=?";
		int row = temp.queryForObject(sql, Integer.class, email);
		
		if(row != 0) {
			sql = "select * from aboutMember where userEmail=?";
			member = temp.queryForObject(sql, new MemberRowMapper(), email);
		}
		
		return member;
	}

	@Override
	public List<Member> getAllMember() {

		sql = "select * from aboutMember";
		List<Member> mem_list = temp.query(sql, new MemberRowMapper());

		return mem_list;
	}

	@Override
	public void updateMember(Member member) {
		
		sql = "update aboutMember set userName=?, userPw=?, userTel=?, userAddr=?, iconName=? where userId=?";
		temp.update(sql, member.getUserName(), member.getUserPw(), member.getUserTel(), member.getUserAddr(), member.getIconName(), member.getUserId());
		
	}

	@Override
	public void deleteMember(String userId) {

		sql="select count(*) from aboutMember where userId=?";
		int row = temp.queryForObject(sql, Integer.class, userId);
		if(row != 0) {
			sql = "delete from aboutMember where userId=?";
			temp.update(sql, userId);
		} else {
			System.out.println("일치하는 회원을 찾을 수 없었습니다.");
		}

	}


	@Override
	public Member loginMember(String userId, String userPw) {
		Member member = null;
		
		sql="select count(*) from aboutMember where userId=?";
		int row = temp.queryForObject(sql, Integer.class, userId);
		
		if(row != 0) {
			sql = "select * from aboutMember where userId=?";
			Member session = temp.queryForObject(sql, new MemberRowMapper(), userId);
			
			if(session.getUserPw().equals(userPw)) {
				member = session;
			}
		}
		
		return member;
	}


}
