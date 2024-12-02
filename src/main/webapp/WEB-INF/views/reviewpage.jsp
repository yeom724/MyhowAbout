<%@page import="com.springproject.domain.Review"%>
<%@page import="java.util.List"%>
<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>리뷰 페이지</title>
</head>
<body>
	<% 
		HttpSession session = request.getSession(false); 
		Member member = null;
		List<Review> rev_list = (List<Review>)request.getAttribute("rev_list");
	
		if(rev_list != null){
			for(int i=0; i<rev_list.size(); i++){
				Review review = rev_list.get(i);
	%>
			<div>
				<p> <%= review.getUserId() %> </p>
				<p> <%= review.getReviewText() %> </p>
				<p> <%= review.getReviewDate() %> </p>
				<form action="./all/<%=review.getUserId()%>/oneReview" method="get">
					<input type="submit" value="작성자 리뷰 전체 조회">
				</form>
	<%
				if(session != null){ member = (Member)session.getAttribute("userStatus");
					if(member != null){
						if(member.getUserId().equals(review.getUserId())){
	%>
							<a href="/howAbout/review/update/<%= review.getMillisId() %>">수정하기</a>
							<a href="/howAbout/review/delete/<%= review.getMillisId() %>">삭제하기</a>
	<%
						}
					}
				}
	%>
			</div>
	<%
			}
		} else {
	%>
			<p>작성된 리뷰가 없습니다.</p>
	<%
		}
	%>

	<% 
		
		if(session != null){
			
			member = (Member)session.getAttribute("userStatus");
			
			if(member != null){
				
	%>
			<form:form modelAttribute="review" action="./create" method="post">
				작성자 : <%= member.getUserId() %>
				<form:input value="<%= member.getUserId() %>" path="userId" type="hidden"/><br>
				<form:input path="reviewText"/>
				<input type="submit" value="작성">
			</form:form>

	<%
			} else {
	%>
					<a href="/howAbout/user/logout">임시 로그아웃</a>
	<%
			}

		} else {
			
	%>
		<p>---리뷰 작성은 로그인 후 가능합니다---</p>
		<a href="/howAbout/user/login">로그인</a>
	<%
		}
	%>

</body>
</html>