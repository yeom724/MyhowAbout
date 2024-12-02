<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fc7be1941eb9e2a48429965c1db39c7e&libraries=services"></script>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form id="searchForm" onsubmit="return searchPlaces();">
        <input type="text" id="keyword" placeholder="검색어를 입력하세요">
        <input type="submit" value="검색">
    </form>
	<div id="map" style="width:100%;height:350px;"></div>
	<a href="/howAbout/map/length">바로가기</a>


<script>
	var infowindow = new kakao.maps.InfoWindow({zIndex:1});
	var mapContainer = document.getElementById('map');
	var mapOption = {
	    center: new kakao.maps.LatLng(37.566826, 126.9786567),
	    level: 1
	};  
	var map = new kakao.maps.Map(mapContainer, mapOption); 
	var ps = new kakao.maps.services.Places(); 
	
	function searchPlaces() {
	    var keyword = document.getElementById('keyword').value; // 입력값 가져오기
	    ps.keywordSearch(keyword, placesSearchCB); // 입력값으로 검색
	    return false; // 폼 제출 방지
	}
	
	function placesSearchCB(data, status, pagination) {
	    if (status === kakao.maps.services.Status.OK) {
	        var bounds = new kakao.maps.LatLngBounds();
	        for (var i=0; i<data.length; i++) {
	            displayMarker(data[i]);    
	            bounds.extend(new kakao.maps.LatLng(data[i].y, data[i].x));
	        }       
	        map.setBounds(bounds);
	    } 
	}
	
	function displayMarker(place) {
	    var marker = new kakao.maps.Marker({
	        map: map,
	        position: new kakao.maps.LatLng(place.y, place.x) 
	    });
	
	    kakao.maps.event.addListener(marker, 'click', function() {
	        infowindow.setContent('<div style="padding:5px;font-size:12px;">' + place.place_name + '</div>');
	        infowindow.open(map, marker);
	    });
	}
</script>
</body>
</html>