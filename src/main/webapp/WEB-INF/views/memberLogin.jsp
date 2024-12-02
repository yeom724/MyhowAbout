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
	<form action="login" method="post">
		아이디 : <input type="text" name="userId" placeholder="아이디를 입력하세요"><br>
		비밀번호 : <input type="password" name="userPw" placeholder="비밀번호를 입력하세요"><br>
		<input type="submit" value="전송">
	</form>
</body>
</html>