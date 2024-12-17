<%@page import="com.springproject.domain.Place"%>
<%@page import="com.springproject.domain.Member"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page session="false"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
	HttpSession session = request.getSession(false);
			Member member = null;
			
			String select = (String)request.getAttribute("select");
			List<Place> list = (List<Place>)request.getAttribute("place_list");
	%>
	
		<form action="/howAbout/place/serchPlaceAll/select/1" method="get">
			<select id="citySelect" name="city" required>
			    <option value="" disabled selected>선택하세요</option>
			    <option value="1001">창원시</option>
			    <option value="1002">김해시</option>
			    <option value="1003">진주시</option>
			    <option value="1004">양산시</option>
			    <option value="1005">거제시</option>
			    <option value="1006">통영시</option>
			    <option value="1007">사천시</option>
			    <option value="1008">밀양시</option>
			    <option value="1009">함안군</option>
			    <option value="1010">거창군</option>
			    <option value="1011">창녕군</option>
			    <option value="1012">고성군</option>
			    <option value="1013">하동군</option>
			    <option value="1014">합천군</option>
			    <option value="1015">남해군</option>
			    <option value="1016">함양군</option>
			    <option value="1017">산청군</option>
			    <option value="1018">의령군</option>
			</select>
			<select id="categorySelect" name="category" onchange="updateCategory()">
			    <option value="" disabled selected>카테고리를 선택하세요</option>
			    <option value="101">음식점</option>
				<option value="102">카페</option>
			</select>
			<select id="subCategoryFood" name="sub" style="display: none;">
			    <option value="" disabled selected>세부 카테고리</option>
			    <option value="100">한식</option>
			    <option value="200">중식</option>
			    <option value="300">일식</option>
			    <option value="400">양식</option>
			    <option value="500">동남아</option>
			    <option value="600">치킨</option>
			    <option value="700">분식</option>
			    <option value="800">술집</option>
			    <option value="900">뷔페</option>
			</select>
			<input type="submit" value="검색">
			<button id="searchButton">검색</button>
		</form>
		
		<table>
			<tr>
				<td>상호명</td>
				<td>분류</td>
				<td>지번주소</td>
				<td>위시리스트</td>
				<td>수정</td>
				<td>삭제</td>
			</tr>
			
	<%
				for(int i=0; i<list.size(); i++){
					Place place = list.get(i);
				%>
			<tr>
				<td> <a href="/howAbout/place/newGetOne/placeID/<%=place.getPlaceID()%>"> <%=place.getPlaceName() %> </a> </td>
				<td> <%=place.getCategory() %> </td>
				<td> <%=place.getAddressName() %> </td>
				<td> <button id="wishList" type="button" onclick="myPlaceAdd('<%= place.getPlaceID()%>')">내 여행지에 담기</button> </td>
	<%
				if(session != null){
					member = (Member)session.getAttribute("userStatus");
					if(member != null){
						
						if(member.getUserId().equals("admin")){
	%>
				<td> <a href="/howAbout/place/placeUpdate/<%=place.getPlaceID()%>">수정</a></td>
				<td> <a href="/howAbout/place/placeDelete/<%=place.getPlaceID()%>">삭제</a> </td>
	<%
						}
					}
				}
	%>
			</tr>
	<%
		}
	%>
		</table>
		
	<%
	
		String pageNum = (String)request.getAttribute("pageNum");
		int Count = (int)request.getAttribute("Count");
		int allPage = (int) Math.ceil((double) Count / 20);
		
		int itemsPerPage = 10; // 페이지당 항목 수
		int nowPage = Integer.parseInt(pageNum);
	     // 전체 페이지 수 계산
	
	    // 시작 페이지와 끝 페이지 계산
	    int startPage = ((nowPage - 1) / itemsPerPage) * itemsPerPage + 1; // 그룹의 시작 페이지
	    int endPage = startPage + itemsPerPage - 1; // 그룹의 끝 페이지
	
	    // 끝 페이지 조정
	    if (endPage > allPage) {
	        endPage = allPage; // 전체 페이지 수를 초과하지 않도록 조정
	    }
	    
	    if(select.equals("all")){
	    	
	    	if(endPage>1){
	 %>
			<a href="/howAbout/place/serchPlaceAll/all/<%=nowPage-1%>"> [ ◀ ]</a>
	 <%
	    	}
	    	
	    	for(int i=startPage; i<=endPage; i++){
	%>
			<a href="/howAbout/place/serchPlaceAll/all/<%=i%>"> [ <%= i %> ]</a>
	<%
	    	
	    }
	    	if(allPage!=nowPage){
	%>
			<a href="/howAbout/place/serchPlaceAll/all/<%=nowPage+1%>"> [ ▶ ]</a>
	<%
	    }

	 } else if(select.equals("select")){
		 
		 String addr1 = (String)request.getAttribute("serchAddr1");
		 String addr2 = (String)request.getAttribute("serchAddr2");
	    	
	    	if(endPage>15){
	 %>
			<a href="<%=addr1%><%=nowPage-1%><%=addr2%>"> [ ◀ ]</a>
	 <%
	    	}
	    	
	    	for(int i=startPage; i<=endPage; i++){
	%>
			<a href="<%=addr1%><%=i%><%=addr2%>"> [ <%= i %> ]</a>
	<%
	    	
	    }
	    	if(allPage!=nowPage){
	%>
			<a href="<%=addr1%><%=nowPage+1%><%=addr2%>"> [ ▶ ]</a>
	<%
	    }
	 }
	%>
</body>

<script>
	
	function updateCategory() {
	    const categorySelect = document.getElementById('categorySelect');
	    const subCategoryFood = document.getElementById('subCategoryFood');
	
	    // 선택된 값에 따라 서브 카테고리 표시
	    if (categorySelect.value === '101') {
	    	subCategoryFood.style.display = 'block'; // 서브 카테고리 표시
	    } else {
	    	subCategoryFood.style.display = 'none'; // 서브 카테고리 숨김
	    	subCategoryFood.selectedIndex = 0;
	    }
	}
	
	function myPlaceAdd(placeID){
		
		$.ajax({
			url : "/howAbout/course/myPlace/",
			type : "POST",
			data : JSON.stringify({ "placeID" : placeID }),
			contentType: 'application/json',
			success : function(data){
				
				if(data.status){
					alert("추가가 완료되었습니다.");
				} else {
					alert("이미 추가된 시설 입니다.");
				}
		},
			error : function(errorThrown){ alert("처리에 실패했습니다."); }
		})

	}
</script>
</html>