<%@page import="java.util.List"%>
<%@page import="com.springproject.domain.Review"%>
<%@page import="com.springproject.domain.Member"%>
<%@page import="com.springproject.domain.Place"%>
<%@ page import="com.springproject.domain.deleteplace"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>

<!DOCTYPE html>
<html>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries&libraries=services"></script>
<head>
<meta charset="UTF-8">
	<%
	Place place = (Place)request.getAttribute("place");
	%>
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript">

	$(document).ready(function() {
	    const currentUrl = window.location.href;
	    
	    let userId;
	    
	    $.ajax({
	        url: '/howAbout/review/sessionInfo',
	        type: 'GET',
	        success: function(memberData) {
	            userId = memberData.userId;
	        },
	        error: function(xhr, status, error) {
	            console.error('Member 정보 로드에 실패했습니다.', error);
	        }
	    });
	    
	    $.ajax({
	        url: '/howAbout/review/all', // 리뷰 데이터를 가져올 API 엔드포인트
	        method: 'GET',
	        data: { "url" : currentUrl },
	        success: function(data) {
	        	console.log(data);
				displayReviews(data);
	        },
	        error: function(xhr, status, error) {
	            console.error('리뷰 데이터를 가져오는 데 실패했습니다:', error);
	        }
	    });
	
	    function displayReviews(reviews) {
	        const container = $('#review-container');
	        container.empty();
	        
	        if (reviews.length === 0) {
                container.append('<p>작성된 리뷰가 없습니다.</p>');
                return;
            }

	        reviews.forEach(function(review) {
	            const reviewElement = $('<div class="review"></div>');
	            reviewElement.append('<p> <img width="100px" height="100px" src="/howAbout/resources/userIcon/'+review.iconName+'"/>' + review.reviewDate + '</p>');
	            reviewElement.append('<p>' + review.reviewText + '</p>');
	            reviewElement.append('<p> <a href="/howAbout/review/'+ review.userId +'/selectAll"> 작성자:'+ review.userId +'</a></p>');
	            
	            if(review.userId == userId){
	            	reviewElement.append('<a href="#" class="editReview" data-id="'+review.millisId+'" data-text="'+review.reviewText+'">수정</a> | ');
	            	reviewElement.append('<a href="/howAbout/review/delete/'+review.millisId+'" class="deleteReview">삭제</a>');
	            }
	            
	            container.append(reviewElement);
	        });
	    }
	    
	    let currentReviewId; // 현재 수정 중인 리뷰 ID

	    $(document).on('click', '.editReview', function(e) {
	        e.preventDefault();
	        currentReviewId = $(this).data('id'); // 수정할 리뷰 ID 저장
	        const reviewText = $(this).data('text'); // 현재 리뷰 텍스트 가져오기
	        $('#editReviewText').val(reviewText); // 텍스트 박스에 현재 리뷰 텍스트 설정
	        $('#editReviewModal').show();
	    });

	    
	    $('.close').click(function() {
	        $('#editReviewModal').hide();
	    });

	    // 리뷰 수정 저장
	    $('#saveChanges').click(function() {
	        const updatedText = $('#editReviewText').val(); // 수정된 텍스트 가져오기

	        $.ajax({
	            url: '/howAbout/review/update/' + currentReviewId,
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({ "reviewText" : updatedText }),
	            success: function(response) {
	                $('#editReviewModal').hide(); // 모달 닫기
	                // 리뷰 목록을 새로고침
	                $.ajax({
	                    url: '/howAbout/review/all',
	                    method: 'GET',
	                    data: { "url": currentUrl },
	                    success: function(data) {
	                        displayReviews(data);
	                    }
	                });
	            },
	            error: function(xhr, status, error) {
	                console.error('리뷰 수정에 실패했습니다:', error);
	            }
	        });
	    });
	    
	    $(document).on('click', '.deleteReview', function(e) {
	        e.preventDefault();
	        const reviewId = $(this).attr('href').split('/').pop();
	        // 삭제할 리뷰 ID 가져오기

	        if (confirm("이 리뷰를 정말 삭제하시겠습니까?")) {
	            $.ajax({
	                url: '/howAbout/review/delete/' + reviewId,
	                type: 'POST',
	                success: function(response) {
	                    $.ajax({
	                        url: '/howAbout/review/all',
	                        method: 'GET',
	                        data: { "url": currentUrl },
	                        success: function(data) {
	                            displayReviews(data);
	                        }
	                    });
	                },
	                error: function(xhr, status, error) {
	                    console.error('리뷰 삭제에 실패했습니다:', error);
	                }
	            });
	        }
	    });

	});
