package com.springproject.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
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

import com.springproject.domain.Member;
import com.springproject.domain.Place;
import com.springproject.domain.Review;
import com.springproject.service.MemberService;
import com.springproject.service.PlaceService;
import com.springproject.service.ReviewService;

@Controller
@RequestMapping("/review")
public class ReviewController {
	
	@Autowired
	ReviewService reviewService;
	
	@Autowired
	MemberService memberService;
	
	@Autowired
	PlaceService placeService;
	
	@ResponseBody
	@GetMapping("/sessionInfo")
	public HashMap<String, String> sessionMember(HttpServletRequest req){
		
		HashMap<String, String> result = new HashMap<String, String>();
		HttpSession session = req.getSession(false);
		
		if(session != null) {
			Member member = (Member)session.getAttribute("userStatus");
			if(member != null) {
				result.put("userId", member.getUserId());
			} else { result.put("userId", "-----"); }
		} else { result.put("userId", "-----"); }

		return result;
	}
	
	@ResponseBody
	@GetMapping("/all")
	public List<Review> reviewAllPage(@RequestParam String url) {
		
		String prefix = "placeID/";
		int index = url.indexOf(prefix);
		String placeID = url.substring(index + prefix.length());
		
		List<Review> reviews = reviewService.getPlaceAllReview(placeID);

		return reviews;
	}
	
	@ResponseBody
	@PostMapping("/addReview")
	public HashMap<String, Object> reviewCreate(@RequestBody HashMap<String, Object> data, HttpServletRequest req) {
		
		HttpSession session = req.getSession(false);
		Member member = (Member)session.getAttribute("userStatus");
		Review review = new Review();

		SimpleDateFormat today = new SimpleDateFormat("yyyy/MM/dd");
		review.setReviewDate(today.format(new Date()));
		review.setMillisId(System.currentTimeMillis());
		review.setUserId(member.getUserId());
		review.setIconName(member.getIconName());
		review.setPlaceID((String)data.get("placeID"));
		review.setReviewText((String)data.get("reviewText"));
		
		reviewService.addReview(review);
		
		Place place = placeService.getPlace((String)data.get("placeID"));
		if(place != null) { placeService.addPlace(place); }

		return null;
	}
	
	@GetMapping("/{userId}/selectAll")
	public String reviewOneMember(@PathVariable String userId, Model model) {

		List<Review> rev_list = reviewService.getReviewById(userId);
		model.addAttribute("rev_list", rev_list);
		
		return "review/oneReview";
	}
	
	@ResponseBody
	@PostMapping("/update/{millisId}")
	public String reviewUpdate(@RequestBody Review review, @PathVariable String millisId) {

		String reviewText = review.getReviewText();
		
		reviewService.updateReview(millisId, reviewText);
		return null;
	}
	
	@ResponseBody
	@PostMapping("/delete/{millisId}")
	public String reviewDelete(@PathVariable String millisId) {
		
		long millis = Long.parseLong(millisId);
		reviewService.deleteReview(millis);
		
		return null;
	}
}
