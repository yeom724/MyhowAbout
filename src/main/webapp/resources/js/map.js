var mapContainer = document.getElementById('map');

var mapOption = { 
    center: new kakao.maps.LatLng(35.9095, 128.6018), // 초기 지도 중심 좌표
    level: 7 // 지도 확대 레벨
};

var map = new kakao.maps.Map(mapContainer, mapOption);
var placesService = new kakao.maps.services.Places(); // 장소 검색 서비스
var savedPlaces = []; // 저장된 장소를 배열로 관리
var markers = []; // 마커를 저장할 배열
var line; // 선 객체를 저장할 변수

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

        var link = document.createElement('a'); // a 태그로 변경
        link.href = "#"; // 링크 클릭 시 페이지 이동 방지
        link.textContent = address;
        link.className = 'savedPlace'; // 줄 바꿈을 위해 클래스 추가

        // 링크 클릭 시 해당 위치로 지도 이동
        link.onclick = function() {
            map.setCenter(new kakao.maps.LatLng(lat, lng)); // 해당 위치로 지도 이동
            map.panBy(0, -100); // 조금 위로 이동하여 마커가 보이게 함
        };

        document.getElementById('savedPlaces').appendChild(link); // 저장된 장소 div에 링크 추가

        // 거리 및 선 그리기
        drawLine();
    } else {
        alert('이 장소는 이미 저장되어 있습니다.');
    }
}

// 선 그리기 함수
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
    }
}