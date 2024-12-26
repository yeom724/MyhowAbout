package com.springproject.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.springproject.domain.Member;
import com.springproject.domain.Place;
import com.springproject.domain.Wish;
import com.springproject.service.PlaceService;
import com.springproject.service.WishService;


@Controller
@RequestMapping("/wish")
public class WishController {
	
	@Autowired
	PlaceService placeService;
	
	@Autowired
	WishService wishService;
	
	@ResponseBody
	@PostMapping("/myPlace")
	public Map<String, Boolean> addmyPlace(@RequestBody Map<String, String> map, HttpServletRequest req) {
		
		HttpSession session = req.getSession(false);
		String placeID = map.get("placeID");
		Place place = null;
		Map<String, Boolean> data = new HashMap<String, Boolean>();
		Boolean result = false;
		
		place = placeService.getPlace(placeID);
		if(place != null) { placeService.addPlace(place); }
		
		if(session != null) {
			Member member = (Member)session.getAttribute("userStatus");
			
			if(member != null) {
				 String userId = member.getUserId();
				 result = wishService.addWishList(userId, place);
			}
		}
		
		data.put("result", result);
		
		return data;
	}

}
