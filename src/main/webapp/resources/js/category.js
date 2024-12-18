	var ps = new kakao.maps.services.Places();
	
	let currentPage = 1;
	const pageSize = 10;
	let places = []
	
	function updateSubcity() {
	    const citySelect = document.getElementById('citySelect');
	    const subCities = document.querySelectorAll('.subCity');
	    
	    subCities.forEach(select => {
	        select.style.display = 'none';
	    });
	    
	    const selectedCity = citySelect.value;
	    if (selectedCity) {
			const subCitySelect = document.getElementById(selectedCity);
			    if (subCitySelect) {
			        subCitySelect.style.display = 'block';
			    }
	    }
	
	    const subSelects = document.querySelectorAll('[id^="1001"], [id^="1003"]');
	    subSelects.forEach(select => {
	        select.style.display = 'none';
	    });
	}
	
	function updateSubSelect(selectedSubcity) {
	    const subSelects = document.querySelectorAll('[id$="subSelect"]');
	    
	    subSelects.forEach(select => {
	        select.style.display = 'none';
	    });
	
	    switch (selectedSubcity) {
	        case '의창구':
	            document.getElementById('100101subSelect').style.display = 'block';
	            break;
	        case '성산구':
	            document.getElementById('100102subSelect').style.display = 'block';
	            break;
	        case '마산합포구':
	            document.getElementById('100103subSelect').style.display = 'block';
	            break;
	        case '마산회원구':
	            document.getElementById('100104subSelect').style.display = 'block';
	            break;
	        case '진해구':
	            document.getElementById('100105subSelect').style.display = 'block';
	            break;
	        case '시내동지구':
	            document.getElementById('100301subSelect').style.display = 'block';
	            break;
	    }
	}
	
	function updateCategory() {
	    const categorySelect = document.getElementById('categorySelect');
	    const selectedCategory = categorySelect.value;
	}
	
	document.getElementById('citySelect').onchange = updateSubcity;
	
	document.querySelectorAll('.subCity').forEach(select => {
	    select.onchange = function() {
	        updateSubSelect(this.value);
	    };
	});
	
	
	function updateCategory() {
		const categorySelect = document.getElementById('categorySelect');
		const subCategoryFood = document.getElementById('subCategoryFood');
		const subCategorySleep = document.getElementById('subCategorySleep');
	
	    if (categorySelect.value === '음식점') {
	    	subCategoryFood.style.display = 'block';
	    } else {
	    	subCategoryFood.style.display = 'none';
	    	subCategoryFood.selectedIndex = 0;
	    }
		
		if(categorySelect.value === '숙박'){
			subCategorySleep.style.display = 'block';
		} else {
			subCategorySleep.style.display = 'none';
			subCategoryFood.selectedIndex = 0;
		}
	}
	
	document.getElementById('searchButton').addEventListener('click', function(event) {

	    event.preventDefault();
		
		var form = document.getElementById('searchForm');

		// 선택된 city 값 가져오기
		var city = form.city.value;
		var category = form.category.value;

		// 선택된 subCity 값 가져오기
		var subCity = '';
		var subCityElements = document.getElementsByName('subCity');
		for (var i = 0; i < subCityElements.length; i++) {
		    if (subCityElements[i].style.display !== 'none') { // 보이는 subCity 선택
		        subCity = subCityElements[i].value;
		        break; // 첫 번째 선택된 값만 가져오기
		    }
		}
		
		// 선택된 country 값 가져오기
		var country = '';
		var countryElements = document.getElementsByName('country');
		for (var i = 0; i < countryElements.length; i++) {
		    if (countryElements[i].style.display !== 'none') { // 보이는 subCity 선택
		        country = countryElements[i].value;
		        break; // 첫 번째 선택된 값만 가져오기
		    }
		}
		
		// 선택된 subCategory 값 가져오기
		var subCategory = '';
		var subCategoryElements = document.getElementsByName('sub');
		for (var j = 0; j < subCategoryElements.length; j++) {
		    if (subCategoryElements[j].style.display !== 'none' && subCategoryElements[j].value) {
		        subCategory = subCategoryElements[j].value; // 선택된 subCategory 가져오기
		        break; // 첫 번째 선택된 값만 가져오기
		    }
		}
		
		$.ajax({
		        url: '/howAbout/place/kakaoApiService',
		        type: 'POST',
		        contentType: 'application/json; charset=UTF-8',
		        data: JSON.stringify({ city, subCity, category, subCategory, country }),
		        success: function(keyword) {
		            if(keyword.keyword){
						searchPlaces(keyword.keyword);
					} else {
						places = keyword.list;
						displayResults();
						setupPagination();
					}
		        },
		        error: function(xhr, status, error) {
		            console.error('AJAX 오류:', error);
		        }
		    });

	});
	

	
	
	function searchPlaces(keyword) {
	    for (let page = 1; page <= 3; page++) {
	        // 각 페이지 요청에 대해 지연을 추가
	        setTimeout(() => {
	            ps.keywordSearch(keyword, (data, status) => {
	                placesSearchCB(data, status, page, keyword); // 페이지 정보를 전달
	            }, {
	                page: page
	            });
	        }, (page - 1) * 700); // 페이지 번호에 따라 지연 시간 계산
	    }
	}
	
	function placesSearchCB(data, status, page, keyword) {
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
	                id: place.id,
					key: keyword
	            }));
				
	            sendToController(placeData);
	        } else {
	            alert('검색 결과가 존재하지 않습니다.');
	        }
	    } else {
	        alert('검색 중 오류가 발생했습니다.');
	    }
	}
	
	function sendToController(placeData) {
		
//		var dataToSend = {
//		        places: placeData, // 장소 데이터 배열
//		        keyword: keyword    // 검색 키워드
//		    };
//		키와 밸류만을 JSON형식으로 저장하기 때문에, 밸류 전체가 JSON인 경우는 하나의 문자열로 판단되어 들어가는 것 같음.
//		따라서 기존 DTO에 키워드 값을 추가하여 하나의 배열로 전송하려고 함.
			
		$.ajax({
			url: '/howAbout/place/kakaoMapconn', // 서버의 컨트롤러 URL로 변경
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(placeData),
			success: function(response) {
				places = response.list;
				displayResults();
				setupPagination();
			},
			error: function(xhr, status, error) {
				console.error('AJAX 오류:', error);
			}
		});
	}

	function displayResults(results) {
	    var resultsDiv = document.getElementById('results');
	    resultsDiv.innerHTML = ''; // 이전 결과 초기화

		const start = (currentPage - 1) * pageSize;
		const end = start + pageSize;
		const paginatedPlaces = places.slice(start, end);

		paginatedPlaces.forEach(place => {
		    const placeEl = document.createElement('div');
		    placeEl.innerHTML =
		        "<h2><a href='/howAbout/place/newGetOne/placeID/"+place.id+"'>"+place.place_name+"</a></h2> <p>주소: "+place.address_name+"</p><p>전화번호: "+place.phone+"</p><p><a href='"+place.place_url+"' target='_blank'>카카오맵에서 보기</a></p><hr />";
		    resultsDiv.appendChild(placeEl);
		});
	}

	function setupPagination() {
	    const totalPages = Math.ceil(places.length / pageSize);
	    const paginationDiv = document.getElementById('pagination');
	    paginationDiv.innerHTML = ''; // 이전 페이지네이션 초기화

	    for (let i = 1; i <= totalPages; i++) {
	        const pageLink = document.createElement('a');
			pageLink.className = 'pageNum';
	        pageLink.innerText = i;
	        pageLink.href = '#';
	        pageLink.onclick = function() {
	            currentPage = i;
	            displayResults();
	        };
	        paginationDiv.appendChild(pageLink);
	    }
	}
	
