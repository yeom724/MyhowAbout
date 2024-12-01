package com.springproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Member;
import com.springproject.repository.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberRepository memberRepository;

	@Override
	public void addMember(Member member) {
		System.out.println("addMember 서비스 도착");
		memberRepository.addMember(member);
		
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
