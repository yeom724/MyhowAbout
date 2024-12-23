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
	<form:form method="post" modelAttribute="member" enctype="multipart/form-data">
		유저 이름 : <form:input path="userName"/><br>
		유저 아이디 : <form:input id="userId" path="userId"/> <button type="button" id="matchTheID" onclick="sendToController('userId')" >아이디 중복검사</button> <br>
		유저 비밀번호 : <form:input path="userPw"/><br>
		유저 전화번호 : <form:input path="userTel"/><br>
		유저 주소 : <form:input path="userAddr" type="text" id="locationInput" onkeyup="searchLocation()" /><br>
		<div id="results" class="results-container"></div>
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

</html>