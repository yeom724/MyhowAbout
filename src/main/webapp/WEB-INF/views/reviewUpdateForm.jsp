<%@page import="com.springproject.domain.Review"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% Review review = (Review)request.getAttribute("view"); %>
	
	<form:form modelAttribute="review" method="post">
		작성자 : <%= review.getUserId() %>
		<form:input path="reviewText" value="<%= review.getReviewText() %>"/>
		<input type="submit" value="수정">
	</form:form>
</body>
</html>