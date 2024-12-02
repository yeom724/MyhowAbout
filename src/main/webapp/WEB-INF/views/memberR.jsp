<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>멤버조회</title>
</head>
<body>
	<form action="./oneUser" method="post">
		<input name="userId" type="text" placeholder="찾으실 멤버의 아이디를 입력" >
		<input type="submit" value="전송">
	</form>
	
	<a href="./allUser">전체멤버 조회</a>
</body>
</html>