<%@page import="com.springproject.domain.deleteplace"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!--
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
</head>
<body>
	<%
	String update = (String)request.getAttribute("update");
			deleteplace place = null;
			
			if(update == null){
	%>

	<p>관리자 시설 등록 페이지</p>
	<form:form id="placeForm" modelAttribute="place" method="post">
		도로명주소 : <form:input id="juso" path="juso" /> <button type="button" id="placeSerch1" >위도/경도 조회</button> <br>
		지번주소 : <form:input id="jibun" path="jibun" /> <button type="button" id="placeSerch2" >위도/경도 조회</button> <br>
		 업태구분 :<form:select path="category">
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
					java.lang.Object value = (java.lang.Object) pageContext.getAttribute("value");</form:option>
				</form:select>
		
		사업장명 : <form:input id="title" path="title" /><br>
		영업상태 : <form:input path="status" value="영업/정상"/><br>
		음식점 구분 : <form:input path="foodCategory" placeholder="업태가 음식점인 곳만 작성해주세요" /><br>
		위도(X) : <form:input id="latitude" path="latitude"/>
		경도(Y) : <form:input id="longitude" path="longitude"/><br>
		<button type="button" id="savePlace">저장</button>
	</form:form>
	<%
	} else if(update.equals("ok")){
		place = (deleteplace)request.getAttribute("place");
	%>
		<p>관리자 시설 변경 페이지</p>
		<form:form id="placeForm" modelAttribute="place" method="post">
			도로명주소 : <form:input value="<%= place.getJuso() %>" id="juso" path="juso" /> <button type="button" id="placeSerch1" >위도/경도 조회</button><br>
			지번주소 : <form:input value="<%= place.getJibun() %>" id="jibun" path="jibun" /> <button type="button" id="placeSerch2" >위도/경도 조회</button><br>
			업태구분 :<form:select id="category" path="category">
						<form:option value="숙박업"></form:option>
						<form:option value="일반야영장업"></form:option>
						<form:option value="외국인관광도시민박업"></form:option>
						<form:option value="한옥체험업"></form:option>
						<form:option value="관광펜션업"></form:option>
						<form:option value="자동차야영장업"></form:option>
						<form:option value="관광숙박업"></form:option>
						<form:option value="농어촌민박업"></form:option>
						<form:option value="모범음식점"></form:option>
						<form:option value="일반음식점"></form:option>
						<form:option value="휴게음식점"></form:option>
						<form:option value="외국인전용유흥음식점업"></form:option>
						<form:option value="관광식당"></form:option>
					</form:select>
			사업장명 : <form:input value="<%= place.getTitle() %>" id="title" path="title" /><br>
			영업상태 : <form:input id="status" path="status" value="<%= place.getStatus() %>"/><br>
			음식점 구분 : <form:input id="foodCategory" value="<%= place.getFoodCategory() %>" path="foodCategory" placeholder="업태가 음식점인 곳만 작성해주세요" /><br>
			위도(X) : <form:input value="<%= place.getLatitude() %>" id="latitude" path="latitude"/>
			경도(Y) : <form:input value="<%= place.getLongitude() %>" id="longitude" path="longitude"/><br>
			<button type="button" id="updatePlace">수정</button>
		</form:form>
		
			<script>
				    
				    window.onload = function() {
				        var selectedCategory = "<%= place.getCategory() %>";
				        var selectElement = document.getElementById("category");
				        
				        
				        if (selectedCategory) {
				            selectElement.value = selectedCategory;
				        }
			    	};
			    	
			    	var updateBtn = document.querySelector("#updatePlace");
			    	updateBtn.addEventListener("click",updateP);
			    	
					function updateP() {
						
						console.log("업데이트 된 장소 검색중...");
						var juso = document.querySelector("#juso").value;
						var jibun = document.querySelector("#jibun").value;
						var title = document.querySelector("#title").value;
						var latitude = document.querySelector("#latitude").value;
						var longitude = document.querySelector("#longitude").value;
						var category = document.querySelector("#category").value;
						var status = document.querySelector("#status").value;
						var foodCategory = document.querySelector("#foodCategory").value;
						var updateNum = "<%= place.getUpdateNum() %>";
						
						
						$.ajax({
							url : "/howAbout/place/placeAPIserch",
							type : "POST",
							data : JSON.stringify({"juso" : juso, "jibun" : jibun, "title" : title, "latitude" : latitude, "longitude" : longitude, "update" : "ok", "updateNum" : updateNum, "category" : category, "status" : status, "foodCategory" : foodCategory}),
							contentType: 'application/json',
							success : function(data){
								
								if(data.status){
									if(confirm("수정하시겠습니까?")==true){
										document.getElementById('placeForm').submit();
									} else { return false; }
								} else {
									
									if('error01' in data){
										if(data.error01){
											alert("변경 사항이 없습니다. 다시 확인해주세요.");
										}
									}
									
									if('error02' in data){
										if(data.error02){
											alert("위도 경도를 다시 확인해주세요. 직접 입력하지 마시고 조회 버튼으로 기입해주시길 바랍니다.");
										}
									}
									
									if('error03' in data){
										if(data.error03){
											alert("해당 주소지에 같은 상호명이 존재합니다.");
										}
									}
									
									alert("업데이트에 실패했습니다.");
								}
						},
							error : function(errorThrown){ alert("처리에 실패했습니다.."); }
						})
						
					}
			    	
			</script>
	
	<%
		}
	%>
	

	
	
	
	<script type="text/javascript">
		
		var serchBtn1 = document.querySelector("#placeSerch1");
		var serchBtn2 = document.querySelector("#placeSerch2");
		var saveBtn = document.querySelector("#savePlace");
		
		
		serchBtn1.addEventListener("click",serch1);
		serchBtn2.addEventListener("click",serch2);
		saveBtn.addEventListener("click",saveP);
		

			function serch1() {
				console.log("주소1 검색 시동중...");
				var addr = document.querySelector("#juso").value;
				
				$.ajax({
					url : "/howAbout/place/addAPIserch",
					type : "POST",
					data : JSON.stringify({juso : addr}),
					contentType: 'application/json',
					success : function(data){
						document.querySelector("#jibun").value = data.jibun;
						document.querySelector("#latitude").value = data.latitude;
						document.querySelector("#longitude").value = data.longitude;
				},
					error : function(errorThrown){ alert("해당 주소에 해당하는 시설이 없습니다."); }
				})
				
			}
			
			function serch2() {
				console.log("주소2 검색 시동중...");
				var addr = document.querySelector("#jibun").value;
				
				$.ajax({
					url : "/howAbout/place/addAPIserch",
					type : "POST",
					data : JSON.stringify({jibun : addr}),
					contentType: 'application/json',
					success : function(data){
						document.querySelector("#juso").value = data.juso;
						document.querySelector("#latitude").value = data.latitude;
						document.querySelector("#longitude").value = data.longitude;
				},
					error : function(errorThrown){ alert("해당 주소에 해당하는 시설이 없습니다."); }
				})
				
			}
			
			function saveP() {
				
				console.log("장소 검색중...");
				var juso = document.querySelector("#juso").value;
				var jibun = document.querySelector("#jibun").value;
				var title = document.querySelector("#title").value;
				var latitude = document.querySelector("#latitude").value;
				var longitude = document.querySelector("#longitude").value;
				
				$.ajax({
					url : "/howAbout/place/placeAPIserch",
					type : "POST",
					data : JSON.stringify({"juso" : juso, "jibun" : jibun, "title" : title, "latitude" : latitude, "longitude" : longitude, "update" : "no"}),
					contentType: 'application/json',
					success : function(data){
						
						if(data.status){
							if(confirm("등록하시겠습니까?")==true){
								document.getElementById('placeForm').submit();
							} else { return false; }
						} else {
							alert("이미 등록된 주소지 입니다.");
						}
				},
					error : function(errorThrown){ alert("처리에 실패했습니다.."); }
				})
				
			}	

	</script>
</body>
</html>
 -->