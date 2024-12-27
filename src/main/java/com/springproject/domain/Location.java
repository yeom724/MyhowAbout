package com.springproject.domain;

public class Location 
{
	
	private String data_title;	//이름
	private String user_address;	//주소
	private String latitude;	//위도
	private String longitude;	//경도
	private String insttnm;	//기관명
	private String category_name1;	//ex.섬과 바다
	private String category_name2;	//ex.남해군
	private String data_content;
	private String telno;	//전화번호
	private String fileurl1;
	private String fileurl2;
	private String fileurl3;
	private String fileurl4;
	private int num;

	public String getData_title() {
		return data_title;
	}
	public void setData_title(String data_title) {
		this.data_title = data_title;
	}
	public String getUser_address() {
		return user_address;
	}
	public void setUser_address(String user_address) {
		this.user_address = user_address;
	}

	public String getInsttnm() {
		return insttnm;
	}
	public void setInsttnm(String insttnm) {
		this.insttnm = insttnm;
	}
	public String getCategory_name1() {
		return category_name1;
	}
	public void setCategory_name1(String category_name1) {
		this.category_name1 = category_name1;
	}
	public String getCategory_name2() {
		return category_name2;
	}
	public void setCategory_name2(String category_name2) {
		this.category_name2 = category_name2;
	}
	public String getData_content() {
		return data_content;
	}
	public void setData_content(String data_content) {
		this.data_content = data_content;
	}
	public String getTelno() {
		return telno;
	}
	public void setTelno(String telno) {
		this.telno = telno;
	}
	public String getFileurl1() {
		return fileurl1;
	}
	public void setFileurl1(String fileurl1) {
		this.fileurl1 = fileurl1;
	}
	public String getFileurl2() {
		return fileurl2;
	}
	public void setFileurl2(String fileurl2) {
		this.fileurl2 = fileurl2;
	}
	public String getFileurl3() {
		return fileurl3;
	}
	public void setFileurl3(String fileurl3) {
		this.fileurl3 = fileurl3;
	}
	public String getFileurl4() {
		return fileurl4;
	}
	public void setFileurl4(String fileurl4) {
		this.fileurl4 = fileurl4;
	}

	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getLatitude() {
		return latitude;
	}
	public void setLatitude(String latitude) {
		this.latitude = latitude;
	}
	public String getLongitude() {
		return longitude;
	}
	public void setLongitude(String longitude) {
		this.longitude = longitude;
	}
	
	
}
