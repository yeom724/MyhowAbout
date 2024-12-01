package com.springproject.repository;

import java.util.List;

import javax.annotation.PreDestroy;
import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Repository;

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
		System.out.println("addMember 레파지토리 도착");
		
		sql = "insert into aboutMember values(?,?,?,?,?,?)";
		temp.update(sql, member.getUserName(), member.getUserId(), member.getUserPw(), member.getUserTel(), member.getUserAddr(), member.getUserDate());
		
		System.out.println("aboutMember 테이블에 새 멤버 정보를 입력했습니다.");
	}

	@Override
	public Member getMember(String userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Member> getAllMember() {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateMember(Member member) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteMember(String userId) {
		// TODO Auto-generated method stub
		
	}

}
