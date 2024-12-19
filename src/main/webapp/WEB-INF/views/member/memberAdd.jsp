<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
	<form:form method="post" modelAttribute="member" enctype="multipart/form-data">
		유저 이름 : <form:input path="userName"/><br>
		유저 아이디 : <form:input id="userId" path="userId"/> <button type="button" id="matchTheID" onclick="sendToController('userId')" >아이디 중복검사</button> <br>
		유저 비밀번호 : <form:input path="userPw"/><br>
		유저 전화번호 : <form:input path="userTel"/><br>
		유저 주소 : <form:input path="userAddr"/><br>
		유저 이메일 : <form:input id="userEmail" path="userEmail"/> <button type="button" id="matchTheID" onclick="sendToController('userEmail')" >이메일 중복검사</button> <br>
		프로필 사진 : <input type="file" name="userIcon" />
		<input type="submit" value="전송">
	</form:form>
	
	<p> <a href="/howAbout/user/home">Home</a> </p>
</body>

<script type="text/javascript">
	
	function sendToController(placeData) {
		
		let dataToSend = {};
		
	    if (placeData === 'userId') {
	    	dataToSend.userId = document.querySelector("#userId").value;
	    } else if (placeData === 'userEmail') {
	    	dataToSend.userEmail = document.querySelector("#userEmail").value;
	    }
			
		$.ajax({
			url: '/howAbout/user/matchUser',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(dataToSend),
			success: function(response) {
				if(response.email){
					if(response.status){
						alert('사용 가능한 이메일 입니다.'); 
					} else {
						alert('중복된 이메일이 존재합니다. 다른 이메일을 사용해주세요.');
						document.querySelector("#userEmail").value = ""
					}
				}
				
				if(response.userId){
					if(response.status){
						alert('사용 가능한 아이디 입니다.'); 
					} else {
						alert('중복된 아이디가 존재합니다. 다른 아이디를 사용해주세요.');
						document.querySelector("#userId").value = ""
					}
				}	
			},
			error: function(xhr, status, error) {
				console.error('AJAX 오류:', error);
			}
		});
	}
	
</script>

</html>