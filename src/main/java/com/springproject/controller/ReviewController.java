package com.springproject.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.springproject.domain.Member;
import com.springproject.domain.Review;
import com.springproject.service.MemberService;
import com.springproject.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	MemberService memberService;
	
	@GetMapping("/all")
	public String reviewAllPage(@ModelAttribute Review review, Model model) {
		
		List<Review> rev_list = reviewService.getAllReview();
		model.addAttribute("rev_list", rev_list);
		
		System.out.println("전체 리뷰 페이지로 진입합니다.");
		return "reviewpage";
	}
	
	@GetMapping("/all/{userId}/oneReview")
	public String reviewOneMember(@PathVariable String userId, Model model) {
		System.out.println("해당 멤버의 리뷰를 조회합니다.");
		
		List<Review> rev_list = reviewService.getReviewById(userId);
		model.addAttribute("rev_list", rev_list);
		
		return "oneReview";
	}
	
	@PostMapping("/create")
	public String reviewCreate(@ModelAttribute Review review) {
		System.out.println("리뷰 정보 도착");
		SimpleDateFormat today = new SimpleDateFormat("yyyy/MM/dd");
		review.setReviewDate(today.format(new Date()));
		review.setMillisId(System.currentTimeMillis());
		
		String userId = review.getUserId();
		
		Member member = memberService.getMember(userId);
		
		if(member == null) {
			System.out.println("해당 회원을 찾을 수 없습니다.");
			System.out.println("예외처리 진행");
		}
		
		
		reviewService.addReview(review);
		
		System.out.println("리뷰 전체 페이지로 돌아갑니다.");
		return "redirect:all";
	}
	
	@GetMapping("/update/{millisId}")
	public String reviewUpdateForm(@PathVariable String millisId, @ModelAttribute Review review, Model model) {
		System.out.println("리뷰 수정 페이지로 진입합니다.");
		
		long millis = Long.parseLong(millisId);
		Review view = reviewService.getReviewByMillis(millis);
		model.addAttribute("view",view);
		
		return "reviewUpdateForm";
	}
	
	@PostMapping("/update/{millisId}")
	public String reviewUpdate(@PathVariable String millisId, @ModelAttribute Review review) {
		System.out.println("수정 사항이 도착하였습니다.");
		
		reviewService.updateReview(review);
		
		return "redirect:/review/all";
	}
	
	@GetMapping("/delete/{millisId}")
	public String reviewDelete(@PathVariable String millisId) {
		System.out.println("해당 리뷰를 삭제합니다.");
		
		long millis = Long.parseLong(millisId);
		
		reviewService.deleteReview(millis);
		
		return "redirect:/review/all";
	}
}
