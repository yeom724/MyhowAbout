<%@page import="com.springproject.domain.Member"%>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% 
		Member member = (Member)request.getAttribute("member");
		if(member != null){
	%>
		유저 이름 : <%= member.getUserName() %> <br>
		유저 아이디 : <%= member.getUserId() %> <br>
		유저 비밀번호 : <%= member.getUserPw() %> <br>
		유저 전화번호 : <%= member.getUserTel() %> <br>
		유저 주소 : <%= member.getUserAddr() %> <br>
	<%
		} else {
	%>
		<p>등록된 회원 정보가 없습니다.</p>
	<%
		}
	%>
	
	
	
	<p> <a href="/howAbout/user/home">Home</a> </p>
</body>
</html>