<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>거리 계산기</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=fc7be1941eb9e2a48429965c1db39c7e&libraries=services"></script>
<head>
    <meta charset="utf-8">
    <title>검색한 장소 표시하기</title>
    <style>
     .delete-btn {
            background-color: red;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px; /* 둥근 모서리 */
        }
        #map { width: 100%; height: 350px; }
        .suggestions { 
            border: 1px solid #ccc; 
            max-height: 150px; 
            overflow-y: auto; 
            position: absolute; 
            z-index: 100; 
            background: white; 
            width: calc(100% - 20px); 
        }
        .suggestion-item { padding: 10px; cursor: pointer; }
        .suggestion-item:hover { background-color: #f0f0f0; }
        .savedPlace { margin-top: 10px; display: block; } /* 각 주소지를 블록으로 표시 */
        .distanceInfo { margin-top: 10px; }
        .number { font-weight: bold; color: #ee6152; }
    </style>
</head>
<body>
    <h1>검색한 장소 표시하기</h1>
    <div style="position: relative;">
        <input type="text" id="placeInput" placeholder="장소 입력" autocomplete="off">
        <button onclick="searchPlace()">검색</button>
        <div class="suggestions" id="suggestions"></div>
    </div>
    <div id="map"></div>
    <div id="savedPlaces">
        <h2>저장된 장소:</h2>
    </div>
    <div id="distanceInfo" class="distanceInfo"></div>

    <script>
        var mapContainer = document.getElementById('map');
        var mapOption = { 
            center: new kakao.maps.LatLng(35.2377, 128.6919), // 초기 지도 중심 좌표
            level: 7 // 지도 확대 레벨
        };
        
        function initMap() {
            map = new kakao.maps.Map(document.getElementById('map'), {
                center: new kakao.maps.LatLng(35.2345, 128.6928), // 초기 중심 좌표
                level: 7 // 지도 확대 레벨
            });
        }

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var placesService = new kakao.maps.services.Places(); // 장소 검색 서비스
        var savedPlaces = []; // 저장된 장소를 배열로 관리
        var markers = []; // 마커를 저장할 배열
        var line; // 선 객체를 저장할 변수
        var placeCount = 0; //장소 추가한 갯수

        // Haversine 거리 계산 함수
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

        // 장소 검색 함수
        function searchPlace() {
            var query = document.getElementById('placeInput').value;
            if (!query) {
                alert('장소를 입력하세요.');
                return;
            }
            autocomplete(query);
        }

        // 자동완성 기능
        function autocomplete(query) {
            placesService.keywordSearch(query, function(result, status) {
                var suggestions = document.getElementById('suggestions');
                suggestions.innerHTML = '';
                if (status === kakao.maps.services.Status.OK) {
                    for (var i = 0; i < result.length; i++) {
                        var item = document.createElement('div');
                        item.className = 'suggestion-item';
                        item.innerHTML = result[i].place_name;
                        item.onclick = (function(lat, lng, address) {
                            return function() {
                                document.getElementById('suggestions').innerHTML = '';
                                document.getElementById('placeInput').value = address;
                                addPlace(address, lat, lng); // 장소 저장
                                map.setCenter(new kakao.maps.LatLng(lat, lng)); // 해당 위치로 지도 이동
                                addMarker(lat, lng); // 마커 추가
                            };
                        })(result[i].y, result[i].x, result[i].place_name);
                        suggestions.appendChild(item);
                    }
                } else {
                    suggestions.innerHTML = '<div class="suggestion-item">결과가 없습니다.</div>';
                }
            });
        }

        // 마커 추가 함수
        function addMarker(lat, lng) {
            var marker = new kakao.maps.Marker({
                position: new kakao.maps.LatLng(lat, lng),
                map: map // 마커를 표시할 지도
            });
            markers.push(marker); // 마커 배열에 추가
        }

        // 장소 추가 함수
        function addPlace(address, lat, lng) {
            // 저장된 장소가 중복되지 않도록 확인
            if (!savedPlaces.some(place => place.address === address)) {
                savedPlaces.push({ address: address, lat: lat, lng: lng });
                
                var item = document.createElement('div');
                item.className = 'savedPlace'

                var link = document.createElement('a'); // a 태그로 변경
                link.href = "#"; // 링크 클릭 시 페이지 이동 방지
                link.textContent = address;
                link.className = 'savedPlace'; // 줄 바꿈을 위해 클래스 추가
                placeCount++;
				link.id = 'savedPlace_'+placeCount;

                // 링크 클릭 시 해당 위치로 지도 이동
                link.onclick = function() {
                    map.setCenter(new kakao.maps.LatLng(lat, lng)); // 해당 위치로 지도 이동
                    map.panBy(0, -100); // 조금 위로 이동하여 마커가 보이게 함
                };
                
                var deleteButton = document.createElement('button'); // 삭제 버튼 생성
                deleteButton.className = 'delete-btn'; // 클래스 추가
                deleteButton.textContent = '삭제'; // 버튼 텍스트
                deleteButton.onclick = function() {
                    deleteAddress(item, lat, lng); // 주소 삭제 함수 호출
                };

                // 생성한 링크와 삭제 버튼을 item에 추가
                item.appendChild(link);
                item.appendChild(deleteButton);
                suggestions.appendChild(item); // suggestions에 item 추가

                //suggestions.appendChild(link); // suggestions에 링크 추가
                
                document.getElementById('savedPlaces').appendChild(item); // 저장된 장소 div에 링크 추가

                // x, y 값 출력
                console.log('저장된 장소: ', address, ' - X: ', lng, ', Y: ', lat);

                // 거리 및 선 그리기
                drawLine();
                calculateAndLogTime(); // 거리 계산 후 시간 로그
            } else {
                alert('이 장소는 이미 저장되어 있습니다.');
            }
        }
        
        function deleteAddress(item, lat, lng) {
            var savedPlacesDiv = document.getElementById('savedPlaces'); // 부모 요소 가져오기
            if (savedPlacesDiv.contains(item)) {
                savedPlacesDiv.removeChild(item); // item 요소 삭제
                
                // 마커 삭제
                for (var i = 0; i < markers.length; i++) {
                    // 마커의 위치를 가져옵니다.
                    var markerPosition = markers[i].getPosition();
                    // 위치 비교 시 약간의 오차를 허용
                    if (Math.abs(markerPosition.getLat() - lat) < 0.00001 && Math.abs(markerPosition.getLng() - lng) < 0.00001) {
                        markers[i].setMap(null); // 지도에서 마커 제거
                        markers.splice(i, 1); // 배열에서 마커 제거
                        console.log('마커가 삭제되었습니다.'); // 삭제 확인 메시지
                        break; // 마커를 찾았으므로 루프 종료
                    }
                }
                
                // 저장된 장소에서 해당 장소 제거
                savedPlaces = savedPlaces.filter(place => !(place.lat === lat && place.lng === lng));
                
                console.log(item.firstChild.textContent + ' 주소가 삭제되었습니다.'); // 삭제된 주소 출력
            } else {
                console.error('삭제할 주소가 부모 요소의 자식이 아닙니다.'); // 오류 메시지 출력
            }
        }
        

        function drawLine() {
            if (savedPlaces.length > 1) {
                // 선을 제거하고 새로 그리기
                if (line) {
                    line.setMap(null);
                }

                var path = savedPlaces.map(place => new kakao.maps.LatLng(place.lat, place.lng));
                line = new kakao.maps.Polyline({
                    map: map, // 선을 표시할 지도입니다
                    path: path, // 선을 구성하는 좌표 배열입니다
                    strokeWeight: 3, // 선의 두께입니다 
                    strokeColor: '#db4040', // 선의 색깔입니다
                    strokeOpacity: 1, // 선의 불투명도입니다
                    strokeStyle: 'solid' // 선의 스타일입니다
                });
            } else if (line) {
                // 저장된 장소가 1개 이하일 때 선 제거
                line.setMap(null);
                line = null; // 선 객체 리셋
            }
        }

        // 거리 계산 및 도보/자전거 시간 로그 함수
        function calculateAndLogTime() {
            if (savedPlaces.length < 2) {
                console.log('장소가 2개 이상이어야 거리와 시간을 계산할 수 있습니다.');
                return;
            }

            var totalDistance = 0;

            // Haversine 공식을 사용하여 거리 계산
            for (var i = 0; i < savedPlaces.length - 1; i++) {
                totalDistance = haversineDistance(savedPlaces[i].lat, savedPlaces[i].lng, savedPlaces[i + 1].lat, savedPlaces[i + 1].lng);
                
                // 도보 및 자전거 시간 계산
                var walkTime = totalDistance / 67; // 도보의 분속은 67m/min
                var bicycleTime = totalDistance / 267; // 자전거의 분속은 267m/min

                // 시간 정보를 콘솔에 출력
                console.log('총 거리: ' + Math.round(totalDistance) + ' m');
                console.log('도보 시간: ' + Math.floor(walkTime / 60) + '시간 ' + Math.round(walkTime % 60) + '분');
                console.log('자전거 시간: ' + Math.floor(bicycleTime / 60) + '시간 ' + Math.round(bicycleTime % 60) + '분');
            }


        }
        
        window.onload = initMap;
    </script>
</body>
</html>
