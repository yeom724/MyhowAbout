package com.springproject.controller;


import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.springproject.service.CalendarServiceImpl;

@Controller
public class CalendarController {
	@Autowired
	private CalendarServiceImpl calendarService;
	
	@GetMapping("/calendar")
	public String getCalendar(@RequestParam(required = false) Integer year,
							  @RequestParam(required = false) Integer month,
							  Model model) {
		Map<String, Object> response = calendarService.getCalendarYearMonth(year, month);
		year = (Integer) response.get("year");
		month = (Integer) response.get("month");
		System.out.println("getYearMonth 갔다온 year :"+year);
		System.out.println("getYearMonth 갔다온 month :"+month);
		List<Integer> dates = calendarService.getCalendarDates(year, month);
		model.addAttribute("year",year);
		model.addAttribute("month",month);
		model.addAttribute("preYear",response.get("preYear"));
		model.addAttribute("preMonth",response.get("preMonth"));
		model.addAttribute("nextYear",response.get("nextYear"));
		model.addAttribute("nextMonth",response.get("nextMonth"));
		model.addAttribute("dates",dates);
		return "Calendar";
	}
}
