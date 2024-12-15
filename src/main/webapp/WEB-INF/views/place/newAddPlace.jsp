<%@page import="com.springproject.domain.Member"%>
<%@page import="com.springproject.domain.Place"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries&libraries=services"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>

	<%
		String update = (String)request.getAttribute("update");
		Place place = (Place)request.getAttribute("oldPlace");
		HttpSession session = request.getSession(false);
		Member member = null;
		
		if(session != null){
			member = (Member)session.getAttribute("userStatus");
			if(member != null){
				if(member.getUserId().equals("admin")){
					if(update == null){
	%>

						<p>관리자 시설 등록 페이지</p>
						<form:form id="placeForm" modelAttribute="place" method="post">
							상호명 : <form:input id="placeName" path="placeName"/> <br>
							주소 : <form:input id="address" path="addressName"/> <br>
							도로명주소 : <form:input class="readonly-input" id="roadAddress" path="roadAddress" /> <br>
							대분류 : <form:input class="readonly-input"  id="category" path="category"/> <br>
							세분류 : <form:input class="readonly-input"  id="categoryAll" path="categoryAll"/> <br>
							전화번호 : <form:input class="readonly-input"  id="phone" path="phone"/> <br>
							정보페이지 : <form:input class="readonly-input"  id="placeUrl" path="placeUrl"/> <br>
							시설ID : <form:input class="readonly-input"  id="placeID" path="placeID"/> <br>
							경도 : <form:input class="readonly-input"  id="longitude" path="longitude"/> <br>
							위도 : <form:input class="readonly-input"  id="latitude" path="latitude"/> <br>
							<button type="button" id="placeSerch" >정보조회</button> <br>
							<button type="button" id="savePlace">저장</button>
						</form:form>
						
						<div id="map" style="width: 100%; height: 400px;"></div>
						<div id="result"></div> <!-- 검색 결과를 표시할 요소 -->
						
						<script type="text/javascript" src="/howAbout/resources/js/addPlace.js"></script>
						<script type="text/javascript">
							var saveBtn = document.querySelector("#savePlace");
							saveBtn.addEventListener("click", savePlace);
						</script>
						
						<%
							} else if(update.equals("update")){
								
								session.setAttribute("oldPlaceID", place.getPlaceID());
						%>
						
						<p>관리자 시설 수정 페이지</p>
						<form:form id="placeForm" modelAttribute="place" method="post">
							상호명 : <form:input id="placeName" path="placeName" value="<%= place.getPlaceName() %>"/> <br>
							주소 : <form:input id="address" path="addressName" value="<%= place.getAddressName() %>"/> <br>
							도로명주소 : <form:input id="roadAddress" path="roadAddress" value="<%= place.getRoadAddress() %>"/> <br>
							대분류 : <form:input id="category" path="category" value="<%= place.getCategory() %>"/> <br>
							세분류 : <form:input id="categoryAll" path="categoryAll" value="<%= place.getCategoryAll() %>"/> <br>
							전화번호 : <form:input id="phone" path="phone" value="<%= place.getPhone() %>"/> <br>
							정보페이지 : <form:input id="placeUrl" path="placeUrl" value="<%= place.getPlaceUrl() %>"/> <br>
							시설ID : <form:input class="readonly-updateinput" id="placeID" path="placeID" value="<%= place.getPlaceID() %>"/> <br>
							경도 : <form:input class="readonly-updateinput" id="longitude" path="longitude" value="<%= place.getLongitude() %>"/> <br>
							위도 : <form:input class="readonly-updateinput" id="latitude" path="latitude" value="<%= place.getLatitude() %>"/> <br>
							<button type="button" id="placeSerch" >정보조회</button> <br>
							<button type="button" id="saveOldPlace">저장</button>
						</form:form>
						
						<div id="map" style="width: 100%; height: 400px;"></div>
						<div id="result"></div> <!-- 검색 결과를 표시할 요소 -->
						
						<script type="text/javascript" src="/howAbout/resources/js/addPlace.js"></script>
						<script type="text/javascript">
							var updateBtn = document.querySelector("#saveOldPlace");
							updateBtn.addEventListener("click", updatePlace);
						</script>
						
	<%	
						}
					
				} else { request.setAttribute("error_msg", "관리자 권한이 필요합니다."); }
			} else { request.setAttribute("error_msg", "세션이 만료되었습니다, 다시 로그인하여 주시길 바랍니다."); }
		} else { request.setAttribute("error_msg", "잘못된 접근입니다."); }
	
		String error = (String)request.getAttribute("error_msg");
		
		if(error != null){
	%>
			<p> <%= error %> </p>
	<%
		}
	%>

</body>
</html>