package com.springproject.domain;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


public class Course {
	private long course_id;
	private String course_name;
	//private String location_name;
	private List<String> location_names;
	private List<Long> location_sequence;
	private String userId;
	private LocalDateTime creation_date;
	
	public Course() {
		super();
		this.location_names = new ArrayList<>();
		this.location_sequence = new ArrayList<>();
	}
	
	public Course(long course_id, String course_name, List<String> location_names, String userId, LocalDateTime creation_date, List<Long> location_sequence) {
		super();
		this.course_id = course_id;
		this.course_name = course_name;
		this.location_names = new ArrayList<>();
		this.userId = userId;
		this.creation_date = creation_date;
	}

	public long getCourse_id() {
		return course_id;
	}

	public void setCourse_id(long course_id) {
		this.course_id = course_id;
	}

	public String getCourse_name() {
		return course_name;
	}
	public void setCourse_name(String course_name) {
		this.course_name = course_name;
	}


	public List<String> getLocation_names() {
		return location_names;
	}

	public void setLocation_names(List<String> location_names) {
		this.location_names = location_names;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public LocalDateTime getCreation_date() {
		return creation_date;
	}
	public void setCreation_date(LocalDateTime creation_date) {
		this.creation_date = creation_date;
	}

	public List<Long> getLocation_sequence() {
		return location_sequence;
	}

	public void setLocation_sequence(List<Long> location_sequence) {
		this.location_sequence = location_sequence;
	}

}
