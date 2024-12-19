package com.springproject.controller;


import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.springproject.domain.Member;
import com.springproject.service.MemberService;

@Controller
@RequestMapping("/user")
public class MemberController{
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private MailSender sender;
	
	private final RestTemplate restTemplate = new RestTemplate();
	
	@Value("14cdbb863b4c2d47cee16ab2b06356c6")
    private String restApiKey;
	
	//@Value("http://172.16.6.80:8080/howAbout/user/kakao/callback")
	@Value("http://localhost:8080/howAbout/user/kakao/callback")
    private String redirectUri;

	@GetMapping({"/home", "/home/{email}"})
	public String defalutHome(@PathVariable(required = false) String email, Model model) {
		
		if(email != null) {
			Member member = memberService.getMemberEmail(email);
			model.addAttribute("newUser", member);
		}
		
		return "home";
	}
	
	//회원가입 페이지 이동
	@GetMapping("/joinMember")
	public String createMemberForm(@ModelAttribute Member member) { return "member/memberAdd"; }
	
	@PostMapping("/joinMember")
	public String createMember(@ModelAttribute Member member, @RequestParam("userIcon") MultipartFile file, HttpServletRequest req) {
		
		long timestamp = System.currentTimeMillis();
		String fileName = null;
		
        if (!(file.isEmpty()) && file != null) {
            try {
                fileName = timestamp + "_" +file.getOriginalFilename();
                File saveFile = new File(req.getServletContext().getRealPath("/resources/userIcon/") + fileName);
                file.transferTo(saveFile);
                
            } catch (Exception e) { e.printStackTrace(); }
        } else {
        	fileName = "icon.jpg";
        }

		SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");
		
		member.setUserDate(today.format(new Date()));
		member.setIconName(fileName);
		memberService.addMember(member);

		String host = "http://localhost:8080/howAbout/user/emailcheck";
		String from = "itedunet@naver.com";
		String to = member.getUserEmail();
		
		String content = "클릭하여 이메일 인증을 완료해주십시오\n" + host+"?userEmail="+to;
		
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(to);
		message.setSubject("전달메시지");
		message.setText(content);
		message.setFrom(from);
		sender.send(message);
		
		return "redirect:home/"+member.getUserEmail();
		
	}
	
	@ResponseBody
	@PostMapping("/matchUser")
	public Map<String, Boolean> matchUser(@RequestBody Map<String, String> data) {
		
		String userEmail = null;
		String userId = null;
		Map<String, Boolean> result = new HashMap<String, Boolean>();
		
		if(data.containsKey("userEmail")) {
			userEmail = data.get("userEmail");
			result.put("email", true);
		}
		
		if(data.containsKey("userId")) { 
			userId = data.get("userId");
			result.put("userId", true);
		}

		Member member = null;
		
		if(userId != null) {
			member = memberService.getMember(userId);
		} else if(userEmail != null) {
			member = memberService.getMemberEmail(userEmail);
		}

		if(member != null) { result.put("status", false);}
		else { result.put("status", true); }
		
		return result;
	}
	
	@GetMapping("/emailcheck")
	public String emailCheck(@RequestParam String userEmail, RedirectAttributes redirectAttributes, HttpSession session) {

		if(session != null) { session.invalidate(); }
		
		memberService.certification(userEmail);
		Member member = memberService.getMemberEmail(userEmail);
		redirectAttributes.addFlashAttribute("newUser", member);
		
		return "redirect:/user/home";
	}
	
	//일반 로그인
	@GetMapping("/login")
	public String userLogin() { return "member/memberLogin"; }
	
	@PostMapping("/login")
	public String userGetSession(HttpServletRequest req, RedirectAttributes redirectAttributes) {
		
		String home = "redirect:home";
		
		HttpSession session = null;
		
		String userId = req.getParameter("userId");
		String userPw = req.getParameter("userPw");
		
		Member member = memberService.loginMember(userId, userPw);
		
		if(member != null) {
			session = req.getSession(true);
			session.setAttribute("userStatus", member);
		} else { 
			redirectAttributes.addFlashAttribute("miss","로그인 실패");
			home = "redirect:login";
		}
		
		return home;
	}
	
	//카카오 로그인
	@GetMapping("/kakao/login")
	public String kakaoLogin() {
		System.out.println("카카오 로그인 페이지로 이동합니다.");
		String kakaoLoginUrl = "https://kauth.kakao.com/oauth/authorize?client_id=" + restApiKey +
							   "&redirect_uri=" + redirectUri +
							   "&response_type=code";
		
		return "redirect:"+kakaoLoginUrl;
	}
	
	// 카카오 콜백 처리
    @GetMapping("/kakao/callback")
    public String kakaoCallback(@RequestParam String code, Model model, HttpServletRequest req) {
        String accessToken = getAccessToken(code); // 액세스 토큰 요청
        return getUserInfo(accessToken, model, req); // 사용자 정보 요청 및 모델에 추가
    }

    // 액세스 토큰 요청 메서드
    private String getAccessToken(String code) {
        String tokenUrl = "https://kauth.kakao.com/oauth/token";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Content-Type", "application/x-www-form-urlencoded");

        // 요청 본문 생성
        String requestBody = "grant_type=authorization_code" +
                             "&client_id=" + restApiKey +
                             "&redirect_uri=" + redirectUri +
                             "&code=" + code;

        HttpEntity<String> request = new HttpEntity<>(requestBody, headers);
        ResponseEntity<String> response = restTemplate.exchange(tokenUrl, HttpMethod.POST, request, String.class);

        return extractAccessToken(response.getBody()); // JSON 응답에서 액세스 토큰 추출
    }

