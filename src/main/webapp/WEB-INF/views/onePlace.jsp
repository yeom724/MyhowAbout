<%@page import="com.springproject.domain.Place"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey }"></script>
<head>
<meta charset="UTF-8">
	<%
		Place place = (Place)request.getAttribute("place");
	%>
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

	#map {
		width: 800px;
		height: 400px;
	}
    </style>
</head>
<body>


	
	<h1><%= place.getTitle() %></h1>
	<p><%= place.getJuso() %></p>
	<p><%= place.getCategory() %></p>
    <div id="map"></div>
	
	<script type="text/javascript">
		$(document).ready(function() {
	        var latitude = <%= place.getLatitude() %>;
	        var longitude = <%= place.getLongitude() %>;
	        var title = encodeURIComponent("<%= place.getTitle() %>"); // 제목 인코딩
	
	        // AJAX 요청
	        $.ajax({
	            url: '/howAbout/place/api/map/static',
	            type: 'GET',
	            data: {
	                latitude: latitude,
	                longitude: longitude,
	                title: title
	            },
	            success: function(data) {
	                // 받은 이미지를 img 태그의 src로 설정
	                $('#map').attr('src', URL.createObjectURL(data));
	            },
	            error: function(jqXHR, textStatus, errorThrown) {
	                console.error("Error fetching the static map:", textStatus, errorThrown);
	            }
	        });
	    });
	</script>

    
</body>
</html>