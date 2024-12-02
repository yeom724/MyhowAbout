<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거리 계산기</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fc7be1941eb9e2a48429965c1db39c7e&libraries=services"></script>
<style>
    #map {
        width: 100%;
        height: 350px;
    }
    .result-list {
        max-height: 100px;
        overflow-y: auto;
        border: 1px solid #ccc;
        margin-top: 5px;
        position: relative;
        z-index: 10; /* 리스트가 지도 위에 나타나도록 설정 */
    }
    .result-item {
        padding: 5px;
        cursor: pointer;
    }
    .result-item:hover {
        background-color: #f0f0f0;
    }
</style>
</head>
<body>
    <h3>거리 계산기</h3>
    <div>
        <input type="text" id="location1" placeholder="위치 1 (예: 이태원)" oninput="searchLocation('location1')">
        <div id="resultList1" class="result-list"></div>
        
        <input type="text" id="location2" placeholder="위치 2 (예: 강남)" oninput="searchLocation('location2')">
        <div id="resultList2" class="result-list"></div>

        <button onclick="confirmLocations()">확인</button>
        <button onclick="calculateDistance()">거리 계산</button>
    </div>
    <div id="map"></div>
    <div id="result"></div>

    <script>
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(37.566826, 126.9786567),
            level: 7
        };  
        var map = new kakao.maps.Map(mapContainer, mapOption); 
        var ps = new kakao.maps.services.Places(); 
        var loc1Position, loc2Position;

        function searchLocation(inputId) {
            var keyword = document.getElementById(inputId).value;
            var resultListId = (inputId === 'location1') ? 'resultList1' : 'resultList2';
            var resultList = document.getElementById(resultListId);
            resultList.innerHTML = ""; // 이전 검색 결과 초기화

            if (keyword.length > 1) { // 최소 2글자 이상 입력 시 검색
                ps.keywordSearch(keyword, function(data, status) {
                    if (status === kakao.maps.services.Status.OK) {
                        data.forEach(function(place) {
                            var item = document.createElement('div');
                            item.className = 'result-item';
                            item.innerHTML = place.place_name;
                            item.onclick = function() { selectLocation(place, inputId); };
                            resultList.appendChild(item);
                        });
                    }
                });
            }
        }

        function selectLocation(place, inputId) {
            if (inputId === 'location1') {
                loc1Position = new kakao.maps.LatLng(place.y, place.x);
                document.getElementById('location1').value = place.place_name; // 선택된 장소 이름
                document.getElementById('resultList1').innerHTML = ""; // 결과 리스트 초기화
            } else {
                loc2Position = new kakao.maps.LatLng(place.y, place.x);
                document.getElementById('location2').value = place.place_name; // 선택된 장소 이름
                document.getElementById('resultList2').innerHTML = ""; // 결과 리스트 초기화
            }
        }

        function confirmLocations() {
            if (!loc1Position || !loc2Position) {
                alert("위치 1과 위치 2를 모두 선택해주세요.");
                return;
            }

            // 선택된 위치에 마커 표시
            displayMarkers();
        }

        function calculateDistance() {
            if (loc1Position && loc2Position) {
                var distance = kakao.maps.services.calculateDistance(loc1Position, loc2Position);
                displayDistance(distance);
            } else {
                alert("두 위치를 모두 선택해주세요.");
            }
        }

        function displayDistance(distance) {
            document.getElementById('result').innerHTML = "두 위치 간의 거리: " + distance + " 미터";
        }

        function displayMarkers() {
            // 마커를 초기화하고 새로 추가
            map.setCenter(loc1Position); // 첫 번째 위치로 지도 중심 이동
            var marker1 = new kakao.maps.Marker({ map: map, position: loc1Position });
            var marker2 = new kakao.maps.Marker({ map: map, position: loc2Position });

            var bounds = new kakao.maps.LatLngBounds();
            bounds.extend(loc1Position);
            bounds.extend(loc2Position);
            map.setBounds(bounds); // 두 마커를 포함하는 범위로 지도 확대
        }
    </script>
</body>
</html>
