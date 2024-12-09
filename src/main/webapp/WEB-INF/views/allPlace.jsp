<%@page import="com.springproject.domain.Member"%>
<%@page import="com.springproject.domain.Place"%>
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
	
		List<Place> list = (List<Place>)request.getAttribute("place_list");
		String category = (String)request.getAttribute("category");
		String pageNum = (String)request.getAttribute("pageNum");
		
		int Count = (int)request.getAttribute("Count");
		int totalPage = (int) Math.ceil((double) Count / 50);
		
	%>
		<form action="/howAbout/place/allPlace/category/1" method="get">
			<select id="citySelect" name="city" required>
			    <option value="" disabled selected>선택하세요</option>
			    <option value="창원시">창원시</option>
			    <option value="김해시">김해시</option>
			    <option value="진주시">진주시</option>
			    <option value="양산시">양산시</option>
			    <option value="거제시">거제시</option>
			    <option value="통영시">통영시</option>
			    <option value="사천시">사천시</option>
			    <option value="밀양시">밀양시</option>
			    <option value="함안군">함안군</option>
			    <option value="거창군">거창군</option>
			    <option value="창녕군">창녕군</option>
			    <option value="고성군">고성군</option>
			    <option value="하동군">하동군</option>
			    <option value="합천군">합천군</option>
			    <option value="남해군">남해군</option>
			    <option value="함양군">함양군</option>
			    <option value="산청군">산청군</option>
			    <option value="의령군">의령군</option>
			</select>
			<select id="bigGory" name="big" onchange="updateSubCategory()">
			    <option value="" disabled selected>카테고리를 선택하세요</option>
			    <option value="hotel">숙박시설</option>
				<option value="food">음식점</option>
			</select>
			<select id="subCategory1" name="sub" style="display: none;">
			    <option value="" disabled selected>세부 카테고리</option>
			    <option value="0100_0700">호텔/모텔</option>
			    <option value="0200_0600">캠핑(야영장)</option>
			    <option value="0400">한옥체험</option>
			    <option value="0500">펜션</option>
			    <option value="0300_0800">민박/게스트하우스</option>
			</select>
			<select id="subCategory2" name="sub" style="display: none;" onchange="updateSubCategory()">
			    <option value="" disabled selected>세부 카테고리</option>
			    <option value="1100_1400">식당</option>
			    <option value="1200">휴게소</option>
			</select>
			<select id="foodCategory" name="foodsub" style="display: none;">
			    <option value="" disabled selected>세부 카테고리</option>
			    <option value="3500">모범음식점</option>
			    <option value="3900">음식점</option>
			    <option value="4000">한식</option>
			    <option value="4400">일식</option>
			    <option value="4450">수산물</option>
			    <option value="4500">중국식</option>
			    <option value="4600">이국식당</option>
			    <option value="4700">분식</option>
			    <option value="4800">패스트푸드</option>
			    <option value="4100">주점</option>
			    <option value="4200">카페</option>
			    <option value="4300">뷔페</option>
			</select>
			<input type="submit" value="검색">
		</form>
		
		<table>
			<tr>
				<th>도로명 주소</th>
				<th>지번 주소</th>
				<th>업종</th>
				<th>상호명</th>
				<th>분류</th>
				<th>수정 및 삭제</th>
			</tr>
	<%
		for(int i=0; i<list.size(); i++){
			Place place = list.get(i);
	%>
			<tr>
				<td> <%=place.getJuso() %> </td>
				<td> <%=place.getJibun() %> </td>
				<td> <%=place.getCategory() %> </td>
				<td> <%=place.getTitle() %> </td>
				<td> <%=place.getFoodCategory() %> </td>
	<%
				if(session != null){
					member = (Member)session.getAttribute("userStatus");
					if(member != null){
	%>
				<td> <a href="/howAbout/place/update/<%=place.getUpdateNum()%>">수정</a> | <a href="/howAbout/place/delete/<%=place.getUpdateNum()%>">삭제</a></td>
	<%
					}
				}
	%>
			</tr>
	<%
		}
	%>	
		</table>
	<%
		int itemsPerPage = 10; // 페이지당 항목 수
		int nowPage = Integer.parseInt(pageNum);
	    int allPage = (int) Math.ceil((double) Count / 20); // 전체 페이지 수 계산
	
	    // 시작 페이지와 끝 페이지 계산
	    int startPage = ((nowPage - 1) / itemsPerPage) * itemsPerPage + 1; // 그룹의 시작 페이지
	    int endPage = startPage + itemsPerPage - 1; // 그룹의 끝 페이지
	
	    // 끝 페이지 조정
	    if (endPage > allPage) {
	        endPage = allPage; // 전체 페이지 수를 초과하지 않도록 조정
	    }
	    
	    if(category.equals("all")){
	    	
	    	if(endPage>1){
	 %>
			<a href="/howAbout/place/allPlace/<%=category%>/<%=nowPage-1%>"> [ ◀ ]</a>
	 <%
	    	}
	    	
	    	for(int i=startPage; i<=endPage; i++){
	%>
			<a href="/howAbout/place/allPlace/<%=category%>/<%=i%>"> [ <%= i %> ]</a>
	<%
	    	
	    }
	    	if(allPage!=nowPage){
	%>
			<a href="/howAbout/place/allPlace/<%=category%>/<%=nowPage+1%>"> [ ▶ ]</a>
	<%
	    }

	 } else if(category.equals("category")){
		 
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
    function updateSubCategory() {
        const bigGory = document.getElementById('bigGory');
        const subCategory1 = document.getElementById('subCategory1');
        const subCategory2 = document.getElementById('subCategory2');
        const foodCategory = document.getElementById('foodCategory');

        // 선택된 값에 따라 서브 카테고리 표시
        if (bigGory.value === 'hotel') {
            subCategory1.style.display = 'block'; // 서브 카테고리 표시
        } else {
            subCategory1.style.display = 'none'; // 서브 카테고리 숨김
            subCategory1.selectedIndex = 0;
        }
        
        if (bigGory.value === 'food') {
            subCategory2.style.display = 'block'; // 서브 카테고리 표시
        } else {
            subCategory2.style.display = 'none'; // 서브 카테고리 숨김
            subCategory2.selectedIndex = 0;
        }
        
        if(subCategory2.value === '1100_1400'){
        	foodCategory.style.display = 'block';
        } else {
        	foodCategory.style.display = 'none'; // 서브 카테고리 숨김
        	foodCategory.selectedIndex = 0;
        }
    }
</script>
</html>