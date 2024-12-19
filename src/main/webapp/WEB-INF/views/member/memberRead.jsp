<%@page import="com.springproject.domain.Member"%>
<%@page import="java.util.ArrayList"%>
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
	<% ArrayList<Member> listMember = (ArrayList<Member>) request.getAttribute("list"); %>
	<p>전체 회원 목록</p>
	<table>
		<tr>
			<td>이름 </td>
			<td>아이디 </td>
			<td>비밀번호 </td>
			<td>전화번호 </td>
			<td>주소 </td>
			<td>이메일 </td>
		</tr>
		<% for(int i=0; i<listMember.size(); i++){
			Member mem = listMember.get(i);
		%>
			<tr>
				<td> <%= mem.getUserName() %> </td>
				<td> <%= mem.getUserId() %> </td>
				<td> <%= mem.getUserPw() %> </td>
				<td> <%= mem.getUserTel() %> </td>
				<td> <%= mem.getUserAddr() %> </td>
				<td> <%= mem.getUserEmail() %> </td>
			</tr>
		<%
			}
		%>
	</table>
	
	<p>아이디로 조회하기</p>
	<form method="post" action="/howAbout/user/readOne">
		<input type="text" name="userId" >
		<input type="submit" value="조회">
	</form>
	
	<p>이메일로 조회하기</p>
	<form method="post" action="/howAbout/user/readOne">
		<input type="text" name="userEmail" >
		<input type="submit" value="조회">
	</form>
	
	<p> <a href="/howAbout/user/home">Home</a> </p>
</body>
</html>