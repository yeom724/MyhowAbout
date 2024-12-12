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

	<input type="text" id="searchInput" placeholder="검색어를 입력하세요" />
    <button type="button" id="searchButton">전송</button>
    
    <input type="text" id="searchInput2" placeholder="검색어를 입력하세요" />
    <button id="naverButton">전송</button>

<script type="text/javascript">
	
	async function fetchRestaurants(query1) {
	    const apiKey = '14cdbb863b4c2d47cee16ab2b06356c6'; // 본인의 REST API 키로 변경
	    const query = encodeURIComponent(query1); // 검색어
	    const pageSize = 10; // 한 페이지당 결과 수
	    let totalResults = []; // 모든 결과를 저장할 배열
	    let page = 0; // 페이지 초기화

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
	                page = page + 10; // 다음 페이지로 이동
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
	        console.log('그룹 카테고리:', place.category_group_name); // 카카오맵 URL
	        console.log('---------------------');
	    });

	    console.log(`총`+totalResults.length+`개의 결과를 가져왔습니다.`);
	    
	    
	    // AJAX 요청으로 결과 전송
	    try {
	        const ajaxResponse = await fetch('/howAbout/place/DBconn', { // 서버의 엔드포인트 URL로 변경
	            method: 'POST',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify(totalResults) // 가져온 결과를 JSON 형식으로 변환하여 전송
	        });

	        if (!ajaxResponse.ok) {
	            const errorText = await ajaxResponse.text();
	            throw new Error('서버 응답이 좋지 않습니다: ' + errorText);
	        }

	        const responseData = await ajaxResponse.json();
	        console.log('서버 응답:', responseData);
	    } catch (error) {
	        console.error('AJAX 요청 오류 발생:', error);
	    }
	    
	}

    // 버튼 클릭 시 검색어를 가져와 fetchRestaurants 함수 호출
    document.getElementById('searchButton').addEventListener('click', () => {
        const query = document.getElementById('searchInput').value;
        if (query) {
        	fetchRestaurants(query);
        } else {
            alert('검색어를 입력하세요.');
        }
    });
    
    async function fetchRestaurants2(query) {
        const clientId = '10kogwr25o'; // 본인의 Client ID로 변경
        const clientSecret = '3nwVmhZmUJWEbffRUg2ZN8ccFGxBKc05o6d2uI94'; // 본인의 Client Secret으로 변경
        const encodedQuery = encodeURIComponent(query); // 검색어 인코딩
        const apiUrl = `https://openapi.naver.com/v1/search/local.json?query=`+encodedQuery+`&display=100&start=1`; // API 요청 URL

        try {
            const response = await fetch(apiUrl, {
                method: 'GET',
                headers: {
                    'X-Naver-Client-Id': clientId,
                    'X-Naver-Client-Secret': clientSecret
                }
            });

            if (!response.ok) {
                const errorText = await response.text(); // 오류 메시지 읽기
                throw new Error('네트워크 응답이 좋지 않습니다: ' + errorText);
            }

            const data = await response.json();
            
         // 모든 결과 출력
    	    data.items.forEach(place => {
    	        console.log('장소 이름:', place.title); // 장소 이름
    	        console.log('주소:', place.address); // 주소
    	        console.log('전화번호:', place.telephone); // 전화번호
    	        console.log('카카오맵 URL:', place.link); // 카카오맵 URL
    	        console.log('---------------------');
    	    });

            console.log(`총`+data.total+`개의 결과를 가져왔습니다.`);
        } catch (error) {
            console.error('오류 발생:', error);
        }
    }

    // 버튼 클릭 시 검색어를 가져와 fetchRestaurants 함수 호출
    document.getElementById('naverButton').addEventListener('click', () => {
        const query = document.getElementById('searchInput2').value;
        if (query) {
        	fetchRestaurants2(query);
        } else {
            alert('검색어를 입력하세요.');
        }
    });
</script>
</body>
</html>