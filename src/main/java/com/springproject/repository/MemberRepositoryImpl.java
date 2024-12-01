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
		System.out.println(userId + " : 해당 아이디의 멤버 조회를 시작합니다.");
		
		Member member = null;
		
		sql="select count(*) from aboutMember where userId=?";
		int row = temp.queryForObject(sql, Integer.class, userId);
		if(row != 0) {
			System.out.println("일치하는 아이디를 발견했습니다.");
			sql = "select * from aboutMember where userId=?";
			member = temp.queryForObject(sql, new MemberRowMapper(), userId);
		} else { System.out.println("일치하는 회원을 발견할 수 없었습니다."); }
		
		System.out.println("해당 멤버 정보를 전송합니다.");
		return member;
	}

	@Override
	public List<Member> getAllMember() {
		System.out.println("전체 멤버 조회를 시작합니다.");
		
		sql = "select * from aboutMember";
		List<Member> mem_list = temp.query(sql, new MemberRowMapper());
		
		System.out.println("전체 멤버 조회가 끝났습니다.");
		return mem_list;
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
