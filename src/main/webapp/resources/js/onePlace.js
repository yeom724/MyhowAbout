document.addEventListener("DOMContentLoaded", function() {
    
    searchRestaurantsByCoordinates(x, y, placeName, placeCategory);
	
});

var map;

function searchRestaurantsByCoordinates(x, y, restaurantName, placeCategory) {
    var ps = new kakao.maps.services.Places();
    var coords = new kakao.maps.LatLng(y, x);
	if(placeCategory === "음식점") { placeCategory = 'FD6'; }
	if(placeCategory === "카페") { placeCategory = 'CE7'; }
	if(placeCategory === "숙박") { placeCategory = 'AD5' }
	if(placeCategory === "관광") { placeCategory = 'AT4' }
	
	console.log("category : "+placeCategory);

    // 지도 초기화
    var mapContainer = document.getElementById('map');
    var mapOptions = {
        center: coords,
        level: 3
    };
    
	map = new kakao.maps.Map(mapContainer, mapOptions);

    // 음식점 검색 시작
    searchRestaurants(coords, restaurantName, placeCategory, 1);
}

function searchRestaurants(coords, restaurantName, placeCategory, page) {
    var ps = new kakao.maps.services.Places();

    
    ps.categorySearch(placeCategory, function(restaurants, status) {
		console.log(kakao.maps.services.Status);
        if (status === kakao.maps.services.Status.OK) {
            console.log(restaurants); // 검색된 음식점 목록 출력
            var foundRestaurants = [];

            // 음식점 목록에서 상호명 필터링
            restaurants.forEach(function(restaurant) {
                if (restaurant.place_name.includes(restaurantName)) {
                    foundRestaurants.push(restaurant);
                }
            });

            // 일치하는 음식점이 있는 경우
            if (foundRestaurants.length > 0) {
                foundRestaurants.forEach(function(restaurant) {
                    var restaurantCoords = new kakao.maps.LatLng(restaurant.y, restaurant.x);

                    // 마커 표시
                    var marker = new kakao.maps.Marker({
                        position: restaurantCoords,
                        map: map // 전역 변수를 사용하여 지도에 추가
                    });

                    // 인포윈도우 표시
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="padding:5px;">' + restaurant.place_name + '</div>'
                    });
                    infowindow.open(map, marker);
                });
            } else if (restaurants.length === 15 && page < 3) {
                // 검색 결과가 15개일 경우, 다음 페이지로 추가 검색
                searchRestaurants(coords, restaurantName, placeCategory, page + 1);
            } else {
				
				// 일치하는 음식점이 없는 경우, 주어진 좌표에 상호명 마커 표시
				var marker = new kakao.maps.Marker({
				    position: coords,
				    map: map
				});

				// 인포윈도우 표시
				var infowindow = new kakao.maps.InfoWindow({
				    content: '<div style="padding:5px;">' + restaurantName + '</div>'
				});
				infowindow.open(map, marker);

            }
        } else {
            alert('음식점 정보를 가져오는 데 실패했습니다. 상태: ' + status);
        }
    }, { location: coords, radius: 500, page: page });
}

document.addEventListener("DOMContentLoaded", function() {
    var modal = document.getElementById("myModal");
    var openModalBtn = document.getElementById("openModal");
    var closeModalBtn = document.getElementsByClassName("close")[0];
    var modalIframe = document.getElementById("modalIframe");


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
