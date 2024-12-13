<%@page import="com.springproject.domain.Restaurant"%>
<%@ page import="com.springproject.domain.Place"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>

<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries&libraries=services"></script>
<head>
<meta charset="UTF-8">
	<%
		Restaurant place = (Restaurant)request.getAttribute("place");
	%>
<title>Insert title here</title>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<style>

	#map {
		width: 800px;
		height: 400px;
	}
	
	body {
    font-family: Arial, sans-serif;
}

	.modal {
	    display: none; /* 기본적으로 숨김 */
	    position: fixed; 
	    z-index: 1; 
	    left: 0;
	    top: 0;
	    width: 100%; 
	    height: 100%; 
	    overflow: auto; 
	    background-color: rgb(0,0,0); 
	    background-color: rgba(0,0,0,0.4); 
	}
	
	.modal-content {
	    position: relative;
	    margin: 5% auto; 
	    padding: 20px;
	    border: 1px solid #888;
	    width: 60%; 
	    background-color: white;
	}
	
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	iframe {
	    width: 100%;
	    height: 700px; /* 원하는 높이로 설정 */
	}
	
</style>
</head>
<body>

	<h1><%= place.getPlaceName() %></h1>
	<p><%= place.getAddressName() %></p>
	<p><%= place.getCategoryAll() %></p>
    <div id="map"></div>
    <a href="#" id="openModal">카카오 정보 페이지 보기</a>

    <!-- 모달 구조 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <iframe id="modalIframe" src="" frameborder="0"></iframe>
        </div>
    </div>
	
<script type="text/javascript">

	document.addEventListener("DOMContentLoaded", function() {
	    var address = '<%= place.getAddressName() %>'; 
	    var restaurantName = '<%= place.getPlaceName() %>';
	    var targetId = '<%= place.getPlaceID() %>';
	    searchRestaurantsByAddress(address, restaurantName, targetId);
	    searchRestaurant(address, restaurantName);
	});
	
	function searchRestaurantsByAddress(address, restaurantName, targetId) {
        var ps = new kakao.maps.services.Places();

        // 주소로 장소 검색
        ps.keywordSearch(address, function(data, status) {
            if (status === kakao.maps.services.Status.OK) {
                var place = data[0]; // 첫 번째 검색 결과에서 좌표를 가져옵니다.
                var coords = new kakao.maps.LatLng(place.y, place.x);

                // 지도 초기화
                var mapContainer = document.getElementById('map');
                var mapOptions = {
                    center: coords,
                    level: 3
                };
                var map = new kakao.maps.Map(mapContainer, mapOptions);

                // 상호명으로 음식점 검색
                ps.keywordSearch(restaurantName, function(restaurants, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        console.log(restaurants); // 검색된 음식점 목록 출력

                        var foundRestaurant = null;

                        // 음식점 목록에서 ID 비교
                        restaurants.forEach(function(restaurant) {
                            if (restaurant.place_name.includes(restaurantName) && restaurant.id === targetId) {
                                foundRestaurant = restaurant;
                            }
                        });

                        // 상호명과 ID가 일치하는 음식점이 있는 경우
                        if (foundRestaurant) {
                            var restaurantCoords = new kakao.maps.LatLng(foundRestaurant.y, foundRestaurant.x);
                            searchRestaurantByName(targetId);

                            // 마커 표시
                            var marker = new kakao.maps.Marker({
                                position: restaurantCoords,
                                map: map
                            });

                            // 인포윈도우 표시
                            var infowindow = new kakao.maps.InfoWindow({
                                content: '<div style="padding:5px;">' + foundRestaurant.place_name + '</div>'
                            });
                            infowindow.open(map, marker);
                            
                        } else {
                            alert('해당 상호명과 ID의 음식점을 찾을 수 없습니다.');
                        }
                    } else {
                        alert('음식점 정보를 가져오는 데 실패했습니다. 상태: ' + status);
                    }
                }, { location: coords });
            } else {
                alert('장소 정보를 가져오는 데 실패했습니다. 상태: ' + status);
            }
        });
    }

	document.addEventListener("DOMContentLoaded", function() {
	    var modal = document.getElementById("myModal");
	    var openModalBtn = document.getElementById("openModal");
	    var closeModalBtn = document.getElementsByClassName("close")[0];
	    var modalIframe = document.getElementById("modalIframe");

	    // 카카오 정보 페이지 URL
	    var kakaoInfoUrl = "<%= place.getPlaceUrl() %>"; // 실제 카카오 정보 페이지 URL로 변경

	    // 모달 열기
	    openModalBtn.onclick = function() {
	        modal.style.display = "block";
	        modalIframe.src = kakaoInfoUrl; // iframe에 URL 설정
	    }

	    // 모달 닫기
	    closeModalBtn.onclick = function() {
	        modal.style.display = "none";
	        modalIframe.src = ""; // iframe src 초기화
	    }

	    // 모달 외부 클릭 시 닫기
	    window.onclick = function(event) {
	        if (event.target == modal) {
	            modal.style.display = "none";
	            modalIframe.src = ""; // iframe src 초기화
	        }
	    }
	});
	
</script>

    
</body>
</html>