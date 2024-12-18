<%@page import="java.util.ArrayList"%>
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
<script type="text/javascript" src="https://dapi.kakao.com/v2/maps/sdk.js?appkey=8ba5137fb1c2b1e37ac6722ae8d8e587&libraries=services"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
</head>
<body>
		<form id="searchForm">
			<select id="citySelect" name="city" required onchange="updatesubCity()">
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
			<!-- 창원시 -->
			<select class="subCity" id="창원시" name="subCity" required style="display: none;" onchange="updateSubSelect(this.value)">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="의창구">의창구</option>
			    <option value="성산구">성산구</option>
			    <option value="마산합포구">마산합포구</option>
			    <option value="마산회원구">마산회원구</option>
			    <option value="진해구">진해구</option>
			</select>
				<!-- 의창구 -->
				<select id="100101subSelect" name="country" required style="display: none;">
				    <option value="" disabled selected>선택하세요</option>
				    <option value="동읍">동읍</option>
				    <option value="북면">북면</option>
				    <option value="대산면">대산면</option>
				    <option value="의창동">의창동</option>
				    <option value="팔룡동">팔룡동</option>
				    <option value="명곡동">명곡동</option>
				    <option value="봉림동">봉림동</option>
				</select>
				<!-- 성산구 -->
				<select id="100102subSelect" name="country" required style="display: none;">
				    <option value="" disabled selected>선택하세요</option>
				    <option value="귀산동">귀산동</option>
				    <option value="반송동">반송동</option>
				    <option value="용지동">용지동</option>
				    <option value="중앙동">중앙동</option>
				    <option value="상남동">상남동</option>
				    <option value="사파동">사파동</option>
				    <option value="가음정동">가음정동</option>
				    <option value="성주동">성주동</option>
				    <option value="웅남동">웅남동</option>
				</select>
				<!-- 마산합포구 -->
				<select id="100103subSelect" name="country" required style="display: none;">
				    <option value="" disabled selected>선택하세요</option>
				    <option value="구산면">구산면</option>
				    <option value="진동면">진동면</option>
				    <option value="진북면">진북면</option>
				    <option value="진전면">진전면</option>
				    <option value="현동">현동</option>
				    <option value="가포동">가포동</option>
				    <option value="월영동">월영동</option>
				    <option value="문화동">문화동</option>
				    <option value="반월중앙동">반월중앙동</option>
				    <option value="완월동">완월동</option>
				    <option value="자산동">자산동</option>
				    <option value="교방동">교방동</option>
				    <option value="오동동">오동동</option>
				    <option value="합포동">합포동</option>
				    <option value="산호동">산호동</option>
				</select>
				<!-- 마산회원구 -->
				<select id="100104subSelect" name="country" required style="display: none;">
				    <option value="" disabled selected>선택하세요</option>
				    <option value="내서읍">내서읍</option>
				    <option value="회원1동">회원1동</option>
				    <option value="회원2동">회원2동</option>
				    <option value="석전동">석전동</option>
				    <option value="회성동">회성동</option>
				    <option value="양덕1동">양덕1동</option>
				    <option value="양덕2동">양덕2동</option>
				    <option value="합성1동">합성동</option>
				    <option value="합성2동">합성동</option>
				    <option value="구암1동">구암동</option>
				    <option value="구암2동">구암동</option>
				    <option value="봉암동">봉암동</option>
				</select>
				<!-- 진해구 -->
				<select id="100105subSelect" name="country" required style="display: none;">
				    <option value="" disabled selected>선택하세요</option>
				    <option value="충무동">충무동</option>
				    <option value="여좌동">여좌동</option>
				    <option value="태백동">태백동</option>
				    <option value="경화동">경화동</option>
				    <option value="병암동">병암동</option>
				    <option value="석동">석동</option>
				    <option value="이동">이동</option>
				    <option value="자은동">자은동</option>
				    <option value="덕산동">덕산동</option>
				    <option value="풍호동">풍호동</option>
				    <option value="웅천동">웅천동</option>
				    <option value="웅동1동">웅동1동</option>
				    <option value="웅동2동">웅동2동</option>
				</select>
				
			<!-- 김해시 -->
			<select class="subCity" id="김해시" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="진영읍">진영읍</option>
			    <option value="주촌면">주촌면</option>
			    <option value="진례면">진례면</option>
			    <option value="한림면">한림면</option>
			    <option value="생림면">생림면</option>
			    <option value="상동면">상동면</option>
			    <option value="대동면">대동면</option>
			    <option value="동상동">동상동</option>
			    <option value="회현동">회현동</option>
			    <option value="부원동">부원동</option>
			    <option value="내외동">내외동</option>
			    <option value="북부동">북부동</option>
			    <option value="칠산서부동">칠산서부동</option>
			    <option value="활천동">활천동</option>
			    <option value="삼안동">삼안동</option>
			    <option value="불암동">불암동</option>
			    <option value="장유1동">장유1동</option>
			    <option value="장유2동">장유2동</option>
			    <option value="장유3동">장유3동</option>
			</select>
			
			<!-- 진주시 -->
			<select class="subCity" id="진주시" name="subCity" required style="display: none;" onchange="updateSubSelect(this.value)">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="시내동지구">시내동지구</option>
			    <option value="문산읍">진영읍</option>
			    <option value="내동면">주촌면</option>
			    <option value="정촌면">진례면</option>
			    <option value="금곡면">한림면</option>
			    <option value="진성면">생림면</option>
			    <option value="일반성면">상동면</option>
			    <option value="이반성면">대동면</option>
			    <option value="사봉면">동상동</option>
			    <option value="지수면">회현동</option>
			    <option value="대곡면">부원동</option>
			    <option value="금산면">내외동</option>
			    <option value="집현면">북부동</option>
			    <option value="미천면">칠산서부동</option>
			    <option value="명석면">활천동</option>
			    <option value="대평면">삼안동</option>
			    <option value="수곡면">불암동</option>
			</select>
				<!-- 시내동지구 -->
				<select id="100301subSelect" name="country" required style="display: none;">
				    <option value="" disabled selected>선택하세요</option>
				    <option value="천전동">천전동</option>
				    <option value="성북동">성북동</option>
				    <option value="중앙동">중앙동</option>
				    <option value="상봉동">상봉동</option>
				    <option value="상대동">상대동</option>
				    <option value="하대동">하대동</option>
				    <option value="상평동">상평동</option>
				    <option value="초장동">초장동</option>
				    <option value="평거동">평거동</option>
				    <option value="신안동">신안동</option>
				    <option value="이현동">이현동</option>
				    <option value="판문동">판문동</option>
				    <option value="가호동">가호동</option>
				    <option value="충무공동">충무공동</option>
				</select>
			
			<!-- 양산시 -->
			<select class="subCity" id="양산시" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="물금읍">물금읍</option>
			    <option value="동면">동면</option>
			    <option value="원동면">원동면</option>
			    <option value="상북면">상북면</option>
			    <option value="하북면">하북면</option>
			    <option value="중앙동">중앙동</option>
			    <option value="양주동">양주동</option>
			    <option value="삼성동">삼성동</option>
			    <option value="강서동">강서동</option>
			    <option value="서창동">서창동</option>
			    <option value="소주동">소주동</option>
			    <option value="평산동">평산동</option>
			    <option value="덕계동">덕계동</option>
			</select>
			
			<!-- 거제시 -->
			<select class="subCity" id="거제시" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="일운면">일운면</option>
			    <option value="동부면">동부면</option>
			    <option value="남부면">남부면</option>
			    <option value="거제면">거제면</option>
			    <option value="둔덕면">둔덕면</option>
			    <option value="사등면">사등면</option>
			    <option value="연초면">연초면</option>
			    <option value="하청면">하청면</option>
			    <option value="장목면">장목면</option>
			    <option value="장승포동">장승포동</option>
			    <option value="능포동">능포동</option>
			    <option value="아주동">아주동</option>
			    <option value="옥포1동">옥포1동</option>
			    <option value="옥포2동">옥포2동</option>
			    <option value="장평동">장평동</option>
			    <option value="고현동">고현동</option>
			    <option value="상문동">상문동</option>
			    <option value="수양동">수양동</option>
			</select>
			
			<!-- 통영시 -->
			<select class="subCity" id="통영시" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="산양읍">산양읍</option>
			    <option value="용남면">용남면</option>
			    <option value="도산면">도산면</option>
			    <option value="광도면">광도면</option>
			    <option value="욕지면">욕지면</option>
			    <option value="한산면">한산면</option>
			    <option value="사량면">사량면</option>
			    <option value="도천동">도천동</option>
			    <option value="명정면">명정면</option>
			    <option value="중앙동">중앙동</option>
			    <option value="정량동">정량동</option>
			    <option value="북신동">북신동</option>
			    <option value="무전동">무전동</option>
			    <option value="미수동">미수동</option>
			    <option value="봉평동">봉평동</option>
			</select>
			
			<!-- 사천시 -->
			<select class="subCity" id="사천시" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="사천읍">사천읍</option>
			    <option value="정동면">정동면</option>
			    <option value="사남면">사남면</option>
			    <option value="용현면">용현면</option>
			    <option value="축동면">축동면</option>
			    <option value="곤양면">곤양면</option>
			    <option value="곤명면">곤명면</option>
			    <option value="서포면">서포면</option>
			    <option value="동서면">동서면</option>
			    <option value="선구동">선구동</option>
			    <option value="동서금동">동서금동</option>
			    <option value="벌용동">벌용동</option>
			    <option value="향촌동">향촌동</option>
			    <option value="남양동">남양동</option>
			</select>
			
			<!-- 밀양시 -->
			<select class="subCity" id="밀양시" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="삼랑진읍">삼랑진읍</option>
			    <option value="하남읍">하남읍</option>
			    <option value="부북면">부북면</option>
			    <option value="상동면">상동면</option>
			    <option value="산외면">산외면</option>
			    <option value="산내면">산내면</option>
			    <option value="단장면">단장면</option>
			    <option value="상남면">상남면</option>
			    <option value="초동면">초동면</option>
			    <option value="무안면">무안면</option>
			    <option value="청도면">청도면</option>
			    <option value="내일동">내일동</option>
			    <option value="내이동">내이동</option>
			    <option value="교동">교동</option>
			    <option value="삼문동">삼문동</option>
			    <option value="가곡동">가곡동</option>
			</select>
			
			<!-- 함안군 -->
			<select class="subCity" id="함안군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="가야읍">가야읍</option>
			    <option value="칠원읍">칠원읍</option>
			    <option value="함안면">함안면</option>
			    <option value="군북면">군북면</option>
			    <option value="법수면">법수면</option>
			    <option value="대산면">대산면</option>
			    <option value="칠서면">칠서면</option>
			    <option value="칠북면">칠북면</option>
			    <option value="산인면">산인면</option>
			    <option value="여향면">여향면</option>
			</select>
			
			<!-- 거창군 -->
			<select class="subCity" id="거창군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="거창읍">거창읍</option>
			    <option value="주상읍">주상읍</option>
			    <option value="웅양면">웅양면</option>
			    <option value="고제면">고제면</option>
			    <option value="북상면">북상면</option>
			    <option value="위천면">위천면</option>
			    <option value="마리면">마리면</option>
			    <option value="남상면">남상면</option>
			    <option value="남하면">남하면</option>
			    <option value="신원면">신원면</option>
			    <option value="가조면">가조면</option>
			    <option value="가북면">가북면</option>
			</select>
			
			<!-- 창녕군 -->
			<select class="subCity" id="창녕군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="창녕읍">창녕읍</option>
			    <option value="남지읍">남지읍</option>
			    <option value="고암면">고암면</option>
			    <option value="성산면">성산면</option>
			    <option value="대합면">대합면</option>
			    <option value="이방면">이방면</option>
			    <option value="유어면">유어면</option>
			    <option value="대지면">대지면</option>
			    <option value="계성면">계성면</option>
			    <option value="영산면">영산면</option>
			    <option value="장마면">장마면</option>
			    <option value="도천면">도천면</option>
			    <option value="길곡면">길곡면</option>
			    <option value="부곡면">부곡면</option>
			</select>
			
			<!-- 고성군 -->
			<select class="subCity" id="고성군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="고성읍">고성읍</option>
			    <option value="삼산면">삼산면</option>
			    <option value="하일면">하일면</option>
			    <option value="하이면">하이면</option>
			    <option value="상리면">상리면</option>
			    <option value="대가면">대가면</option>
			    <option value="영현면">영현면</option>
			    <option value="영오면">영오면</option>
			    <option value="개천면">개천면</option>
			    <option value="구만면">구만면</option>
			    <option value="회화면">회화면</option>
			    <option value="마암면">마암면</option>
			    <option value="동해면">동해면</option>
			    <option value="거류면">거류면</option>
			</select>
			
			<!-- 하동군 -->
			<select class="subCity" id="하동군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="하동읍">하동읍</option>
			    <option value="화개면">화개면</option>
			    <option value="악양면">악양면</option>
			    <option value="적량면">적량면</option>
			    <option value="횡천면">횡천면</option>
			    <option value="고전면">고전면</option>
			    <option value="금남면">금남면</option>
			    <option value="진교면">진교면</option>
			    <option value="양보면">양보면</option>
			    <option value="북천면">북천면</option>
			    <option value="청암면">청암면</option>
			    <option value="옥종면">옥종면</option>
			    <option value="금성면">금성면</option>
			</select>
			
			<!-- 합천군 -->
			<select class="subCity" id="합천군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="합천읍">합천읍</option>
			    <option value="봉산면">봉산면</option>
			    <option value="묘산면">묘산면</option>
			    <option value="가야면">가야면</option>
			    <option value="야로면">야로면</option>
			    <option value="율곡면">율곡면</option>
			    <option value="초계면">초계면</option>
			    <option value="쌍책면">쌍책면</option>
			    <option value="덕곡면">덕곡면</option>
			    <option value="청덕면">청덕면</option>
			    <option value="적중면">적중면</option>
			    <option value="대양면">대양면</option>
			    <option value="쌍백면">쌍백면</option>
			    <option value="삼가면">삼가면</option>
			    <option value="가회면">가회면</option>
			    <option value="대병면">대병면</option>
			    <option value="용주면">용주면</option>
			</select>
			
			<!-- 남해군 -->
			<select class="subCity" id="남해군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="남해읍">남해읍</option>
			    <option value="이동면">이동면</option>
			    <option value="상주면">상주면</option>
			    <option value="상동면">상동면</option>
			    <option value="미조면">미조면</option>
			    <option value="남면">남면</option>
			    <option value="서면">서면</option>
			    <option value="고현면">고현면</option>
			    <option value="설천면">설천면</option>
			    <option value="창선면">창선면</option>
			</select>
			
			<!-- 함양군 -->
			<select class="subCity" id="함양군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="함양읍">함양읍</option>
			    <option value="마천면">마천면</option>
			    <option value="휴천면">휴천면</option>
			    <option value="유림면">유림면</option>
			    <option value="수동면">수동면</option>
			    <option value="지곡면">지곡면</option>
			    <option value="안의면">안의면</option>
			    <option value="서하면">서하면</option>
			    <option value="서하면">서하면</option>
			    <option value="서상면">서상면</option>
			    <option value="백전면">백전면</option>
			    <option value="병곡면">병곡면</option>
			</select>
			
			<!-- 산청군 -->
			<select class="subCity" id="산청군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="산청읍">함양읍</option>
			    <option value="차황면">마천면</option>
			    <option value="오부면">휴천면</option>
			    <option value="생초면">유림면</option>
			    <option value="금서면">수동면</option>
			    <option value="삼장면">지곡면</option>
			    <option value="시천면">안의면</option>
			    <option value="단성면">서하면</option>
			    <option value="신안면">서하면</option>
			    <option value="생비량면">서상면</option>
			    <option value="신등면">백전면</option>
			</select>
			
			<!-- 의령군 -->
			<select class="subCity" id="의령군" name="subCity" required style="display: none;">
			    <option value="" disabled selected>선택하세요</option>
			    <option value="의령읍">의령읍</option>
			    <option value="가례면">가례면</option>
			    <option value="칠곡면">칠곡면</option>
			    <option value="대의면">대의면</option>
			    <option value="화정면">화정면</option>
			    <option value="용덕면">용덕면</option>
			    <option value="정곡면">정곡면</option>
			    <option value="지정면">지정면</option>
			    <option value="낙서면">낙서면</option>
			    <option value="부림면">부림면</option>
			    <option value="봉수면">봉수면</option>
			    <option value="궁류면">궁류면</option>
			    <option value="유곡면">유곡면</option>
			</select>

			<select id="categorySelect" name="category" onchange="updateCategory()">
			    <option value="" disabled selected>카테고리를 선택하세요</option>
			    <option value="카페">카페</option>
			    <option value="음식점">음식점</option>
				<option value="숙박">숙박시설</option>
			</select>
			<select id="subCategoryFood" name="sub" style="display: none;">
			    <option value="" disabled selected>세부 카테고리</option>
			    <option value="한식">한식</option>
			    <option value="중식">중식</option>
			    <option value="일식">일식</option>
			    <option value="양식">양식</option>
			    <option value="동남아">동남아</option>
			    <option value="치킨">치킨</option>
			    <option value="분식">분식</option>
			    <option value="술집">술집</option>
			    <option value="뷔페">뷔페</option>
			</select>
			<select id="subCategorySleep" name="sub" style="display: none;">
			    <option value="" disabled selected>세부 카테고리</option>
			    <option value="모텔">모텔</option>
			    <option value="호텔">호텔</option>
			    <option value="온천">온천</option>
			    <option value="펜션">펜션</option>
			</select>
			
			<input type="submit" value="검색" id="searchButton">
			
		</form>
		
		<div id="results"></div>
		
		<div id="pagination"></div>


</body>

<script src="/howAbout/resources/js/category.js"></script>
</html>