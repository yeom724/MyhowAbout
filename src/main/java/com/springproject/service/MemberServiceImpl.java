package com.springproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Member;
import com.springproject.domain.Place;
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
		System.out.println("getMember 서비스 도착");
		Member member = memberRepository.getMember(userId);
		return member;
	}

	@Override
	public List<Member> getAllMember() {
		System.out.println("getAllMember 서비스 도착");
		List<Member> listMember = memberRepository.getAllMember();
		return listMember;
	}

	@Override
	public void updateMember(Member member) {
		System.out.println("updateMember 서비스 도착");
		memberRepository.updateMember(member);
	}

	@Override
	public void deleteMember(String userId) {
		System.out.println("deleteMember 서비스 도착");
		memberRepository.deleteMember(userId);
	}

	@Override
	public Member loginMember(String userId, String userPw) {
		System.out.println("loginMember 서비스 도착");
		Member member = memberRepository.loginMember(userId, userPw);
		return member;
	}

	@Override
	public void emailUpdate(String email) {
		System.out.println("emailUpdate 서비스 도착");
		memberRepository.emailUpdate(email);
	}



}
