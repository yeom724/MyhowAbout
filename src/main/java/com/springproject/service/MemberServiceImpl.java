package com.springproject.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.springproject.domain.Member;
import com.springproject.domain.deleteplace;
import com.springproject.repository.MemberRepository;

@Service
public class MemberServiceImpl implements MemberService{
	
	@Autowired
	MemberRepository memberRepository;

	@Override
	public void addMember(Member member) { memberRepository.addMember(member); }

	@Override
	public Member getMember(String userId) { return memberRepository.getMember(userId); }

	@Override
	public List<Member> getAllMember() { return memberRepository.getAllMember(); }

	@Override
	public void updateMember(Member member) { memberRepository.updateMember(member); }

	@Override
	public void deleteMember(String userId) { memberRepository.deleteMember(userId); }

	@Override
	public Member loginMember(String userId, String userPw) { return memberRepository.loginMember(userId, userPw); }

	@Override
	public void certification(String email) { memberRepository.certification(email); }

	@Override
	public Member getMemberEmail(String email) { return memberRepository.getMemberEmail(email); }

}
