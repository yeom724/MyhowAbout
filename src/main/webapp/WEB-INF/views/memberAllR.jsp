<%@page import="com.springproject.domain.Member"%>
<%@page import="java.util.ArrayList"%>
<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<% ArrayList<Member> listMember = (ArrayList<Member>) request.getAttribute("list"); %>
	
	<table>
		<tr>
			<td>유저 이름 : </td>
			<td>유저 아이디 : </td>
			<td>유저 비밀번호 : </td>
			<td>유저 전화번호 : </td>
			<td>유저 주소 : </td>
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
			</tr>
		<%
			}
		%>
		
	</table>

</body>
</html>