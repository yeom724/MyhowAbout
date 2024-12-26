<%@page import="com.springproject.domain.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style type="text/css">
	.results-container {
	    max-height: 150px; /* 최대 높이 설정 (원하는 높이로 조정 가능) */
	    width: 300px;
	    overflow-y: auto;  /* 세로 스크롤 가능 */
	    border: 1px solid #ccc; /* 경계선 추가 (선택 사항) */
	    background-color: #fff; /* 배경색 설정 (선택 사항) */
	    display: none; /* 초기에는 숨김 */
	}

	.results-container div {
	    padding: 8px; /* 각 결과의 패딩 */
	    cursor: pointer; /* 마우스 커서를 포인터로 변경 */
	}

	.results-container div:hover {
	    background-color: #f0f0f0; /* 호버 효과 */
	}
</style>
</head>
<body>
	<% 
		HttpSession session = request.getSession(false);
		Member member = null;
		
		if(session != null){
			member = (Member)session.getAttribute("userStatus");
	%>
		<p>현재 이미지</p>
		<img width="100px" height="100px" src="/howAbout/resources/userIcon/<%= member.getIconName() %>">
			<form:form method="post" modelAttribute="member" enctype="multipart/form-data">
				유저 이름 : <form:input path="userName" value="<%= member.getUserName() %>"/><br>
				유저 아이디 : <form:input path="userId" value="<%= member.getUserId() %>" /><br>
				유저 비밀번호 : <form:input path="userPw" value="<%= member.getUserPw() %>" /><br>
				유저 전화번호 : <form:input path="userTel" value="<%= member.getUserTel() %>" /><br>
				유저 주소 : <form:input path="userAddr" value="<%= member.getUserAddr() %>" type="text" id="locationInput" onkeyup="searchLocation()" /><br>
				<div id="results" class="results-container"></div>
				유저 이메일 : <form:input path="userEmail" value="<%= member.getUserEmail() %>" /><br>
				프로필 사진 : <input type="file" name="userIcon" />
				<input type="submit" value="전송">
			</form:form>
	<%
		} else {
	%>
			세션이 만료되었습니다.
	<%
		}
	%>

<script type="text/javascript">

	function searchLocation() {
	    const input = $('#locationInput').val();
	
	    if (input.length < 1) {
	        $('#results').empty();
	        $('#results').hide();
	        return;
	    }
	
	    $.ajax({
	        url: '/howAbout/user/searchLocation',
	        method: 'POST',
	        data: JSON.stringify({ query : input }),
	        contentType: 'application/json', //얘를 빼고 JSON을 보내면 Failed to load resource: the server responded with a status of 415 () 에러 발생
	        dataType: 'json',
	        success: function(data) {
	            const resultsDiv = $('#results');
	            resultsDiv.empty(); // 이전 결과 초기화
	            
	            if (data.list.length > 0) { $('#results').show(); } // 결과가 있을 때만 표시 
	            else { $('#results').hide(); } // 결과가 없으면 숨김 
	
	            $.each(data.list, function(index, location) {
	                const div = $('<div></div>').text(location.address);
	                div.addClass('result-item');
	                div.on('click', function() {
	                    $('#locationInput').val(location.address); // 선택한 주소를 input에 설정
	                    resultsDiv.hide(); // 선택 후 결과 숨김
	                });
	                resultsDiv.append(div); // 결과를 결과 영역에 추가
	            });
	        },
	        error: function(xhr, status, error) {
	            console.error('Error:', error); // 오류 로그
	        }
	    });
	}
	
</script>

</body>
</html>