    // JSON에서 액세스 토큰 추출하는 메서드
    private String extractAccessToken(String jsonResponse) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode jsonNode = mapper.readTree(jsonResponse);
            return jsonNode.get("access_token").asText();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    // 사용자 정보 요청 메서드
    private String getUserInfo(String accessToken, Model model, HttpServletRequest req) {
        String userInfoUrl = "https://kapi.kakao.com/v2/user/me";

        HttpHeaders headers = new HttpHeaders();
        headers.set("Authorization", "Bearer " + accessToken);

        HttpEntity<String> request = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange(userInfoUrl, HttpMethod.GET, request, String.class);

        addUserToModel(response.getBody(), model, req);

        return "redirect:/user/home";
    }

    // 모델에 사용자 정보를 추가하는 메서드
    private void addUserToModel(String jsonResponse, Model model, HttpServletRequest req) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode jsonNode = mapper.readTree(jsonResponse);
            HttpSession session = null;
            
            String id = jsonNode.get("id").asText();
            String name = jsonNode.get("properties").get("nickname").asText();
            
            Member member = memberService.getMember("kakaouser"+id);
            
            if(member == null) {

            	Random random = new Random();
            	SimpleDateFormat today = new SimpleDateFormat("yyyy-MM-dd");
            	
                int pwNum = 100000+random.nextInt(900000);
                String pwStr = String.valueOf(pwNum);
                String fileName = "icon.jpg";
                
                member = new Member();
                
                member.setUserName(name);
                member.setUserId("kakaouser"+id);
                member.setUserPw(pwStr);
        		member.setUserDate(today.format(new Date()));
        		member.setEnabled(true);
        		member.setIconName(fileName);
        		memberService.addMember(member);
            }
            
            Member user = memberService.loginMember(member.getUserId(), member.getUserPw());
            
            if(user != null) {
    			System.out.println("세션 생성을 시작합니다.");
    			session = req.getSession(true);
    			session.setAttribute("userStatus", user);
    		}
    
            
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
	
	@GetMapping("/logout")
	public String userDeleteSession(HttpServletRequest req) {
		
		HttpSession session = req.getSession(false);

		if(session != null) {
			session.invalidate();
		}
		
		return "redirect:home";
	}
	
	@GetMapping("/update/{memberID}")
	public String updateMemberForm(@ModelAttribute Member member, HttpServletRequest req, @PathVariable String memberID) {
		
		String result = null;
		HttpSession session = req.getSession(false);
		
		if(session != null) {
			Member user = (Member)session.getAttribute("userStatus");
			if(user != null) {
				if(user.getUserId().equals(memberID)) {
					result = "member/memberUpdate";
				} else { result = "redirect:/error/403"; }
			} else { result = "redirect:/error/401"; }
		} else { result = "redirect:/error/401"; }
		
		return result;
	}
	
	@PostMapping("/update/{memberID}")
	public String updateMember(@ModelAttribute Member member, HttpServletRequest req, @PathVariable String memberID, @RequestParam("userIcon") MultipartFile file) {
		
		String result = null;
		String fileName = null;
		HttpSession session = req.getSession(false);
		long timestamp = System.currentTimeMillis();
		
		if(session != null) {
			Member user = (Member)session.getAttribute("userStatus");
			if(user != null) {
				if(user.getUserId().equals(memberID)) {
					if (!(file.isEmpty()) && file != null) {
			            try {
			                fileName = timestamp + "_" +file.getOriginalFilename();
			                File saveFile = new File(req.getServletContext().getRealPath("/resources/userIcon/") + fileName);
			                System.out.println(req.getServletContext().getRealPath("/resources/userIcon/") + fileName);
			                file.transferTo(saveFile);
			                
			            } catch (Exception e) { e.printStackTrace(); }

			        } else {
			        	fileName = user.getIconName();
			        }

					member.setIconName(fileName);
					memberService.updateMember(member);
					Member newData = memberService.loginMember(user.getUserId(), user.getUserPw());
		            session.setAttribute("userStatus", newData);
					result = "redirect:/user/home";
					
				} else { result = "redirect:/error/403"; }
			} else { result = "redirect:/error/401"; }
		} else { result = "redirect:/error/401"; }

		return result;
	}

	
	@GetMapping("/readAll")
	public String readMemberPage(Model model) { 
		
		model.addAttribute("list", memberService.getAllMember() );
		return "member/memberRead";
		
	}
	
	@PostMapping("/readOne")
	public String readOne(HttpServletRequest req, Model model, @RequestParam(required = false) String userId, @RequestParam(required = false) String userEmail) {
		
		Member member = null;
		
		if(userId != null) { member = memberService.getMember(userId); }
		else { member = memberService.getMemberEmail(userEmail); }
		
		model.addAttribute("member", member);
		
		return "member/member";
	}
	
	@GetMapping("/delete")
	public String deleteMember(HttpServletRequest req) {

		HttpSession session = req.getSession(false);
		Member member = (Member) session.getAttribute("userStatus");
		
		if(member != null) {
			String userId = member.getUserId();
			memberService.deleteMember(userId);
			session.invalidate();
		}
		
		return "redirect:home";
	}
}
