<%@page import="com.springproject.domain.Review"%>
<%@page import="java.util.List"%>
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
	<% List<Review> rev = (List<Review>)request.getAttribute("rev_list");
		
		if(rev != null){
			for(int i=0; i<rev.size(); i++){
				Review review = rev.get(i);
	%>
			<div>
				<p> <%= review.getUserId() %> </p>
				<p> <%= review.getReviewText() %> </p>
				<p> <%= review.getReviewDate() %> </p>
				<p><a href="/howAbout/place/newGetOne/placeID/<%= review.getPlaceID() %>"> 리뷰 살펴보기 </a>
			</div>
	<%
			}

		} else {
			
	%>
			<p>해당 유저의 리뷰가 없습니다.</p>
	<%
		}
	
	%>
</body>
</html>