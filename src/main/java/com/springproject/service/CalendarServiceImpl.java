package com.springproject.service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

@Service
public class CalendarServiceImpl implements CalendarService{
	
	public List<Integer> getCalendarDates(int year, int month){
		System.out.println("getCalendarDates 입장");
		List<Integer> dates = new ArrayList<>(); //달력에 출력할 날짜 담는 List
		
		LocalDate firstDayOfMonth = LocalDate.of(year, month, 1); //해당 달의 첫 날짜
		System.out.println("firstDayOfMonth : "+firstDayOfMonth);
		
		int firstDayOfWeek= firstDayOfMonth.getDayOfWeek().getValue(); //요일(int)만 추출(월:1 일:7)
		System.out.println("firstDayOfWeek : "+firstDayOfWeek);
		LocalDate startDate = firstDayOfMonth.minusDays(firstDayOfWeek % 7);
		System.out.println("startDate : "+startDate);
		for(int i = 0; i<42; i++) {
			LocalDate currentDate = startDate.plusDays(i);
			dates.add(currentDate.getDayOfMonth()); //currentDate의 일 부분만 추출해서 추가
		}
		System.out.println("currentDate 추가 완료 ");
		return dates;
	}
	
	public Map<String, Object> getCalendarYearMonth(Integer year, Integer month) {
		System.out.println("getCalendarYearMonth 입장");
		if(year==null||month==null) {
			System.out.println("year/month 값 없는 경우 if문 입장");
			LocalDate nowDate = LocalDate.now();
			year = nowDate.getYear();
			month = nowDate.getMonthValue();
		}
		
		int preYear;
		int preMonth;
		int nextYear;
		int nextMonth;
		
		
		
		if(month == 1) {
			preYear = year-1;	
			preMonth = 12;
		} else {
			preYear = year;
			preMonth = month-1;
		}
		
		if(month == 12) {
			nextYear = year+1;
			nextMonth = 1;
		} else {
			nextYear = year;
			nextMonth = month+1;
		}
		
//		int preYear = year;
//		int preMonth = month-1;
//		int nextYear = year;
//		int nextMonth = month+1;
//		
//		if(month == 1) {
//			preYear = year-1;
//			preMonth = 12;
//		}
//		
//		if(month == 12) {
//			nextYear = year;
//			nextMonth = month+1;
//		}
		
		System.out.println("setting된 value들 - preYear : "+preYear+" preMonth :"+preMonth+" nextYear:"+nextYear+" nextMonth:"+nextMonth);
		Map<String, Object> response = new HashMap<>();
		response.put("year", year);
		response.put("month", month);
		response.put("preYear",preYear);
		response.put("preMonth",preMonth);
		response.put("nextYear",nextYear);
		response.put("nextMonth",nextMonth);
		
		return response;
	}
}
