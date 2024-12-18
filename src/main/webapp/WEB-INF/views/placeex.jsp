<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <title>키워드로 장소검색하고 목록으로 표출하기</title>
    <script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries=services"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <!-- jQuery 추가 -->
    <style>
		.map_wrap, .map_wrap * {margin:0;padding:0;font-family:'Malgun Gothic',dotum,'돋움',sans-serif;font-size:12px;}
		.map_wrap a, .map_wrap a:hover, .map_wrap a:active{color:#000;text-decoration: none;}
		.map_wrap {position:relative;width:100%;height:500px;}
		#menu_wrap {position:absolute;top:0;left:0;bottom:0;width:250px;margin:10px 0 30px 10px;padding:5px;overflow-y:auto;background:rgba(255, 255, 255, 0.7);z-index: 1;font-size:12px;border-radius: 10px;}
		.bg_white {background:#fff;}
		#menu_wrap hr {display: block; height: 1px;border: 0; border-top: 2px solid #5F5F5F;margin:3px 0;}
		#menu_wrap .option{text-align: center;}
		#menu_wrap .option p {margin:10px 0;}  
		#menu_wrap .option button {margin-left:5px;}
		#placesList li {list-style: none;}
		#placesList .item {position:relative;border-bottom:1px solid #888;overflow: hidden;cursor: pointer;min-height: 65px;}
		#placesList .item span {display: block;margin-top:4px;}
		#placesList .item h5, #placesList .item .info {text-overflow: ellipsis;overflow: hidden;white-space: nowrap;}
		#placesList .item .info{padding:10px 0 10px 55px;}
		#placesList .info .gray {color:#8a8a8a;}
		#placesList .info .jibun {padding-left:26px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/places_jibun.png) no-repeat;}
		#placesList .info .tel {color:#009900;}
		#placesList .item .markerbg {float:left;position:absolute;width:36px; height:37px;margin:10px 0 0 10px;background:url(https://t1.daumcdn.net/localimg/localimages/07/mapapidoc/marker_number_blue.png) no-repeat;}
		#placesList .item .marker_1 {background-position: 0 -10px;}
		#placesList .item .marker_2 {background-position: 0 -56px;}
		#placesList .item .marker_3 {background-position: 0 -102px}
		#placesList .item .marker_4 {background-position: 0 -148px;}
		#placesList .item .marker_5 {background-position: 0 -194px;}
		#placesList .item .marker_6 {background-position: 0 -240px;}
		#placesList .item .marker_7 {background-position: 0 -286px;}
		#placesList .item .marker_8 {background-position: 0 -332px;}
		#placesList .item .marker_9 {background-position: 0 -378px;}
		#placesList .item .marker_10 {background-position: 0 -423px;}
		#placesList .item .marker_11 {background-position: 0 -470px;}
		#placesList .item .marker_12 {background-position: 0 -516px;}
		#placesList .item .marker_13 {background-position: 0 -562px;}
		#placesList .item .marker_14 {background-position: 0 -608px;}
		#placesList .item .marker_15 {background-position: 0 -654px;}
		#pagination {margin:10px auto;text-align: center;}
		#pagination a {display:inline-block;margin-right:10px;}
		#pagination .on {font-weight: bold; cursor: default;color:#777;}
</style>


</head>

<body>
    <h1>맛집 검색</h1>
    <input type="text" id="keyword" placeholder="특정 지역의 맛집을 입력하세요" />
    <button id="searchButton">검색</button>

    <div id="results"></div> <!-- 결과 출력 영역 -->
    <button id="loadMoreButton" style="display:none;">더 보기</button> <!-- 더 보기 버튼 -->

    <script>
        var ps = new kakao.maps.services.Places();
        var currentPage = 1; // 현재 페이지
        var totalPages = 0; // 전체 페이지 수

        document.getElementById('searchButton').addEventListener('click', function() {
            searchPlaces();
        });

        document.getElementById('loadMoreButton').addEventListener('click', function() {
            currentPage++;
            searchPlaces();
        });

        function searchPlaces() {
            var keyword = document.getElementById('keyword').value;
            if (!keyword.trim()) {
                alert('검색어를 입력해주세요!');
                return;
            }


            // 키워드로 장소 검색 요청
            ps.keywordSearch(keyword, placesSearchCB, {
                page: currentPage // 요청할 페이지 번호
            });
        }

        function placesSearchCB(data, status) {
            console.log('API 응답:', data);

            if (status === kakao.maps.services.Status.OK) {
                if (Array.isArray(data) && data.length > 0) {
                    var placeData = data.map(place => ({
                    	place_name: place.place_name,
                        address_name: place.address_name,
                        road_address_name : place.road_address_name,
                        phone: place.phone,
                        y: place.y,
                        x: place.x,
                        place_url: place.place_url,
                        category_group_name: place.category_group_name,
                        category_name: place.category_name,
                        id: place.id
                    }));

                    displayResults(placeData); // 데이터를 서버로 전송
                    document.getElementById('loadMoreButton').style.display = 'block'; // 더 보기 버튼 표시
                } else {
                    alert('검색 결과가 존재하지 않습니다.');
                }
            } else {
                alert('검색 중 오류가 발생했습니다.');
            }
        }

        function displayResults(results) {
            var resultsDiv = document.getElementById('results');
            resultsDiv.innerHTML = ''; // 이전 결과 초기화

            results.forEach(place => {
                var placeEl = document.createElement('div');
                placeEl.innerHTML = 
                    "<h2>"+place.place_name+"</h2> <p>주소: "+place.address_name+"</p><p>전화번호: "+place.phone+"</p><p><a href='"+place.place_url+"' target='_blank'>카카오맵에서 보기</a></p><hr />";
                resultsDiv.appendChild(placeEl);
            });
        }

        function sendToController(placeData) {
            $.ajax({
                url: '/howAbout/place/DBconn', // 서버의 컨트롤러 URL로 변경
                type: 'POST',
                contentType: 'application/json',
                data: JSON.stringify(placeData),
                success: function(response) {
                    console.log('서버로부터의 응답:', response);
                },
                error: function(xhr, status, error) {
                    console.error('AJAX 오류:', error);
                }
            });
        }
    </script>
</body>
</html>