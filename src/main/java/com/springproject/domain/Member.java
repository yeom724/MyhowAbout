package com.springproject.domain;

import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Member {
	
	private String userName;			//유저 이름
	private String userId;				//유저 아이디
	private String userPw;				//유저 비밀번호
	private String userTel;				//유저 전화번호
	private String userAddr;			//유저 주소
	private String userDate;			//유저 가입일
	private MultipartFile userIcon;		//유저 이미지 파일
	private String iconName;
	
	
	public String getUserName() {
		return userName;
	}
	public void setUserName(String userName) {
		this.userName = userName;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public String getUserPw() {
		return userPw;
	}
	public void setUserPw(String userPw) {
		this.userPw = userPw;
	}
	public String getUserTel() {
		return userTel;
	}
	public void setUserTel(String userTel) {
		this.userTel = userTel;
	}
	public String getUserAddr() {
		return userAddr;
	}
	public void setUserAddr(String userAddr) {
		this.userAddr = userAddr;
	}
	public String getUserDate() {
		return userDate;
	}
	public void setUserDate(String userDate) {
		this.userDate = userDate;
	}
	public MultipartFile getUserIcon() {
		return userIcon;
	}
	public void setUserIcon(MultipartFile userIcon) {
		this.userIcon = userIcon;
	}
	public String getIconName() {
		return iconName;
	}
	public void setIconName(String iconName) {
		this.iconName = iconName;
	}

	
}
