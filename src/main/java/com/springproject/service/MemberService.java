package com.springproject.service;

import java.util.List;

import com.springproject.domain.Member;
import com.springproject.domain.Place;

public interface MemberService {

	void addMember(Member member);
	
	Member getMember(String userId);
	
	void emailUpdate(String email);
	
	List<Member> getAllMember();
	
	void updateMember(Member member);
	
	void deleteMember(String userId);
	
	Member loginMember(String userId, String userPw);
	
}
