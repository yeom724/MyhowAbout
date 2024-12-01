package com.springproject.repository;

import java.util.List;

import com.springproject.domain.Member;

public interface MemberRepository {
	
	void addMember(Member member);
	
	Member getMember(String userId);
	
	List<Member> getAllMember();
	
	void updateMember(Member member);
	
	void deleteMember(String userId);
	
}
