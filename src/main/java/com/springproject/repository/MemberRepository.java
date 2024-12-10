package com.springproject.repository;

import java.util.List;

import org.springframework.ui.Model;

import com.springproject.domain.Member;

public interface MemberRepository {
	
	void addMember(Member member);
	
	Member getMember(String userId);
	
	void emailUpdate(String email);
	
	List<Member> getAllMember();
	
	void updateMember(Member member);
	
	void deleteMember(String userId);
	
	Member loginMember(String userId, String userPw);
	
}