</script>
<style>

	#map {
		width: 800px;
		height: 400px;
	}
	
	body {
    font-family: Arial, sans-serif;
}

	.modal {
	    display: none;
	    position: fixed; 
	    z-index: 1; 
	    left: 0;
	    top: 0;
	    width: 100%; 
	    height: 100%; 
	    overflow: auto; 
	    background-color: rgb(0,0,0); 
	    background-color: rgba(0,0,0,0.4); 
	}
	
	.modal-content {
	    position: relative;
	    margin: 5% auto; 
	    padding: 20px;
	    border: 1px solid #888;
	    width: 60%; 
	    background-color: white;
	}
	
	.close {
	    color: #aaa;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
	
	.close:hover,
	.close:focus {
	    color: black;
	    text-decoration: none;
	    cursor: pointer;
	}
	
	iframe {
	    width: 100%;
	    height: 700px;
	}
	
</style>
</head>
<body>

	<h1><%= place.getPlaceName() %></h1>
	<p><%= place.getAddressName() %></p>
	<p><%= place.getCategoryAll() %></p>
    <div id="map"></div>
    <a href="#" id="openModal">카카오 정보 페이지 보기</a>
    <hr>
	<div id="review-container"></div>
	<hr>
<%
	HttpSession session = request.getSession(false);
	
	if(session != null){
		Member member = (Member)session.getAttribute("userStatus");
		
		if(member != null){
			
%>
			<form id="review-form" method="post">
				<input type="text" name="reviewText" id="reviewText"> <button type="button" id="submitButton">작성</button>
			</form>
<%
		}
	} else {
%>
		--로그인 후 작성이 가능합니다--
<%	
	}
%>
	
		
	
    <!-- 모달 구조 -->
    <div id="myModal" class="modal">
        <div class="modal-content">
            <span class="close">&times;</span>
            <iframe id="modalIframe" src="" frameborder="0"></iframe>
        </div>
    </div>
    
    <!-- 리뷰모달 -->
	<div id="editReviewModal" class="modal">
	    <div class="modal-content">
	        <span class="close">&times;</span>
	        <h2>리뷰 수정</h2>
	        <textarea id="editReviewText" rows="4" cols="50"></textarea>
	        <button id="saveChanges">저장</button>
	    </div>
	</div>
    
<script type="text/javascript">
	var placeName = '<%= place.getPlaceName() %>';
	var targetId = '<%= place.getPlaceID() %>';
	var x = "<%= place.getLongitude() %>";
	var y = "<%= place.getLatitude() %>";
    var kakaoInfoUrl = "<%= place.getPlaceUrl() %>";
    var placeCategory = "<%= place.getCategory() %>";
</script>

<script src="/howAbout/resources/js/onePlace.js"> </script>
<script type="text/javascript">

	$(document).ready(function() {
	    $('#submitButton').on('click', function() {
	        const reviewText = $('#reviewText').val();
	
	        $.ajax({
	            url: '/howAbout/review/addReview',
	            type: 'POST',
	            contentType: 'application/json',
	            data: JSON.stringify({
	                "reviewText": reviewText,
	                "placeID": targetId // targetId는 정의되어 있어야 함
	            }),
	            success: function(response) {
	                alert('리뷰가 성공적으로 작성되었습니다.');
	                location.reload(); // 페이지 리로드
	            },
	            error: function(xhr, status, error) {
	                alert('리뷰 작성에 실패했습니다.');
	            }
	        });
	    });

	});
	
</script>
</body>
</html>