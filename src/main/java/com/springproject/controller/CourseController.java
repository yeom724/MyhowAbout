package com.springproject.controller;

import java.util.List;

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


@Controller
@RequestMapping("/course")
public class CourseController {
	
	@Autowired
	PlaceService placeService;
	
	@ResponseBody
	@PostMapping("/myPlace")
	public boolean addmyPlace(@RequestBody String placeID, HttpServletRequest req) {
		
		HttpSession session = req.getSession(false);
		int cnt = 0;
		
		if(session != null) {
			Member member = (Member)session.getAttribute("userStatus");
			
			if(member != null) {
				
				List<Wish> cart = member.getWishList();
				Place place = placeService.getPlace(placeID);
				
				if(cart != null) {

					for(int i=0; i<cart.size(); i++) {
						if(cart.get(i).getPlaceId().equals(placeID)) {cnt++;}
					}
					
					if(cnt == 0) {
						Wish wish = new Wish();
						wish.setPlaceId(placeID);
						wish.setPlaceName(place.getPlaceName());
						wish.setUserId(member.getUserId());
						
					}
					
				} else if(cart == null || cart.isEmpty()) {
					
				}
				
			}
		}
		
		
		
		return false;
	}
}
