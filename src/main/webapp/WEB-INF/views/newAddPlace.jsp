<%@page import="com.springproject.domain.Restaurant"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries&libraries=services"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<p>관리자 시설 등록 페이지</p>
	<form:form id="placeForm" modelAttribute="restaurant" method="post">
		주소 : <form:input id="address" path="addressName"/> <br>
		도로명주소 : <form:input readonly="readonly" id="roadAddress" path="roadAddress" /> <br>
		상호명 : <form:input id="placeName" path="placeName"/> <br>
		대분류 : <form:input readonly="readonly"  id="category" path="category"/> <br>
		세분류 : <form:input readonly="readonly"  id="categoryAll" path="categoryAll"/> <br>
		전화번호 : <form:input readonly="readonly"  id="phone" path="phone"/> <br>
		정보페이지 : <form:input readonly="readonly"  id="placeUrl" path="placeUrl"/> <br>
		시설ID : <form:input readonly="readonly"  id="placeID" path="placeID"/> <br>
		경도 : <form:input readonly="readonly"  id="longitude" path="longitude"/> <br>
		위도 : <form:input readonly="readonly"  id="latitude" path="latitude"/> <br>
		<button type="button" id="placeSerch" >정보조회</button> <br>
		<button type="button" id="savePlace">저장</button>
	</form:form>
	
	<div id="map" style="width: 100%; height: 400px;"></div>
	<div id="result"></div> <!-- 검색 결과를 표시할 요소 -->

<script type="text/javascript">

		
		document.addEventListener('DOMContentLoaded', function() {
            document.getElementById('placeSerch').addEventListener('click', function() {
                var address = document.getElementById('address').value;
                var restaurantName = document.getElementById('placeName').value;
                searchRestaurantsByAddress(address, restaurantName); // 검색 함수 호출
            });
        });
        


        function searchRestaurantsByAddress(address, restaurantName) {
            var ps = new kakao.maps.services.Places();

            // 주소로 장소 검색
            ps.keywordSearch(address, function(data, status) {
                if (status === kakao.maps.services.Status.OK) {
                    // 첫 번째 검색 결과에서 좌표를 가져옵니다.
                    var place = data[0];
                    var coords = new kakao.maps.LatLng(place.y, place.x);

                    // 상호명으로 음식점 검색
                    ps.keywordSearch(restaurantName, function(restaurants, status) {
                        if (status === kakao.maps.services.Status.OK) {
                            console.log(restaurants); // 검색된 음식점 목록 출력

                            // 결과를 표시할 DOM 요소
                            var resultContainer = document.getElementById('result');
                            resultContainer.innerHTML = ''; // 이전 결과 초기화

                            // 음식점 목록을 DOM에 추가
                            restaurants.forEach(function(restaurant) {
                                if (restaurant.place_name.includes(restaurantName)) {
                                    var restaurantCoords = new kakao.maps.LatLng(restaurant.y, restaurant.x);
                                    var distance = getDistance(coords, restaurantCoords);

                                    // 3000m 이내의 음식점만 추가
                                    if (distance <= 3000) {
                                    	
                                    	var restaurantItem = document.createElement('p');

                                        // 주소를 클릭했을 때 입력 필드에 자동으로 채우기
                                        var link = document.createElement('a');
                                        link.href = "#"; // 기본 링크 방지
                                        link.textContent = restaurant.place_name + ' : ' + restaurant.address_name;

                                        // 클릭 이벤트 추가
                                        link.addEventListener('click', function(event) {
                                            event.preventDefault(); // 기본 링크 동작 방지
                                            document.getElementById('address').value = restaurant.address_name; // 주소를 입력 필드에 채우기
                                            document.getElementById('placeName').value = restaurant.place_name;
                                            document.getElementById('category').value = restaurant.address_name;
                                            document.getElementById('categoryAll').value = restaurant.category_name;
                                            document.getElementById('phone').value = restaurant.phone;
                                            searchRestaurantsByAddress(restaurant.address_name, restaurant.place_name); // 자동 검색 실행
                                        });

                                        restaurantItem.appendChild(link); // 링크를 p 태그에 추가
                                        resultContainer.appendChild(restaurantItem); // p 태그를 결과 컨테이너에 추가
                                        
                                    }
                                }
                            });

                            if (resultContainer.innerHTML === '') {
                                resultContainer.innerHTML = '해당 상호명과 일치하는 음식점을 찾을 수 없습니다.';
                            }
                        } else {
                            alert('음식점 정보를 가져오는 데 실패했습니다. 상태: ' + status);
                        }
                    }, { location: coords }); // 좌표를 지정하여 범위 검색
                } else {
                    alert('장소 정보를 가져오는 데 실패했습니다. 상태: ' + status);
                }
            });
        }

        // 두 좌표 간의 거리를 계산하는 함수 (단위: 미터)
        function getDistance(coord1, coord2) {
            var lat1 = coord1.getLat();
            var lng1 = coord1.getLng();
            var lat2 = coord2.getLat();
            var lng2 = coord2.getLng();

            var R = 6371e3; // 지구 반지름 (미터)
            var φ1 = lat1 * Math.PI / 180; // 라디안으로 변환
            var φ2 = lat2 * Math.PI / 180; // 라디안으로 변환
            var Δφ = (lat2 - lat1) * Math.PI / 180; // 라디안으로 변환
            var Δλ = (lng2 - lng1) * Math.PI / 180; // 라디안으로 변환

            var a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
                    Math.cos(φ1) * Math.cos(φ2) *
                    Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
            var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));

            return R * c; // 두 지점 간의 거리 (미터)
        }

			function serch() {
				console.log("주소 검색 시동중...");
				var addr = document.querySelector("#address").value;
				var name = document.querySelector("#placeName").value;
				
				$.ajax({
					url : "/howAbout/place/addAPIserch",
					type : "POST",
					data : JSON.stringify({address : addr}, {placeName : name}),
					contentType: 'application/json',
					success : function(data){
						document.querySelector("#jibun").value = data.jibun;
						document.querySelector("#latitude").value = data.latitude;
						document.querySelector("#longitude").value = data.longitude;
				},
					error : function(errorThrown){ alert("해당하는 시설이 없습니다."); }
				})
				
			}
			
			function saveP() {
				
				console.log("장소 검색중...");
				var juso = document.querySelector("#juso").value;
				var jibun = document.querySelector("#jibun").value;
				var title = document.querySelector("#title").value;
				var latitude = document.querySelector("#latitude").value;
				var longitude = document.querySelector("#longitude").value;
				
				$.ajax({
					url : "/howAbout/place/placeAPIserch",
					type : "POST",
					data : JSON.stringify({"juso" : juso, "jibun" : jibun, "title" : title, "latitude" : latitude, "longitude" : longitude, "update" : "no"}),
					contentType: 'application/json',
					success : function(data){
						
						if(data.status){
							if(confirm("등록하시겠습니까?")==true){
								document.getElementById('placeForm').submit();
							} else { return false; }
						} else {
							alert("이미 등록된 주소지 입니다.");
						}
				},
					error : function(errorThrown){ alert("처리에 실패했습니다.."); }
				})
				
			}	

</script>
</body>
</html>