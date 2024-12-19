<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<% 
		HttpSession session = request.getSession(false);
		Member member = null;
		
		if(session != null){
			member = (Member)session.getAttribute("userStatus");
	%>
		<p>현재 이미지</p>
		<img width="100px" height="100px" src="/howAbout/resources/userIcon/<%= member.getIconName() %>">
			<form:form method="post" modelAttribute="member" enctype="multipart/form-data">
				유저 이름 : <form:input path="userName" value="<%= member.getUserName() %>"/><br>
				유저 아이디 : <form:input path="userId" value="<%= member.getUserId() %>" /><br>
				유저 비밀번호 : <form:input path="userPw" value="<%= member.getUserPw() %>" /><br>
				유저 전화번호 : <form:input path="userTel" value="<%= member.getUserTel() %>" /><br>
				유저 주소 : <form:input path="userAddr" value="<%= member.getUserAddr() %>" /><br>
				유저 이메일 : <form:input path="userEmail" value="<%= member.getUserEmail() %>" /><br>
				프로필 사진 : <input type="file" name="userIcon" />
				<input type="submit" value="전송">
			</form:form>
	<%
		} else {
	%>
			세션이 만료되었습니다.
	<%
		}
	%>
	
</body>
</html>