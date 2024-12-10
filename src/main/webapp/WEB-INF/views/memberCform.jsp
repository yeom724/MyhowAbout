<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
</head>
<body>
	<form:form modelAttribute="member">
		유저 이름 : <form:input path="userName"/><br>
		유저 아이디 : <form:input path="userId"/><br>
		유저 비밀번호 : <form:input path="userPw"/><br>
		유저 전화번호 : <form:input path="userTel"/><br>
		유저 주소 : <form:input path="userAddr"/><br>
		유저 이메일 : <form:input path="userEmail"/><br>
		<input type="submit" value="전송">
	</form:form>
</body>

<script type="text/javascript">
	
</script>

</html>