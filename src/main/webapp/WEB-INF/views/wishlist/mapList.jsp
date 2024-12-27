<%@page import="com.springproject.domain.Place"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries&libraries=services"></script>
	<style>
        body {
            display: flex;
        }
        #list {
            width: 30%;
            padding: 20px;
            border-right: 1px solid #ccc;
        }
        #map {
            width: 50%;
            height: 500px;
        }
        .location-item {
            cursor: pointer;
            margin: 5px 0;
        }
    </style>
</head>
<body>
	<%
		ArrayList<Place> list = (ArrayList<Place>)request.getAttribute("list");
		if(list != null){	
	%>
		<div id="list">
        	<h3>가고 싶은 장소 목록</h3>
	<%
			for(int i=0; i<list.size(); i++){
				Place place = list.get(i);
	%>
			<p class="location-item" data-lat="<%=place.getLatitude() %>" data-lng="<%=place.getLongitude()%>"> <%= place.getPlaceName() %> </p>	
	<%
			}
	%>
    	</div>
    	<div id="map"></div>
	<%
		}
	%>
	<hr>
	
	
</body>

	<script>
		$(document).ready(function() {
	        const mapContainer = $('#map')[0];
	        const mapOption = {
	            center: new kakao.maps.LatLng(35.2345, 128.6936),
	            level: 5
	        };
	        const map = new kakao.maps.Map(mapContainer, mapOption);
	
	        // 마커 배열
	        const markers = [];
	
	        // 목록 아이템 클릭 이벤트
	        $('.location-item').on('click', function() {
	            const lat = parseFloat($(this).data('lat'));
	            const lng = parseFloat($(this).data('lng'));
	
	            // 지도 중심을 선택한 위치로 이동
	            map.setCenter(new kakao.maps.LatLng(lat, lng));
	
	            // 마커 생성 및 추가
	            const markerPosition = new kakao.maps.LatLng(lat, lng);
	            const marker = new kakao.maps.Marker({
	                position: markerPosition
	            });
	            marker.setMap(map);
	            markers.push(marker);
	        });
	    });
	</script>

</html>