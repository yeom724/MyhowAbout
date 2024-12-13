<%@page import="com.springproject.domain.Place"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${apiKey}"></script>
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
		// 이미지 지도에 표시할 마커입니다
		var marker = {
		    position: new kakao.maps.LatLng(<%= place.getLatitude()%>, <%= place.getLongitude()%>), 
		    text: "<%= place.getTitle() %>"
		};
	
		var staticMapContainer  = document.getElementById('map'), // 이미지 지도를 표시할 div
		    staticMapOption = { 
		        center: new kakao.maps.LatLng(<%= place.getLatitude()%>, <%= place.getLongitude()%>), // 이미지 지도의 중심좌표
		        level: 2, // 이미지 지도의 확대 레벨
		        marker: marker // 이미지 지도에 표시할 마커
		    };
	
		// 이미지 지도를 생성합니다
		var staticMap = new kakao.maps.StaticMap(staticMapContainer, staticMapOption);
	</script>

    
</body>
</html>