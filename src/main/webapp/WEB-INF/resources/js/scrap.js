async function fetchPlaceInfo() {
    const apiKey = 'YOUR_REST_API_KEY'; // API 키를 여기에 입력
    const x = 127.9141; // x 좌표 (경도)
    const y = 35.6904; // y 좌표 (위도)

    // API URL 생성 (x와 y 좌표를 포함)
    const apiUrl = 'https://dapi.kakao.com/v2/local/geo/coord2address.json?x=' + x + '&y=' + y;

    try {
        const response = await fetch(apiUrl, {
            method: 'GET',
            headers: {
                'Authorization': 'KakaoAK ' + apiKey
            }
        });

        console.log('응답 코드:', response.status); // 응답 코드 확인

        if (!response.ok) {
            throw new Error('네트워크 응답이 좋지 않습니다: ' + response.status);
        }

        const data = await response.json();
        if (data.documents.length > 0) {
            const placeName = data.documents[0].address_name; // 주소 가져오기
            console.log('장소 이름:', placeName);
            // 카카오맵 URL 생성
            const placeUrl = 'https://place.map.kakao.com/' + data.documents[0].id;
            console.log('카카오맵 URL:', placeUrl);
        } else {
            console.log('장소를 찾을 수 없습니다.');
        }
    } catch (error) {
        console.error('오류 발생:', error);
    }
}

// 페이지 로드 시 실행
window.onload = fetchPlaceInfo;