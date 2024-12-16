
    const readonlyInputs = document.querySelectorAll('.readonly-input');
	const readonlyUpdate = document.querySelectorAll('.readonly-updateinput');

	readonlyInputs.forEach(function(input) {
	        input.addEventListener('focus', function(event) {
	            alert('이 입력 필드는 수정할 수 없습니다.\n상호명과 주소만 입력하신 후 조회를 해주세요.');
	            input.blur();
	        });
	    });
		
	readonlyUpdate.forEach(function(input) {
		     input.addEventListener('focus', function(event) {
		         alert('해당 필드는 임의로 수정하실 수 없습니다.');
		         input.blur();
		     });
		 });

	document.addEventListener('DOMContentLoaded', function() {
	    document.getElementById('placeSerch').addEventListener('click', function() {
	        var address = document.getElementById('address').value;
	        var restaurantName = document.getElementById('placeName').value;
	        searchRestaurantsByAddress(address, restaurantName);
	    });
	});



	function searchRestaurantsByAddress(address, restaurantName) {
	    var ps = new kakao.maps.services.Places();
	
	    // 주소로 장소 검색
	    ps.keywordSearch(address, function(data, status) {
	        if (status === kakao.maps.services.Status.OK) {
	            var place = data[0];
	            var coords = new kakao.maps.LatLng(place.y, place.x);
	            ps.keywordSearch(restaurantName, function(restaurants, status) {
	                if (status === kakao.maps.services.Status.OK) {
	                    var resultContainer = document.getElementById('result');
	                    resultContainer.innerHTML = '';
	
	                    restaurants.forEach(function(restaurant) {
	                        if (restaurant.place_name.includes(restaurantName)) {
	                            var restaurantCoords = new kakao.maps.LatLng(restaurant.y, restaurant.x);
	                            var distance = getDistance(coords, restaurantCoords);
	
	                            if (distance <= 3000) {
	                            	
	                            	var restaurantItem = document.createElement('p');
	                                var link = document.createElement('a');
	                                link.href = "#";
	                                link.textContent = restaurant.place_name + ' : ' + restaurant.address_name;
	
	                                link.addEventListener('click', function(event) {
	                                    event.preventDefault();
	                                    document.getElementById('address').value = restaurant.address_name;
										document.getElementById('roadAddress').value = restaurant.road_address_name;
	                                    document.getElementById('placeName').value = restaurant.place_name;
	                                    document.getElementById('category').value = restaurant.category_group_name;
	                                    document.getElementById('categoryAll').value = restaurant.category_name;
	                                    document.getElementById('phone').value = restaurant.phone;
										document.getElementById('placeUrl').value = restaurant.place_url;
										document.getElementById('placeID').value = restaurant.id;
										document.getElementById('longitude').value = restaurant.x;
										document.getElementById('latitude').value = restaurant.y;
	                                    searchRestaurantsByAddress(restaurant.address_name, restaurant.place_name);
	                                });
	
	                                restaurantItem.appendChild(link);
	                                resultContainer.appendChild(restaurantItem);
	                                
	                            }
	                        }
	                    });
	
	                    if (resultContainer.innerHTML === '') {
	                        resultContainer.innerHTML = '해당 상호명과 일치하는 음식점을 찾을 수 없습니다.';
	                    }
	                } else {
	                    alert('음식점 정보를 가져오는 데 실패했습니다. 상태: ' + status);
	                }
	            }, { location: coords }); // 좌표를 지정하여 범위 검색
	        } else {
	            alert('장소 정보를 가져오는 데 실패했습니다. 상태: ' + status);
	        }
	    });
	}
	
	function getDistance(coord1, coord2) {
	    var lat1 = coord1.getLat();
	    var lng1 = coord1.getLng();
	    var lat2 = coord2.getLat();
	    var lng2 = coord2.getLng();
	
	    var R = 6371e3;
	    var φ1 = lat1 * Math.PI / 180;
	    var φ2 = lat2 * Math.PI / 180;
	    var Δφ = (lat2 - lat1) * Math.PI / 180;
	    var Δλ = (lng2 - lng1) * Math.PI / 180;
	
	    var a = Math.sin(Δφ / 2) * Math.sin(Δφ / 2) +
	            Math.cos(φ1) * Math.cos(φ2) *
	            Math.sin(Δλ / 2) * Math.sin(Δλ / 2);
	    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
	
	    return R * c;
	}

	function savePlace() {

				var placeID = document.querySelector("#placeID").value;
				
				$.ajax({
					url : "/howAbout/place/newGetOne/placeID/"+placeID,
					type : "POST",
					data : JSON.stringify({"placeID" : placeID, "status" : "add" }),
					contentType: 'application/json',
					success : function(data){
						
						if(data.status){
							if(confirm("등록하시겠습니까?")==true){
								document.getElementById('placeForm').submit();
							} else { return false; }
						} else {
							if(data.error01 !== undefined){ alert("이미 등록된 시설 입니다."); }
							if(data.error02 !== undefined){ alert("잘못된 접근입니다."); }
						}
				},
					error : function(errorThrown){ alert("처리에 실패했습니다."); }
				})
				
	}

	function updatePlace() {

				var placeID = document.querySelector("#placeID").value;
				
				$.ajax({
					url : "/howAbout/place/newGetOne/placeID/"+placeID,
					type : "POST",
					data : JSON.stringify({ "placeID" : placeID, "status" : "update" }),
					contentType: 'application/json',
					success : function(data){
						
						if(data.status){
							if(confirm("등록하시겠습니까?")==true){
								document.getElementById('placeForm').submit();
							} else { return false; }
						} else {
							if(data.error02 !== undefined){ alert("잘못된 접근입니다."); }
						}
				},
					error : function(errorThrown){ alert("처리에 실패했습니다."); }
				})
				
	}
