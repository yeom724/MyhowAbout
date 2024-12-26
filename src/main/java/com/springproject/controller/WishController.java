package com.springproject.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	private Member matchUserSession(HttpServletRequest req) {
		
		Member member = null;
		HttpSession session = req.getSession(false);
		
		if(session != null) {
			Member user = (Member)session.getAttribute("userStatus");
			if(user != null) {
				member = user;
			}
		}

		return member;
	}
	
	@ResponseBody
	@PostMapping("/myPlace")
	public Map<String, Boolean> addmyPlace(@RequestBody Map<String, String> map, HttpServletRequest req) {
		
		String placeID = map.get("placeID");
		Place place = null;
		Map<String, Boolean> data = new HashMap<String, Boolean>();
		Boolean result = false;
		
		Member member = matchUserSession(req);
		place = placeService.getPlace(placeID);
		if(place != null) { placeService.addPlace(place); }

		if(member != null) {
			String userId = member.getUserId();
			result = wishService.addWishList(userId, place);
		}

		data.put("result", result);
		return data;
	}
	
	@GetMapping("/mylist")
	public String myWishList(HttpServletRequest req, Model model) {
		
		Member member = matchUserSession(req);
		
		if(member != null) {
			String userId = member.getUserId();
			List<Wish> myList = wishService.getMyList(userId);
			model.addAttribute("list", myList);
				
		}
		
		return "wishlist/wishList";
	}
	
	@ResponseBody
	@PostMapping("/delete/{placeID}/{userId}")
	public String wishDelete(@PathVariable String placeID, @PathVariable String userId) {
		wishService.deleteWish(placeID, userId);
		return "true";
	}
	
	
	@GetMapping("/mapperMyList")
	public String wishMapList(HttpServletRequest req, Model model) {
		
		Member member = matchUserSession(req);
		if(member != null) {
			String userId = member.getUserId();
			List<Wish> myList = wishService.getMyList(userId);
			ArrayList<Place> placelist = new ArrayList<Place>();
			
			for(int i=0; i<myList.size(); i++) {
				Place place = placeService.getApiPlace(myList.get(i).getPlaceId());
				placelist.add(place);
			}
			
			model.addAttribute("list", placelist);
		}
		
		return "wishlist/mapList";
	}

}
