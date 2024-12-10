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
		System.out.println("addMember 레파지토리 도착");
		
		sql = "insert into aboutMember values(?,?,?,?,?,?,?,?)";
		temp.update(sql, member.getUserName(), member.getUserId(), member.getUserPw(), member.getUserTel(), member.getUserAddr(), member.getUserDate(), member.getUserEmail(), false);
		
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
		System.out.println("멤버 정보를 업데이트 합니다.");
		
		sql = "update aboutMember set userName=?, userPw=?, userTel=?, userAddr=? where userId=?";
		temp.update(sql, member.getUserName(), member.getUserPw(), member.getUserTel(), member.getUserAddr(), member.getUserId());
		
		System.out.println("정보 업데이트가 완료되었습니다.");
		
	}

	@Override
	public void deleteMember(String userId) {
		System.out.println("회원 탈퇴를 진행합니다.");
		
		sql="select count(*) from aboutMember where userId=?";
		int row = temp.queryForObject(sql, Integer.class, userId);
		if(row != 0) {
			sql = "delete from aboutMember where userId=?";
			temp.update(sql, userId);
			System.out.println("회원 탈퇴가 완료되었습니다.");
		} else {
			System.out.println("일치하는 회원을 찾을 수 없었습니다.");
		}

	}


	@Override
	public Member loginMember(String userId, String userPw) {
		System.out.println("입력한 회원 정보를 조회합니다.");
		Member member = null;
		
		sql="select count(*) from aboutMember where userId=?";
		
		int row = temp.queryForObject(sql, Integer.class, userId);
		
		if(row != 0) {
			System.out.println("일치하는 아이디를 발견했습니다.");
			
			sql = "select * from aboutMember where userId=?";
			Member session = temp.queryForObject(sql, new MemberRowMapper(), userId);
			
			if(session.getUserPw().equals(userPw)) {
				System.out.println("비밀번호가 일치합니다.");
				member = session;

			} else { System.out.println("비밀번호가 일치하지 않습니다."); }

		} else { System.out.println("아이디가 일치하지 않습니다."); }
		
		return member;
	}


	@Override
	public void emailUpdate(String email) {
		System.out.println("이메일 인증 완료 페이지 진입");
		
		sql = "update aboutMember set enabled=true where userEmail=?";
		temp.update(sql, email);
		
		System.out.println("이메일 인증이 완료되었습니다.");
		
	}

}
