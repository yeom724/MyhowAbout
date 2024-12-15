document.addEventListener("DOMContentLoaded", function() {
    
    searchRestaurantsByAddress(address, restaurantName, targetId);
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
