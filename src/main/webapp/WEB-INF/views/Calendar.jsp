<%@ page contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Calendar</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>
body {
        font-family: Arial, sans-serif;
        background-color: #f9f9f9;
        margin: 0;
        padding: 20px;
    }

    div {
        margin: 10px 0;
    }

    .calendar {
        display: grid;
        grid-template-columns: repeat(7, 1fr); /* 7개의 열 */
        gap: 10px; /* 열 사이의 간격 */
        padding: 10px;
        background-color: #fff;
        border: 1px solid #ddd;
        border-radius: 5px;
    }

    .header {
        background-color: #007bff; /* 헤더 색상 */
        color: white;
        padding: 10px;
        text-align: center;
        font-weight: bold;
    }

    .dates {
        padding: 15px;
        text-align: center;
        border: 1px solid #ddd; /* 날짜 셀 경계선 */
        border-radius: 5px;
        background-color: #f0f0f0; /* 날짜 배경 색상 */
        transition: background-color 0.3s; /* 호버 효과 */
    }

    .dates:hover {
        background-color: #e0e0e0; /* 호버 시 색상 변화 */
    }

    button {
        padding: 10px 15px;
        font-size: 16px;
        background-color: #007bff; /* 버튼 색상 */
        color: white;
        border: none;
        border-radius: 5px;
        cursor: pointer;
        transition: background-color 0.3s; /* 호버 효과 */
    }

    button:hover {
        background-color: #0056b3; /* 버튼 호버 시 색상 변화 */
    }

    .calendar-navigation {
        display: flex;
        justify-content: space-between; /* 이전/다음 버튼 사이의 공간 조정 */
        align-items: center;
    }
</style>
</head>
<body>
	<div>
		<div><a href="${pageContext.request.contextPath}/calendar?year=${preYear}&month=${preMonth}"><button>이전 달</button></a></div>
		<div id="monthDiv" > <span id="spanYear">${year}</span>년 <span id="spanMonth">${month}</span>월</div>
		<div><a href="${pageContext.request.contextPath}/calendar?year=${nextYear}&month=${nextMonth}"><button>다음 달</button></a></div>
	</div>
	<div class="calendar">
		<div class="header">일</div>
		<div class="header">월</div>
		<div class="header">화</div>
		<div class="header">수</div>
		<div class="header">목</div>
		<div class="header">금</div>
		<div class="header">토</div>
			<c:forEach var="i" begin="0" end="41">
				<div class="dates">${dates[i]}</div>
			</c:forEach>
	</div>
</body>
<script type="text/javascript">

$(document).ready(function() {
	
    $.ajax({
        url: '/howAbout/weather/callThree',
        type: 'GET',
        contentType: 'application/json',
        success: function(response) {
        	
        	for (const key in response) {
                if (response.hasOwnProperty(key)) {
                    const list = response[key];
                    var fcstDate = list[0].fcstDate;
					var year = fcstDate.substring(0, 4);	//년
				    var month = fcstDate.substring(4, 6);	//월
				    var day = fcstDate.substring(6, 8);		//일
				    
				    if($('#spanYear').text() === year){
				    	if($('#spanMonth').text() === month){
				    		$('.dates').each(function() {
				    		    const dateText = $(this).text();

				    		    if (dateText === day) {
				    		    	const temp = $('<p></p>');
				    		    	const spanTMN = $('<span></span>').text("최저"+Math.floor(list[0].fcstValue));
				    		    	const spanTMX = $('<span></span>').text("최고"+Math.floor(list[1].fcstValue));
				    		    	temp.append(spanTMN);
				    		    	temp.append(spanTMX);
				    		    	$(this).append(temp); 
				    		    }
				    		}); //엣헹
				    	
				    	}
                	}
            	}
        	}
        	

        },
        error: function(xhr, status, error) {
            console.error('에러', error);
        }
    });
	
});
</script>
</html>