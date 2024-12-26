<%@page import="java.util.ArrayList"%>
<%@page import="com.springproject.domain.Wish"%>
<%@page import="java.util.List"%>
<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<%
		HttpSession session = request.getSession(false);
		
		if(session != null){
			Member member = (Member)session.getAttribute("userStatus");
			
			if(member != null){
				List<Wish> list = (ArrayList<Wish>)request.getAttribute("list");
				
				if(list != null){
	%>
					<p><%= member.getUserName() %> 님이 저장하신 장소입니다!</p>
					<table>
						<tr>
							<td>장소 이름</td>
							<td>삭제</td>
						</tr>
	<%
					for(int i=0; i<list.size(); i++){
	%>
						<tr>
							<td><%= list.get(i).getPlaceName() %></td>
							<td> <button type="button" onclick="wishDel('<%= list.get(i).getPlaceId() %>', '<%= list.get(i).getUserId() %>')">삭제</button> </td>
						</tr>
	<%				
					}
	%>
					</table>
	<%
				} else {
	%>
					<p>저장된 장소가 없습니다.</p>
	<%
				}
			}
		}
	%>
</body>
<script type="text/javascript">

	function wishDel(placeID, userId){

	    $.ajax({
	        url: '/howAbout/wish/delete/'+placeID+'/'+userId,
	        method: 'POST',
	        contentType: 'application/json',
	        success: function(data) {
	        	alert('삭제되었습니다.');
	        	location.reload();
	        	
	        },
	        error: function(xhr, status, error) {
	            console.error('삭제에 실패했습니다:', error);
	        }
	    });
		
	}
	
</script>
</html>