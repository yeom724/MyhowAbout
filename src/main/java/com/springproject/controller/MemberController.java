package com.springproject.controller;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springproject.domain.Member;
import com.springproject.service.MemberService;

@Controller
@RequestMapping("/user")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/create")
	public String createMemberForm(@ModelAttribute Member member) {
		System.out.println("회원가입 페이지 진입.");
		return "memberCform";
	}
	
	@PostMapping("/create")
	public String createMember(@ModelAttribute Member member) {
		System.out.println("회원 정보 도착");
		SimpleDateFormat today = new SimpleDateFormat("yyyy/MM/dd");
		member.setUserDate(today.format(new Date()));
		//데이터 형식 지정
		
		System.out.println(member.getUserName());
		System.out.println(member.getUserId());
		System.out.println(member.getUserPw());
		System.out.println(member.getUserTel());
		System.out.println(member.getUserAddr());
		System.out.println(member.getUserDate());
		
		memberService.addMember(member);
		System.out.println("멤버 추가가 완료되었습니다.");
		
		return "home";
	}
	
	@GetMapping("/read")
	public String readOneMember() {
		System.out.println("멤버 조회 페이지 진입");
		return "memberR";
	}
}
