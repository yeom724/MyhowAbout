package com.springproject.service;

import java.util.List;

import com.springproject.domain.Member;
import com.springproject.domain.deleteplace;

public interface MemberService {

	void addMember(Member member);
	
	void certification(String email);
	
	Member getMember(String userId);
	
	Member getMemberEmail(String email);
	
	List<Member> getAllMember();
	
	void updateMember(Member member);
	
	void deleteMember(String userId);
	
	Member loginMember(String userId, String userPw);
	
}
