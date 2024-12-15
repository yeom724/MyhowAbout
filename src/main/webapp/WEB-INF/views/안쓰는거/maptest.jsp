<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장소 저장 및 거리 계산</title>
	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fc7be1941eb9e2a48429965c1db39c7e&libraries=services"></script>
    <style>
        #map {
            width: 500px;
            height: 400px;
        }
        .savedPlace {
            display: flex;
            justify-content: space-between;
            margin: 5px 0;
        }
        .delete-btn {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }
    </style>
</head>
<body>
    <div id="map"></div>
    <div id="savedPlaces"></div>
    <div id="distanceInfo"></div>
    <button id="calculateDistance">거리 계산</button>

    <script>
        // 지도 초기화
        var map;
        var markers = [];
        var savedPlaces = [];
        var placeCount = 0;

        function initMap() {
            map = new kakao.maps.Map(document.getElementById('map'), {
                center: new kakao.maps.LatLng(35.2377, 128.6919), // 초기 중심 좌표
                level: 7 // 지도 확대 레벨
            });

            // 특정 장소 표시 (예: 대학교)
            var places = [
                { name: '대구대학교', lat: 35.2377, lng: 128.6919 },
                { name: '경북대학교', lat: 35.8854, lng: 128.6096 }
                // 추가 장소는 여기에
            ];

            places.forEach(place => {
                var marker = new kakao.maps.Marker({
                    position: new kakao.maps.LatLng(place.lat, place.lng),
                    map: map
                });

                // 마커 클릭 시 장소 저장
                kakao.maps.event.addListener(marker, 'click', function() {
                    savePlace(place.name, place.lat, place.lng);
                });

                markers.push(marker);
            });
        }

        function savePlace(name, lat, lng) {
            // 장소 추가
            savedPlaces.push({ name: name, lat: lat, lng: lng });
            placeCount++;

            var item = document.createElement('div');
            item.className = 'savedPlace';
            item.innerHTML = name + ' <button class="delete-btn" onclick="deletePlace(\'' + name + '\')">삭제</button>';
            document.getElementById('savedPlaces').appendChild(item);
        }

        function deletePlace(name) {
            savedPlaces = savedPlaces.filter(place => place.name !== name);
            document.getElementById('savedPlaces').innerHTML = '';
            savedPlaces.forEach(place => {
                var item = document.createElement('div');
                item.className = 'savedPlace';
                item.innerHTML = place.name + ' <button class="delete-btn" onclick="deletePlace(\'' + place.name + '\')">삭제</button>';
                document.getElementById('savedPlaces').appendChild(item);
            });
        }

        document.getElementById('calculateDistance').onclick = function() {
            calculateDistance();
        };

        function calculateDistance() {
            if (savedPlaces.length < 2) {
                alert('두 개 이상의 장소를 저장해야 거리 계산이 가능합니다.');
                return;
            }

            var totalDistance = 0;
            for (var i = 0; i < savedPlaces.length - 1; i++) {
                var start = savedPlaces[i];
                var end = savedPlaces[i + 1];
                totalDistance += haversineDistance(start.lat, start.lng, end.lat, end.lng);
            }

            // 도보 및 자전거 시간 계산 (예: 1km당 15분, 1km당 5분)
            var walkingTime = (totalDistance / 1000) * 15; // 분
            var bikingTime = (totalDistance / 1000) * 5; // 분

            document.getElementById('distanceInfo').innerText =
                '총 거리: ' + (totalDistance / 1000).toFixed(2) + 'km\n' +
                '도보 시간: ' + walkingTime.toFixed(2) + '분\n' +
                '자전거 시간: ' + bikingTime.toFixed(2) + '분';
        }

        function calculateDistance() {
            if (savedPlaces.length < 2) {
                alert('두 개 이상의 장소를 저장해야 거리 계산이 가능합니다.');
                return;
            }

            var totalDistance = 0;
            for (var i = 0; i < savedPlaces.length - 1; i++) {
                var start = savedPlaces[i];
                var end = savedPlaces[i + 1];
                totalDistance += haversineDistance(start.lat, start.lng, end.lat, end.lng);
            }

            // 도보 및 자전거 시간 계산 (예: 1km당 15분, 1km당 5분)
            var walkingTime = (totalDistance / 1000) * 15; // 분
            var bikingTime = (totalDistance / 1000) * 5; // 분

            document.getElementById('distanceInfo').innerText =
                '총 거리: ' + (totalDistance / 1000).toFixed(2) + 'km\n' +
                '도보 시간: ' + walkingTime.toFixed(2) + '분\n' +
                '자전거 시간: ' + bikingTime.toFixed(2) + '분';
        }

        function haversineDistance(lat1, lon1, lat2, lon2) {
            const R = 6371; // 지구의 반지름 (킬로미터)
            const lat1Rad = lat1 * (Math.PI / 180);
            const lat2Rad = lat2 * (Math.PI / 180);
            const deltaLat = (lat2 - lat1) * (Math.PI / 180);
            const deltaLon = (lon2 - lon1) * (Math.PI / 180);
            
            const a = Math.sin(deltaLat / 2) * Math.sin(deltaLat / 2) +
                      Math.cos(lat1Rad) * Math.cos(lat2Rad) *
                      Math.sin(deltaLon / 2) * Math.sin(deltaLon / 2);
            const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
            
            return R * c * 1000; // 거리 반환 (미터)
        }

        // 페이지 로드 시 지도 초기화
        window.onload = initMap;

    </script>
</body>
</html>