package com.springproject.service;

import java.util.List;
import java.util.Map;

public interface CalendarService {
	List<Integer> getCalendarDates(int year, int month);
	Map<String, Object> getCalendarYearMonth(Integer year, Integer month);
}
