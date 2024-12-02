package com.springproject.service;

import java.util.List;

import com.springproject.domain.Member;

public interface MemberService {

	void addMember(Member member);
	
	Member getMember(String userId);
	
	List<Member> getAllMember();
	
	void updateMember(Member member);
	
	void deleteMember(String userId);
	
	Member loginMember(String userId, String userPw);
	
}
