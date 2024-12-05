<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<a href="/howAbout/user/create">회원가입</a><br>
	<a href="/howAbout/user/read">회원조회</a><br>
	<a href="/howAbout/place/addPlaceForm">시설등록</a>
	<a href="/howAbout/place/allPlace/all/1">시설전체조회</a>
	<form action="/howAbout/user/month" method="get">
		<input type="month" name="mon">
		<input type="submit" value="전송">
	</form>
	<%
		HttpSession session = request.getSession(false);
		Member member = null;
		if(session != null){
			member = (Member)session.getAttribute("userStatus");
			if(member != null){
	%>
			<p>환영합니다, <%= member.getUserName() %> 님! </p>
			<a href="/howAbout/user/update">회원수정</a><br>
			<a href="/howAbout/user/delete">회원탈퇴</a><br>
			<a href="/howAbout/user/logout">로그아웃</a><br>
			<a href="/howAbout/review/all/<%= member.getUserId() %>/oneReview">내 리뷰 조회</a>
	<%
			}
			
		} else if(session == null){
	%>
			<a href="/howAbout/user/login">로그인</a>
	<%
		}
	%>
	
	<a href="/howAbout/review/all">리뷰 전체 조회</a>

</body>
</html>