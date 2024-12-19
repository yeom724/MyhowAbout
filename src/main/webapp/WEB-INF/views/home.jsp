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
<%
    Member user = (Member)request.getAttribute("newUser");
    if(user != null){
        if(user.isEnabled()){
%>
            <p>이메일 인증이 완료되었습니다</p>
            <p>환영합니다, <%= user.getUserId() %> 님! </p>
            <a href="/howAbout/user/home">홈페이지로 돌아가기</a>
<% 
        } else { 
%>
            <%= user.getUserEmail() %> 로 전송된 링크를 따라 회원가입 인증을 완료해주세요.<br>
            <a href="/howAbout/user/logout">홈페이지로 돌아가기</a>
<%
        }
    } else {
    	
        HttpSession session = request.getSession(false);
        Member member = null;
        if(session != null){
            member = (Member)session.getAttribute("userStatus");
            if(member != null){
                if(member.isEnabled()){
%>
                    <p>환영합니다, <%= member.getUserName() %> 님! </p>
                    <a href="/howAbout/user/update/<%= member.getUserId() %>">회원수정</a><br>
                    <a href="/howAbout/user/delete">회원탈퇴</a><br>
                    <a href="/howAbout/user/logout">로그아웃</a><br>
                    <hr>
                    <a href="/howAbout/place/all">시설조회</a><br>
                    <a href="/howAbout/place/placeAdd">시설등록</a><br>
                    <hr>
                    <a href="/howAbout/review/<%= member.getUserId() %>/selectAll">내 리뷰 조회</a><br>
<%
                } else { 
%>
                    <p>이메일 인증을 진행해주세요</p>
<%
                }
            } 
        } 
        // session이 null일 때 처리
        if(session == null){
%>
			<a href="/howAbout/user/joinMember">회원가입</a><br>
            <a href="/howAbout/user/login">로그인</a><br>
            <a href="/howAbout/user/kakao/login">카카오로 로그인하기</a><br>
            <hr>
<%
        }
    }
%>
	<a href="/howAbout/user/readAll">회원 전체 조회</a>
	<hr>
	<footer> <a href="/howAbout/user/logout">강제 로그아웃</a> </footer>
</body>
</html>