<%@page import="com.springproject.domain.Place"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
		List<Place> list = (List<Place>)request.getAttribute("place_list");
		String category = (String)request.getAttribute("category");
		String nowPage = (String)request.getAttribute("pageNum");
		int Count = (int)request.getAttribute("Count");
		int allPage = (int) Math.ceil((double) Count / 50);
		
	%>
		<table>
			<tr>
				<th>도로명 주소</th>
				<th>지번 주소</th>
				<th>업종</th>
				<th>상호명</th>
				<th>분류</th>
			</tr>
	<%
		for(int i=0; i<list.size(); i++){
			Place place = list.get(i);
	%>
			<tr>
				<td> <%=place.getJuso() %> </td>
				<td> <%=place.getJibun() %> </td>
				<td> <%=place.getCategory() %> </td>
				<td> <%=place.getTitle() %> </td>
				<td> <%=place.getFoodCategory() %> </td>
			</tr>
	<%
		}
	%>	
		</table>
	<%
		for(int i=1; i<=allPage; i++){
	%>
			<a href="/howAbout/place/allPlace/<%=category%>/<%=i%>"> [ <%= i %> 페이지 ]</a>
	<%
		}
	%>
</body>
</html>