package com.springproject.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springproject.domain.Member;
import com.springproject.service.MemberService;

@Controller
@RequestMapping("/user")
public class MemberController {
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	MailSender sender;
	
	//선택적 경로
	@GetMapping({"/home", "/home/{email}"})
	public String defalutHome(@PathVariable(required = false) String email, Model model) {
		
		String returnString = "home";
		
		if(email == null) {
			System.out.println("HOME으로 진입합니다.");
		} else {
			
			System.out.println("회원가입 안내 페이지로 진입합니다.");
			model.addAttribute("email", email);
			
		}
		
		return returnString;
	}
	
	@GetMapping("/create")
	public String createMemberForm(@ModelAttribute Member member) {
		System.out.println("회원가입 페이지 진입.");
		return "memberCform";
	}
	
	@PostMapping("/create")
	public String createMember(@ModelAttribute Member member) {
		System.out.println("회원 정보 도착");
		SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");
		member.setUserDate(today.format(new Date()));
		//데이터 형식 지정

		memberService.addMember(member);
		System.out.println("멤버 추가가 완료되었습니다.");
		System.out.println("이메일전송 프로세스 시작");

		String host = "http://localhost:8080/howAbout/user/emailcheck";
		String from = "itedunet@naver.com";
		String to = member.getUserEmail();
		
		String content = "클릭하여 이메일 인증을 완료해주십시오\n" + host+"?userEmail="+to;
		System.out.println(content);
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject("전달메시지");
		message.setText(content);
		message.setFrom(from);
		sender.send(message);
		System.out.println("전송완료");
		
		return "redirect:home/"+member.getUserEmail();
	}
	
	@GetMapping("/emailcheck")
	public String emailCheck(@RequestParam String userEmail, Model model) {
		System.out.println("이메일 인증 컨트롤러 도착");
		
		memberService.emailUpdate(userEmail);
		model.addAttribute("enabled", true);
		
		return "option";
	}
	
	@GetMapping("/read")
	public String readOneMember() {
		System.out.println("멤버 조회 페이지 진입");
		return "memberR";
	}
	
	@GetMapping("/login")
	public String userLogin() {
		System.out.println("로그인 페이지로 이동합니다.");
		return "memberLogin";
	}
	
	@PostMapping("/login")
	public String userGetSession(HttpServletRequest req, Model model) {
		System.out.println("로그인 확인 중...");
		HttpSession session = null;
		
		String userId = req.getParameter("userId");
		String userPw = req.getParameter("userPw");
		
		Member member = memberService.loginMember(userId, userPw);
		
		if(member != null) {
			System.out.println("세션 생성을 시작합니다.");
			session = req.getSession(true);
			session.setAttribute("userStatus", member);
		} else { System.out.println("로그인에 실패했습니다."); }
		
		return "redirect:home";
	}
	
	@GetMapping("/logout")
	public String userDeleteSession(HttpServletRequest req) {
		System.out.println("로그아웃 진행중...");
		
		HttpSession session = req.getSession(false);

		if(session != null) {
			session.invalidate();
			System.out.println("로그아웃을 완료했습니다.");
		}
		
		return "redirect:home";
	}
	
	@PostMapping("/oneUser")
	public String readOne(HttpServletRequest req, Model model) {
		System.out.println("/read/oneUser 도착");
		String userId = req.getParameter("userId");
		
		Member member = memberService.getMember(userId);
		System.out.println("멤버 정보를 컨트롤러에 저장하였습니다.");
		
		model.addAttribute("member", member);
		
		return "memberOneR";
	}
	
	@GetMapping("/allUser")
	public String readAll(Model model) {
		System.out.println("/read/allUser 도착");
		
		List<Member> listMember = memberService.getAllMember();
		model.addAttribute("list",listMember);
		
		return "memberAllR";
	}
	
	@GetMapping("/update")
	public String updateMember(@ModelAttribute Member member) {
		System.out.println("회원 정보 업데이트 화면으로 이동합니다.");
		return "memberUpdate";
	}
	
	@PostMapping("/update")
	public String updateMemberStatus(@ModelAttribute Member member) {
		System.out.println("회원 정보를 수정합니다.");
		
		memberService.updateMember(member);
		
		System.out.println("수정이 완료되었습니다. 홈페이지로 넘어갑니다.");
		return "redirect:home";
	}
	
	@GetMapping("/delete")
	public String deleteMember(HttpServletRequest req) {
		System.out.println("회원 정보를 삭제합니다.");
		
		HttpSession session = req.getSession(false);
		Member member = (Member) session.getAttribute("userStatus");
		
		if(member != null) {
			String userId = member.getUserId();
			memberService.deleteMember(userId);
			session.invalidate();
			System.out.println("회원 정보가 삭제되면서 로그아웃 진행합니다.");
		}
		
		return "redirect:home";
	}
}
