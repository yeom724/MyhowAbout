//도시 선택 시 하위 선택 박스 업데이트
function updateSubcity() {
    const citySelect = document.getElementById('citySelect');
    const subCities = document.querySelectorAll('.subCity');
    
    // 모든 하위 선택 박스 숨기기
    subCities.forEach(select => {
        select.style.display = 'none';
    });
    
    // 선택한 도시의 하위 선택 박스 표시
    const selectedCity = citySelect.value;
	console.log(selectedCity);
    if (selectedCity) {
		const subCitySelect = document.getElementById(selectedCity);
		    if (subCitySelect) {
		        subCitySelect.style.display = 'block';
		    }
    }

    // 구 선택 박스 숨기기
    const subSelects = document.querySelectorAll('[id^="1001"], [id^="1003"]');
    subSelects.forEach(select => {
        select.style.display = 'none';
    });
}

// 구 선택 시 하위 세부 선택 박스 업데이트
function updateSubSelect(selectedSubcity) {
    const subSelects = document.querySelectorAll('[id$="subSelect"]');
    
    // 모든 세부 선택 박스 숨기기
    subSelects.forEach(select => {
        select.style.display = 'none';
    });

    // 선택한 구에 맞는 세부 선택 박스 표시
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

// 카테고리 선택 시 동작
function updateCategory() {
    const categorySelect = document.getElementById('categorySelect');
    const selectedCategory = categorySelect.value;

    // 선택된 카테고리에 따라 추가적인 동작을 구현
    console.log("선택된 카테고리:", selectedCategory);
}

// 이벤트 리스너 설정
document.getElementById('citySelect').onchange = updateSubcity;
document.querySelectorAll('.subCity').forEach(select => {
    select.onchange = function() {
        updateSubSelect(this.value);
    };
});


function updateCategory() {
	const categorySelect = document.getElementById('categorySelect');
	const subCategoryFood = document.getElementById('subCategoryFood');

    // 선택된 값에 따라 서브 카테고리 표시
    if (categorySelect.value === 'FD6') {
    	subCategoryFood.style.display = 'block'; // 서브 카테고리 표시
    } else {
    	subCategoryFood.style.display = 'none'; // 서브 카테고리 숨김
    	subCategoryFood.selectedIndex = 0;
    }
}

	document.getElementById('searchButton').addEventListener('click', function() {
            
            document.getElementById('searchForm').submit();
    });