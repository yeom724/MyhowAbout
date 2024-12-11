<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=14cdbb863b4c2d47cee16ab2b06356c6&libraries=services"></script>
</head>
<body>

<input id="serch" type="text">

<script type="text/javascript">
	async function fetchRestaurants() {
	    const apiKey = '14cdbb863b4c2d47cee16ab2b06356c6'; // 본인의 REST API 키로 변경
	    const query = encodeURIComponent('창원시 성산구 맛집'); // 검색어
	    const pageSize = 15; // 한 페이지당 결과 수
	    let totalResults = []; // 모든 결과를 저장할 배열
	    let page = 1; // 페이지 초기화

	    while (true) {
	        const apiUrl = `https://dapi.kakao.com/v2/local/search/keyword.json?query=`+query+`&size=`+pageSize+`&page=`+page;

	        try {
	            const response = await fetch(apiUrl, {
	                method: 'GET',
	                headers: {
	                    'Authorization': `KakaoAK `+apiKey // API 키 포함
	                }
	            });

	            console.log('응답 코드:', response.status); // 응답 코드 확인

	            if (!response.ok) {
	                const errorText = await response.text(); // 오류 메시지 읽기
	                throw new Error('네트워크 응답이 좋지 않습니다: ' + errorText);
	            }

	            const data = await response.json();
	            if (data.documents.length > 0) {
	                totalResults = totalResults.concat(data.documents); // 결과 추가
	                page++; // 다음 페이지로 이동
	            } else {
	                break; // 더 이상 결과가 없으면 종료
	            }
	        } catch (error) {
	            console.error('오류 발생:', error);
	            break; // 오류 발생 시 종료
	        }
	    }

	    // 모든 결과 출력
	    totalResults.forEach(place => {
	        console.log('장소 이름:', place.place_name); // 장소 이름
	        console.log('주소:', place.address_name); // 주소
	        console.log('전화번호:', place.phone); // 전화번호
	        console.log('카카오맵 URL:', place.place_url); // 카카오맵 URL
	        console.log('---------------------');
	    });

	    console.log(`총 ${totalResults.length}개의 결과를 가져왔습니다.`);
	}

	// 페이지 로드 시 실행
	window.onload = fetchRestaurants;
</script>
</body>
</html>