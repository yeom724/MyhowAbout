<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
    <div id="kakaoIndex">
        <a href="#kakaoBody">본문 바로가기</a>
        <a href="#kakaoGnb">메뉴 바로가기</a>
    </div>
    <div id="kakaoWrap" class="wrap_mapdetail lbar_on">
    	<div data-viewid="header" id="kakaoHead" class="head_mapdetail" role="banner">
		    <h1 class="logo_daum">
		        <!-- 2018-07-23 수정 -->
		        <a href="https://map.kakao.com" id="#kakaoMapLogo" data-logtarget="" data-logevent="map_top" target="_blank"><img src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/logo_kakaomap.png" width="121" height="25" class="img_logo" alt="카카오맵" id="exifviewer-img-1" exifid="1656209132" oldsrc="http://t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/logo_kakaomap.png">
		        </a>
		    </h1>
		    <div data-viewid="header" data-root="" class="search_map">
			    <h2 class="screen_out">검색</h2>
			    <form id="searchForm" method="GET">
			        <fieldset>
			            <legend class="screen_out">검색어 입력 폼</legend>
			            <label for="searchKeyword" class="lab_search">카카오맵 지도 검색</label>
			            <input type="text" name="q" id="searchKeyword" class="tf_search" autocomplete="off" spellcheck="false">
			            <button type="submit" id="kakaoBtnSearch" class="btn_search">
			                <span class="ico_comm ico_search">검색</span>
			            </button>
			        </fieldset>
			        <blockquote id="searchKeywordSuggest" class="wrapper"><div class="suggestBox box_sub" style="display: none;"><div class="baseBox bg"><div class="list"><ul class="suggest_list_target"></ul></div></div></div></blockquote>
			    </form>
			</div>
	
		    <div id="kakaoGnb" data-viewid="navBar" data-root="" class="location_bar" role="navigation"><!-- 스크롤 내려 왔을 때 location_bar_on 추가 -->
			    <div class="inner_bar">
			        <div class="outer_header_share_container">
			            <social-share id="header_share_container" class="inner_header_share_container" hidden=""></social-share>
			        </div>
			        <h2 class="tit_location" aria-hidden="true" data-logtarget="" data-logevent="name_bar,name">부민옥</h2>
			        <strong class="screen_out">상세정보 퀵메뉴</strong>
			        <ul class="list_lnb">
			            <li>
			                <a href="https://map.kakao.com?urlX=495653&amp;urlY=1129991&amp;urlLevel=3&amp;itemId=1346301870&amp;q=%EB%B6%80%EB%AF%BC%EC%98%A5&amp;srcid=1346301870&amp;map_type=TYPE_MAP" target="_blank" class="link_lnb" data-logtarget="" data-logevent="name_bar,map">
			                    <span class="ico_comm ico_map">지도</span><!--  2018-11-28 추가 : 텍스트 감싸는 .ico_comm.ico_map 요소 추가  -->
			                </a>
			            </li>
			            <!-- 2018-11-28 추가 : 로드뷰, 즐겨찾기 위치이동으로 인한 추가 -->
			            <li>
			                <a href="https://map.kakao.com?srcid=1346301870&amp;confirmid=1346301870&amp;q=%EB%B6%80%EB%AF%BC%EC%98%A5&amp;rv=on" target="_blank" class="link_lnb" data-roadview="" data-logtarget="" data-logevent="name_bar,roadview">
			                    <span class="ico_comm ico_roadview">로드뷰</span><!--  2018-11-28 추가 : 텍스트 감싸는 .ico_comm.ico_roadview 요소 추가  -->
			                </a>
			            </li>
			            <li><!-- 2018-11-28 즐겨찾기 메뉴의 lst클래스 삭제 -->
			                <a href="#none" class="link_lnb link_bookmark " data-fid="" data-link="fav" data-logtarget="" data-logevent="name_bar,favorite">
			                    <span class="ico_comm ico_bookmark">즐겨찾기 추가</span>
			                    <span class="ico_num ico_num"><span class="screen_out">나의 즐겨찾기 폴더 개수</span></span>
			                </a>
			            </li>
			            <li data-share="">
			                <a href="#none" target="_blank" class="link_lnb" data-link="share">
			                    <span class="ico_comm ico_share">공유하기</span>
			                </a>
			            </li>
			            <!--// 2018-11-28 추가 : 공유하기 버튼 추가 -->
			            <li>
			                <a href="https://map.kakao.com?map_type=TYPE_MAP&amp;target=car&amp;rt=,,495653,1129991&amp;rt1=&amp;rt2=%EB%B6%80%EB%AF%BC%EC%98%A5&amp;rtIds=,1346301870" target="_blank" class="link_lnb" data-logtarget="" data-logevent="name_bar,route">
			                    <span class="ico_comm ico_route">길찾기</span><!--  2018-11-28 추가 : 텍스트 감싸는 .ico_comm.ico_route 요소 추가  -->
			                </a>
			            </li>
			        </ul>
			    </div>
			</div>
		    <div data-viewid="headerProfile" data-root="">
			    <a href="https://map.kakao.com/user/signup" target="_top" class="btn_login">시작하기</a>
			</div>
		</div>
	<hr class="hide">
	<div id="kakaoContent" role="main" class="cont_mapdetail">
	    <div class="dimmed_layer hide"></div>
	    <div id="mArticle">
	        <div data-viewid="basicInfo" class="cont_essential">
    		<div data-viewid="basicInfoTop" data-root="">
		    <div class="details_present" style="background:none;">
		        <a href="#none" class="link_present" data-logtarget="" data-logevent="info_pannel,main_pic">
		                <span class="bg_present" style="background-image:url('//t1.kakaocdn.net/thumb/T800x0.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyMzEyMjlfMTcw%2FMDAxNzAzODE1NDYxMzEy.JJ0RBVM9kD3jbfFwN7w8djVVdLFyICtXjWy_Wji3Sycg.2TL4xh0XCAIqoAKjKEBi73sF8tNb6caLkSMF04QGXZYg.JPEG.bspark5522%2FSE-36834e72-a5e6-11ee-9a91-b70ac159bf4f.jpg%3Ftype%3Dw773')"></span>
		            <span class="frame_g"></span>
		        </a>
		    </div>
		    <div class="place_details">
		        <div class="inner_place">
		            <div class="info_location">
		                    <span href="#none" class="link_ranking">
		                        <span class="ico_comm_fgm ico_ranking">랭킹정보</span>
		                        <span class="txt_ranking">중구 국밥 인기 맛집</span>
		                    </span>
		            </div>
		            <h2 class="tit_location">부민옥</h2>
		            <div class="location_evaluation">
		                <span class="txt_location"><span class="screen_out">분류: </span>한식</span>
		                    <span class="ico_comm ico_dot"></span>
		                    <a href="#none" class="link_evaluation" data-cnt="165" data-target="comment" data-logtarget="" data-logevent="info_pannel,point">후기 <span class="color_b">3.6<span class="screen_out">점</span></span>
		                        <span class="color_g">(165)<span class="screen_out">개 후기</span></span>
		                    </a>
		                    <span class="ico_comm ico_dot"></span>
		                    <a href="#none" class="link_evaluation" data-cnt="182" data-target="review" data-logtarget="" data-logevent="info_pannel,review">
		                        리뷰 <span class="color_b">182<span class="screen_out">개</span></span>
		                    </a>
		            </div>
		            <strong class="screen_out">위치 정보 및 공유하기</strong>
		            <ul class="list_place">
		                <li>
		                    <a href="https://map.kakao.com?urlX=495653&amp;urlY=1129991&amp;urlLevel=3&amp;itemId=1346301870&amp;q=%EB%B6%80%EB%AF%BC%EC%98%A5&amp;srcid=1346301870&amp;map_type=TYPE_MAP" target="_blank" class="link_place" data-logtarget="" data-logevent="info_pannel,map_view"><span class="ico_comm ico_storemap"></span>지도</a></li>
		                <li>
		                    <a href="https://map.kakao.com?map_type=TYPE_MAP&amp;target=car&amp;rt=,,495653,1129991&amp;rt1=&amp;rt2=%EB%B6%80%EB%AF%BC%EC%98%A5&amp;rtIds=,1346301870" target="_blank" class="link_place" data-logtarget="" data-logevent="info_pannel,route"><span class="ico_comm ico_route"></span>길찾기</a>
		                </li>
		                <li>
		                        <a href="https://map.kakao.com?srcid=1346301870&amp;confirmid=1346301870&amp;q=%EB%B6%80%EB%AF%BC%EC%98%A5&amp;rv=on" class="link_place" target="_blank" data-logtarget="" data-logevent="info_pannel,roadview" data-roadview=""><span class="ico_comm ico_roadmap"></span>로드뷰</a>
		                </li>
		                <li class="lst">
		                    <a href="#none" class="link_place" data-logevent="info_pannel,share"><span class="ico_comm ico_share"></span>공유하기</a>
		                    
		                    <social-share class="place_share_container" id="place_share_container" hidden=""></social-share>
		                </li>
		            </ul>

		            <a href="#none" class="link_bookmark " data-fid="" data-logtarget="" data-logevent="info_pannel,favorite">
		                <span class="ico_comm ico_bookmark">즐겨찾기 추가</span>
		                <span class="ico_num ico_num"><span class="screen_out">나의 즐겨찾기 폴더 개수</span></span>
		            </a>

		        </div>
		    </div>
		    <div class="details_rest">
		        <strong class="screen_out">기타 메뉴</strong>
		        <ul class="list_rest">
		            <li>
		                <a href="#none" class="link_rest" data-type="print" data-logtarget="" data-logevent="right_etc,print">
		                    <span class="ico_comm ico_print">프린트하기</span>
		                </a>
		            </li>
		            <li>
		                <a href="#none" class="link_rest" data-type="roughmap" data-logtarget="" data-logevent="right_etc,simplemap">
		                    <span class="ico_comm ico_makemap">약도 만들기</span>
		                </a>
		            </li>
		        </ul>
		    </div>
		</div>
	    <div data-viewid="basicInfo" data-root="" class="details_placeinfo">
	    <h3 class="tit_subject">상세정보</h3>
	    <div class="placeinfo_default">
	        <h4 class="tit_detail"><span class="ico_comm ico_address">위치</span></h4>
	        <div class="location_detail">
	            <span class="txt_address">서울 중구
	                다동길 24-12
	                1층 (우)04522</span>
	            <span class="txt_addrnum">지번<span class="bg_bar"></span>다동 177-2</span>
	        </div>
	    </div>
        <div class="placeinfo_default">
            <h4 class="tit_detail"><span class="ico_comm ico_operation">운영시간 안내</span></h4>
            <div class="location_detail openhour_wrap"><!-- btn_more 클릭 했을 때 open_on 추가 -->
                <div class="location_present">
                                <div class="displayPeriodList">
                                    <strong class="tit_operation fst">
                                            <span class="breaktime">브레이크타임</span>
                                                <a href="#none" class="link_modify">
                                                    <span class="inner_link">수정 제안
                                                        <span class="ico_comm ico_arr">이동하기</span>
                                                    </span>
                                                </a>
                                    </strong>
                                    
                                        <ul class="list_operation">
                                                <li>
                                                    <span class="txt_operation">월~토 <span class="time_operation">11:00 ~ 22:00</span>
                                                    
                                                    </span>
                                                </li>
                                                <li>
                                                    <span class="txt_operation">월~토 휴게시간 <span class="time_operation">14:00 ~ 17:00</span>
                                                    
                                                    </span>
                                                            <a href="#none" class="btn_more" data-logevent="main_info,more_timeinfo"><span class="ico_comm ico_more">더보기</span></a>
                                                </li>
                                        </ul>
                                </div>
                </div>
                    <div class="fold_floor" style="top: 66px;">
                        <div class="inner_floor">
                                    <div class="displayPeriodList">
                                        <strong class="tit_operation fst">영업시간</strong>
                                        
                                            <ul class="list_operation">
                                                    <li>월~토 <span class="time_operation">11:00 ~ 22:00</span>
                                                        
                                                    </li>
                                                    <li>월~토 휴게시간 <span class="time_operation">14:00 ~ 17:00</span>
                                                        
                                                    </li>
                                            </ul>
                                    </div>
                                <div class="displayOffdayList">
                                    <strong class="tit_operation">휴무일</strong>
                                    <ul class="list_operation">
                                            <li>일요일
                                                
                                            </li>
                                    </ul>
                                </div>
                            <a href="#none" class="btn_close">
                                <span class="ico_comm ico_close">닫기</span>
                            </a>
                        </div>
                    </div>
            </div>
        </div>
        <div class="placeinfo_default placeinfo_contact">
            <h4 class="tit_detail"><span class="ico_comm ico_contact">연락처</span></h4>
            <div class="location_detail"><!-- btn_more 클릭 했을 때 open_on 추가 -->
                <div class="location_present">
                    <span class="num_contact"><span class="txt_contact">02-777-4323</span><span class="color_g"> 대표번호</span></span>
                    <a href="#none" class="btn_more" data-logevent="main_info,more_phonenumber"><span class="ico_comm ico_more">더보기</span></a>
                </div>
                    <div class="fold_floor fold_contact" style="top: 23px;">
                        <div class="inner_floor">
                            <strong class="tit_operation fst">관련 전화번호</strong>
                            <ul class="list_operation">
                                <li>
                                    <span class="num_phone">02-777-2345</span>
                                    
                                </li>
                            </ul>
                            <a href="#none" class="btn_close">
                                <span class="ico_comm ico_close">닫기</span>
                            </a>
                        </div>
                </div>
            </div>
        </div>
        <div class="placeinfo_default">
            <h4 class="tit_detail"><span class="ico_comm ico_tag">태그</span></h4>
            <div class="location_detail">
                <div class="txt_tag">
                    <span class="tag_g">
                            <a href="https://map.kakao.com?q=%EB%85%B8%ED%8F%AC" class="link_tag" target="_blank" data-logtarget="" data-logevent="main_info,tag,노포">#노포</a>
                    </span>
                    <a href="#none" class="btn_more2"><span class="ico_comm ico_more">더보기</span></a>
                </div>
            </div>
        </div>
        <div class="placeinfo_default">
            <h4 class="tit_detail"><span class="ico_comm ico_delivery">예약, 배달, 포장</span></h4>
            <div class="location_detail">예약가능, 배달불가, 포장가능</div>
        </div>
        <div class="placeinfo_default placeinfo_facility">
            <h4 class="tit_facility"><span class="ico_comm ico_installation"></span>시설정보</h4>
            <ul class="list_facility">
                    <li>
                        <span class="ico_comm ico_wifi"></span>
                        <span class="color_g">WIFI</span>
                    </li>
                    <li>
                        <span class="ico_comm ico_animal"></span>
                        <span class="color_g">동물출입</span>
                    </li>
                    <li>
                        <span class="ico_comm ico_parking"></span>
                        <span class="color_g">주차</span>
                    </li>
                    <li>
                        <span class="ico_comm ico_handicapped"></span>
                        <span class="color_g">휠체어사용</span>
                    </li>
                    <li>
                        <span class="ico_comm ico_playroom"></span>
                        <span class="color_g">놀이방</span>
                    </li>
                    <li>
                        <span class="ico_comm ico_smoking"></span>
                        <span class="color_g">흡연실</span>
                    </li>
	            </ul>
	        </div>
		    <span class="info_revise">업데이트 <span class="date_revise">2024.09.04.</span> <span class="bg_bar">|</span> <a href="#" class="link_fiy" data-fiytype="detail" data-logtarget="" data-logevent="main_info,FIY">정보 수정 제안</a></span>
		</div>
	</div>
        <div data-viewid="ownerCertification" class="cont_banner" data-root="">
		    <div class="box_banner">
		            <a href="#none" class="link_banner">
		                <span class="ico_comm ico_owner"></span>이 장소의 사장님이라면, 내 매장을 직접 관리해보세요.
		            </a>
		    </div>
		</div>

        <div data-viewid="menuInfo" data-root="" class="cont_menu">
		    <div class="particular_head">
		        <h3 class="tit_subject">메뉴</h3>
		        <span class="txt_updated">업데이트 <span class="txt_date"> 2024.09.04.</span></span>
		    </div>
	        <div class="wrap_list">
	            <div class="present_menu present_menu2">
	                    <a href="#none" data-type="menuboard" data-pidx="0" class="view_menu" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C640x300.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocal%2FkakaomapPhoto%2Freview%2Fc63479456ac55545efcd2620806900ba661f5a14%3Foriginal')" data-logtarget="" data-logevent="additional_info,menu,image1">
	                            <span class="menu_num"></span>
	                        <span class="frame_g"></span>
	                    </a>
	                    <a href="#none" data-type="menuboard" data-pidx="1" class="view_menu" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C640x300.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyNDExMTZfMTc2%2FMDAxNzMxNzQyMjkwMzgx.FzSEHtVjDxjbO7TS2Gzsm8vcXBMia4FwV_hUayBGlNog._sPd8oqARavIClC80kB1K663bRMfAR5q3ek5daYT_8Eg.JPEG%2FSE-539e63b1-dda3-4333-b7e9-bcc4fdd5faba.jpg%3Ftype%3Dw773')" data-logtarget="" data-logevent="additional_info,menu,image2">
	                                <span class="menu_num">
	                                    <span class="txt_num"><span class="ico_comm ico_menu"> 갯수: </span>110</span>
	                                </span>
	                        <span class="frame_g"></span>
	                    </a>
	            </div>
	        </div>
		    <strong class="screen_out">메뉴 목록</strong>
		    <ul class="list_menu" data-maxpage="1">
		            <li class="menu_fst" data-page="1"><!-- 이미지가 있는 경우 -->
		                <div class="info_menu">
		                    <em class="screen_out">명: </em>
		                    
		                    <span class="loss_word">양곰탕</span>
		                    <em class="price_menu"><span class="screen_out">가격: </span>12,000</em>
		                    
		                </div>
		            </li>
		            <li class="" data-page="1"><!-- 이미지가 있는 경우 -->
		                <div class="info_menu">
		                    <em class="screen_out">명: </em>
		                    
		                    <span class="loss_word">양무침 (소)</span>
		                    <em class="price_menu"><span class="screen_out">가격: </span>38,000</em>
		                    
		                </div>
		            </li>
		            <li class="" data-page="1"><!-- 이미지가 있는 경우 -->
		                <div class="info_menu">
		                    <em class="screen_out">명: </em>
		                    
		                    <span class="loss_word">수육 (소)</span>
		                    <em class="price_menu"><span class="screen_out">가격: </span>35,000</em>
		                    
		                </div>
		            </li>
		            <li class="opened_last" data-page="1"><!-- 이미지가 있는 경우 -->
		                <div class="info_menu">
		                    <em class="screen_out">명: </em>
		                    
		                    <span class="loss_word">소고기</span>
		                    <em class="price_menu"><span class="screen_out">가격: </span>100,000</em>
		                    
		                </div>
		            </li>
		    </ul>
		</div>

        
        <div data-viewid="trendRanking" data-root="" class="cont_ranking">
  <div class="particular_head">
    <h3 class="screen_out">랭킹</h3>
    <div class="filter_ranking">
      <div class="wrap_filter">
        <button type="button" aria-expanded="false" class="btn_filter">
          <span class="txt_filter"><span class="txt_location">다동</span> 검색 랭킹</span>
          <span class="ico_comm_fgm ico_arrow">정렬조건 변경</span>
        </button>
        <div class="layer_filter"> <em class="screen_out">선택옵션</em>
          <ul class="list_opt">
              <li class="on">
                <a href="#none" class="link_option" data-type="search">
                  검색순
                  <span class="ico_comm_fgm ico_check">선택됨</span>
                </a>
              </li>
              <li class="">
                <a href="#none" class="link_option" data-type="path">
                  길찾기순
                  
                </a>
              </li>
              <li class="">
                <a href="#none" class="link_option" data-type="favorite">
                  즐겨찾기순
                  
                </a>
              </li>
              <li class="">
                <a href="#none" class="link_option" data-type="share">
                  친구공유순
                  
                </a>
              </li>
          </ul>
        </div>
      </div> <span class="txt_updated">업데이트 <span class="txt_date">24.12.11.</span></span>
    </div>
    <div class="wrap_tab">
      <div class="inner_tab">
        <ul class="list_tab" role="tablist">
            <li role="presentation"><a href="#none" role="tab" aria-selected="true" class="link_tab" data-id="food">맛집</a></li>
            <li role="presentation"><a href="#none" role="tab" aria-selected="false" class="link_tab" data-id="visit">가볼만한 곳</a></li>
        </ul>
      </div>
    </div>
    <div class="tab_rankmenu">
      <div class="inner_rankmenu"> <strong class="screen_out">카테고리 목록</strong>
        <ul class="list_rankmenu">
            <li class="on">
              <a href="#none" class="link_rankmenu" data-category="category_all">전체</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="category_korean">한식</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="category_western">양식</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="category_japanese">일식</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="category_chinese">중식</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="category_asian">아시안</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="category_cafe">카페</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_katsu">돈가스</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_kalguksu">칼국수</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_sushi">초밥</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_tteokbokki">떡볶이</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_pizza">피자</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_burger">햄버거</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_dumpling">만두</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_champon">짬뽕</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_ricenoodle">쌀국수</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_hotpot">마라탕</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_lambskewer">양꼬치</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_sashimi">회</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_bread">빵</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_chicken">치킨</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_eel">장어</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_gukbap">국밥</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_dakgalbi">닭갈비</a>
            </li>
            <li class="">
              <a href="#none" class="link_rankmenu" data-category="menu_porkbelly">삼겹살</a>
            </li>
        </ul> <button type="button" class="btn_fold"><span class="ico_comm_fgm ico_fold">카테고리 목록 더보기</span></button>
      </div>
    </div>
    <div class="list_rank_wrap">
        <div class="rank_list">
          <strong class="screen_out">전체 장소 목록</strong>
              <ol class="list_rank">
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="9930216" data-rank="1">
                        <em class="num_rank">
                          <span class="screen_out">1위</span>
                            <span class="ico_comm_fgm ico_num1"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fplace%2FC3A10F6D3CA54F36B70ABCD3A0A37E37" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">미진일식</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                  <span class="review_none">
                                    <span class="ico_comm_fgm ico_none"></span>
                                    <span class="txt_none">후기 미제공</span>
                                  </span>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>일식집</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="9352032" data-rank="2">
                        <em class="num_rank">
                          <span class="screen_out">2위</span>
                            <span class="ico_comm_fgm ico_num2"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.kakaocdn.net%2Ffiy_reboot%2Fplace%2FED2FD9EB2A8D49B583C09490E110BCA5" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">인천집</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                <div class="info_review">
                                  <span class="ico_comm_fgm star_rate">
                                    <span class="ico_comm_fgm inner_star" style="width:47.46px">평점 :</span>
                                    <em class="num_rate">3.4</em>
                                  </span>
                                  <p class="txt_review"><span class="screen_out">후기</span>(33)</p>
                                </div>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>족발,보쌈</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="11064200" data-rank="3">
                        <em class="num_rank">
                          <span class="screen_out">3위</span>
                            <span class="ico_comm_fgm ico_num3"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fplace%2F2F2B7D7FD2BB4ACD8667EB92536CD000" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">무교동북어국집</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                <div class="info_review">
                                  <span class="ico_comm_fgm star_rate">
                                    <span class="ico_comm_fgm inner_star" style="width:63.839999999999996px">평점 :</span>
                                    <em class="num_rate">4.6</em>
                                  </span>
                                  <p class="txt_review"><span class="screen_out">후기</span>(332)</p>
                                </div>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>해장국</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="21232315" data-rank="4">
                        <em class="num_rank">
                          <span class="screen_out">4위</span>
                            <span class="ico_comm_fgm ico_num4"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.kakaocdn.net%2Ffiy_reboot%2Fplace%2F3D244F5E3017412CB8F60CCAA3F42050" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">남포면옥</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                <div class="info_review">
                                  <span class="ico_comm_fgm star_rate">
                                    <span class="ico_comm_fgm inner_star" style="width:41.72px">평점 :</span>
                                    <em class="num_rate">3.0</em>
                                  </span>
                                  <p class="txt_review"><span class="screen_out">후기</span>(327)</p>
                                </div>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>냉면</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="8577709" data-rank="5">
                        <em class="num_rank">
                          <span class="screen_out">5위</span>
                            <span class="ico_comm_fgm ico_num5"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocalfiy%2FD445145C790347C48091C93A8247EA13" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">초류향</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                <div class="info_review">
                                  <span class="ico_comm_fgm star_rate">
                                    <span class="ico_comm_fgm inner_star" style="width:42.699999999999996px">평점 :</span>
                                    <em class="num_rate">3.0</em>
                                  </span>
                                  <p class="txt_review"><span class="screen_out">후기</span>(74)</p>
                                </div>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>중국요리</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
              </ol>
              <ol class="list_rank">
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="1346301870" data-rank="6">
                        <em class="num_rank">
                          <span class="screen_out">6위</span>
                            <span class="ico_comm_fgm ico_num6"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyMzEyMjlfMTcw%2FMDAxNzAzODE1NDYxMzEy.JJ0RBVM9kD3jbfFwN7w8djVVdLFyICtXjWy_Wji3Sycg.2TL4xh0XCAIqoAKjKEBi73sF8tNb6caLkSMF04QGXZYg.JPEG.bspark5522%2FSE-36834e72-a5e6-11ee-9a91-b70ac159bf4f.jpg%3Ftype%3Dw773" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">부민옥</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                <div class="info_review">
                                  <span class="ico_comm_fgm star_rate">
                                    <span class="ico_comm_fgm inner_star" style="width:50.120000000000005px">평점 :</span>
                                    <em class="num_rate">3.6</em>
                                  </span>
                                  <p class="txt_review"><span class="screen_out">후기</span>(165)</p>
                                </div>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>한식</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="651364551" data-rank="7">
                        <em class="num_rank">
                          <span class="screen_out">7위</span>
                            <span class="ico_comm_fgm ico_num7"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fplace%2F4DAEAE5DC84B46D4836ABBA09923C5ED" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">pastata-ta 파스타 타타</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                <div class="info_review">
                                  <span class="ico_comm_fgm star_rate">
                                    <span class="ico_comm_fgm inner_star" style="width:56.279999999999994px">평점 :</span>
                                    <em class="num_rate">4.0</em>
                                  </span>
                                  <p class="txt_review"><span class="screen_out">후기</span>(83)</p>
                                </div>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>양식</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="625603977" data-rank="8">
                        <em class="num_rank">
                          <span class="screen_out">8위</span>
                            <span class="ico_comm_fgm ico_num8"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.kakaocdn.net%2Fmystore%2FBA2068BD413D45E1ACD9C98C384AA57B" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">알돈</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                <div class="info_review">
                                  <span class="ico_comm_fgm star_rate">
                                    <span class="ico_comm_fgm inner_star" style="width:61.32px">평점 :</span>
                                    <em class="num_rate">4.4</em>
                                  </span>
                                  <p class="txt_review"><span class="screen_out">후기</span>(71)</p>
                                </div>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>돈까스,우동</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="16268305" data-rank="9">
                        <em class="num_rank">
                          <span class="screen_out">9위</span>
                            <span class="ico_comm_fgm ico_num9"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Fplace%2F76C47F452FE14B1FBF82A55F6A8342D4" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">철철복집</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                <div class="info_review">
                                  <span class="ico_comm_fgm star_rate">
                                    <span class="ico_comm_fgm inner_star" style="width:54.46px">평점 :</span>
                                    <em class="num_rate">3.9</em>
                                  </span>
                                  <p class="txt_review"><span class="screen_out">후기</span>(39)</p>
                                </div>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>복어</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
                  <li>
                    <div class="box_item">
                      <a href="#none" class="item_rank" data-cid="255438897" data-rank="10">
                        <em class="num_rank">
                          <span class="screen_out">10위</span>
                            <span class="ico_comm_fgm ico_num1"></span><span class="ico_comm_fgm ico_num0"></span>
                        </em>
                        <div class="area_rankimg">
                            <img src="//t1.kakaocdn.net/thumb/C150x120.q50/?fname=http%3A%2F%2Ft1.kakaocdn.net%2Fmystore%2FA8152B69E385491EB9866A4CBB505524" width="75" height="60" class="img_store" alt="" onerror="this.style.display='none'">
                        </div>
                        <div class="area_rankinfo">
                          <strong class="tit_rank">스케줄오스테리아</strong>
                          <div class="info_rank">
                            <div class="star_rank">
                                  <span class="review_none">
                                    <span class="ico_comm_fgm ico_none"></span>
                                    <span class="txt_none">후기 미제공</span>
                                  </span>
                            </div>
                            <p class="txt_type"><span class="screen_out">업종</span>양식</p>
                          </div>
                        </div>
                      </a>
                    </div>
                  </li>
              </ol>
        </div>
    </div>
  </div>
</div>

            <div data-viewid="visitor" data-root="" class="cont_visitor">
        <h3 class="tit_subject">방문자 데이터</h3>
        <p class="txt_visitor">카카오의 장소 기반 빅데이터를 분석한 정보입니다. (2024.12.11. 업데이트)</p>
        <div class="popular_statistics">
            <div class="visit_popular">
                <h4 class="tit_popular">시간별 인기도</h4>
                <ul class="day_legend">
                    <li><span class="ico_comm ico_weekly"></span>주평균</li>
                    <li>
                        <span class="ico_comm ico_day"></span>
                        <span class="day_txt">수요일 평균</span>
                    </li>
                </ul>
            </div>
            <div class="dayChart_wrap">
                <canvas id="dayChart" width="640" height="210" style="display: block;"></canvas>
            </div><!-- 시간별 인기도 그래프 영역 -->
            <ul class="list_day">
                <li data-day="sunday">
                    <a href="#none" class="link_day">일</a>
                </li>
                <li data-day="monday">
                    <a href="#none" class="link_day">월</a>
                </li>
                <li data-day="tuesday">
                    <a href="#none" class="link_day">화</a>
                </li>
                <li data-day="wednesday" class="on">
                    <a href="#none" class="link_day">수</a>
                </li>
                <li data-day="thursday">
                    <a href="#none" class="link_day">목</a>
                </li>
                <li data-day="friday">
                    <a href="#none" class="link_day">금</a>
                </li>
                <li data-day="saturday">
                    <a href="#none" class="link_day">토</a>
                </li>
            </ul>
            <div class="visit_popular">
                <h4 class="tit_popular">연령별 / 성별 인기도</h4>
            </div>
            <div class="charts_wrap">
                <strong class="screen_out">연령별 인기도 그래프</strong>
                <div class="ageChart_wrap">
                    <canvas id="ageChart" width="351" height="170" style="display: block;"></canvas>
                </div><!-- 연령별 인기도 그래프 영역(임시 스타일) -->
                <strong class="screen_out">성별 인기도 그래프</strong>
                <div class="genderChart_wrap">
                    <div class="chart_gender">
                        <canvas id="genderChart" width="146" height="146" style="display: block;"></canvas>
                    </div><!-- 성별 인기도 그래프 영역(임시 스타일) -->
                    <ul class="gender_legend">
                        <li><span class="ico_comm ico_male"></span>남성</li>
                        <li><span class="ico_comm ico_female"></span>여성</li>
                    </ul>
                </div>
            </div>
        </div>

    </div>


        <div data-viewid="photoSection" data-root="" class="cont_photo">
    <div class="particular_head">
        <h3 class="tit_subject">사진</h3>
        
        <div class="wrap_btn">
        </div>
    </div>
        <div class="photo_area">
            <ul class="list_photo photo_type5">
        <li class="size_l">
            <!-- 사진 2장 부터 클래스 size_l 추가 -->
            <a href="#none" class="link_photo" data-pidx="0" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C320x320.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyMzEyMjlfMTcw%2FMDAxNzAzODE1NDYxMzEy.JJ0RBVM9kD3jbfFwN7w8djVVdLFyICtXjWy_Wji3Sycg.2TL4xh0XCAIqoAKjKEBi73sF8tNb6caLkSMF04QGXZYg.JPEG.bspark5522%2FSE-36834e72-a5e6-11ee-9a91-b70ac159bf4f.jpg%3Ftype%3Dw773')" data-logtarget="" data-logevent="photo,photo_view">
                <span class="frame_g"></span>
            </a>
        </li>
        <li class="">
            <!-- 사진 2장 부터 클래스 size_l 추가 -->
            <a href="#none" class="link_photo" data-pidx="1" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C160x160.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocal%2FkakaomapPhoto%2Freview%2F595afeda2d583e98ba831fd974b25454951fa0a2%3Foriginal')" data-logtarget="" data-logevent="photo,photo_view">
                <span class="frame_g"></span>
            </a>
        </li>
        <li class="">
            <!-- 사진 2장 부터 클래스 size_l 추가 -->
            <a href="#none" class="link_photo" data-pidx="2" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C160x160.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocal%2FkakaomapPhoto%2Freview%2F27a15e6fcf140f1f0196241a41311114a14423bb%3Foriginal')" data-logtarget="" data-logevent="photo,photo_view">
                <span class="frame_g"></span>
            </a>
        </li>
        <li class="">
            <!-- 사진 2장 부터 클래스 size_l 추가 -->
            <a href="#none" class="link_photo" data-pidx="3" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C160x160.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocal%2FkakaomapPhoto%2Freview%2Fab5cafe02876cc3c4ae9f726bd9ab531f7119229%3Foriginal')" data-logtarget="" data-logevent="photo,photo_view">
                <span class="frame_g"></span>
            </a>
        </li>
        <li class="">
            <!-- 사진 2장 부터 클래스 size_l 추가 -->
            <a href="#none" class="link_photo" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C160x160.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocal%2FkakaomapPhoto%2Freview%2F17706d6a9c4ff40a0ef6a0129dffc7dcf8523f53%3Foriginal')" data-logtarget="" data-logevent="photo,photo_view">
                        <span class="more_photo">
                            <span class="num_photo">+2043</span>
                        </span>
                <span class="frame_g"></span>
            </a>
        </li>
</ul>

        </div>
            <strong class="screen_out">분류</strong>
            <ul class="list_category">
                    <li class="on">
                        <a href="#none" class="link_tag" data-category="all" data-logtarget="" data-logevent="photo,tag,전체">
                            전체
                        </a>
                    </li><!-- 선택시 클래스 on 추가 -->
                    <li>
                        <a href="#none" class="link_tag" data-category="음식" data-logtarget="" data-logevent="photo,tag,음식">
                            
                            #음식
                        </a>
                    </li><!-- 선택시 클래스 on 추가 -->
                    <li>
                        <a href="#none" class="link_tag link_tag2" data-category="메뉴판" data-logtarget="" data-logevent="photo,tag,메뉴판">
                            
                            #메뉴판
                        </a>
                    </li><!-- 선택시 클래스 on 추가 -->
                    <li>
                        <a href="#none" class="link_tag" data-category="실외" data-logtarget="" data-logevent="photo,tag,실외">
                            
                            #실외
                        </a>
                    </li><!-- 선택시 클래스 on 추가 -->
            </ul>
</div>
        <div data-viewid="commentRate" data-root="">
  <div class="cont_grade">
    <div class="rate_intro"> 
      <a href="#none" class="link_profile">
      </a>
        <p class="desc_grade">이 장소의 후기를 남겨주세요.</p>
      <div class="grade_rate">
        <div class="grade_star size_l">
          <span class="ico_star star_rate"> <span class="ico_star inner_star" style="width:0%"></span></span>
        </div>
      </div>
    </div>
  </div>
</div>
        <div data-viewid="comment" data-root="" class="cont_evaluation  ">
        <strong class="total_evaluation">전체 <span class="color_b">165</span></strong>
        <div class="ahead_info">
            <strong class="screen_out">후기 요약</strong>
            <div class="grade_star">
                <em class="num_rate">3.6<span class="txt_score">점</span></em>
                <span class="ico_star star_rate">
                    <span class="ico_star inner_star" style="width:72%"></span>
                </span>
            </div>
        </div>
            <strong class="screen_out">추천 포인트</strong>
            <div class="view_likepoint">
                            <span class="chip_likepoint chip_type1">
                                    <span class="ico_comm ico_like3"></span>
                                    <span class="txt_likepoint">맛</span>
                                    <span class="num_likepoint">33</span>
                            </span>
                            <span class="chip_likepoint chip_type2">
                                    <span class="ico_comm ico_like3"></span>
                                    <span class="txt_likepoint">가성비</span>
                                    <span class="num_likepoint">12</span>
                            </span>
                            <span class="chip_likepoint chip_type3">
                                    <span class="ico_comm ico_like3"></span>
                                    <span class="txt_likepoint">친절</span>
                                    <span class="num_likepoint">6</span>
                            </span>
                            <span class="chip_likepoint chip_type4">
                                    <span class="ico_comm ico_like3"></span>
                                    <span class="txt_likepoint">분위기</span>
                                    <span class="num_likepoint">5</span>
                            </span>
                            <span class="chip_likepoint chip_type5">
                                    <span class="ico_comm ico_like3"></span>
                                    <span class="txt_likepoint">주차</span>
                                    <span class="num_likepoint">3</span>
                            </span>
            </div>
    <div class="evaluation_review">
        <strong class="screen_out">후기 리스트</strong>
        <ul class="list_evaluation">
                <li data-id="11536191" data-ismy="false" data-userid="1013800081" class="" data-is-block="false">
                  <a href="javascript:void(0);" class="profile_info" data-username="비버니" data-ori="http://t1.daumcdn.net/local/kakaomapPhoto/profile/3be747902d4eed3f696e05ecf348f9fe50c364a0?original">
                        <img src="//t1.kakaocdn.net/thumb/C96x96.q50/?fname=http%3A%2F%2Ft1.daumcdn.net%2Flocal%2FkakaomapPhoto%2Fprofile%2F3be747902d4eed3f696e05ecf348f9fe50c364a0%3Foriginal" width="48" height="48" class="thumb_g" alt="" onerror="this.style.display='none'">
                
                  </a>
                  <div class="unit_info">
                    <em class="screen_out">작성자 : </em>
                    <a href="#none" class="link_user">
                      <div class="inner_user">
                        <span class="txt_username">비버니</span>
                          <div class="badge_info">
                            <span class="ico_badge ico_badge_silver">실버 배지</span>
                            <span class="txt_badge"><span class="screen_out">레벨</span>12</span>
                          </div>
                      </div>
                    </a>
                    <span class="bg_bar"></span>
                    <span class="txt_item">후기</span>
                    <span class="txt_desc">17</span>
                    <span class="txt_item">별점평균</span>
                    <span class="txt_desc">3.1</span>
                      <span class="bg_bar"></span>
                    <span class="screen_out">최종수정일 : </span>
                    <span class="time_write">2024.11.30.</span>
                  </div>
                  <div class="star_info">
                    <div class="grade_star size_s">
                      <span class="ico_star star_rate">
                        <span class="ico_star inner_star" style="width:40%;"></span>
                      </span>
                    </div>
                  </div>
                  <div class="comment_info">
                      <p class="txt_comment"><span>소금육개장.</span><button type="button" class="btn_fold">더보기</button></p>
                      <div class="append_item">
                        <a href="#none" class="link_like">
                          <span class="ico_comm ico_like"></span> 좋아요 <span class="num_g" style="display:none;">0</span>
                        </a>
                      </div>
                  </div>
                    <div class="wrap_util">
                      <button type="button" class="btn_util">
                        <span class="ico_comm ico_more">메뉴 더보기</span>
                      </button>
                      <div class="layer_util" data-commentid="11536191" data-isbooking="">
                        <ul class="list_opt">
                            <li><a href="#none" data-id="spamLink" class="link_util">신고</a></li>
                        </ul>
                      </div>
                    </div>
                </li>
                <li data-id="11494720" data-ismy="false" data-userid="764249536" class="" data-is-block="false">
                  <a href="javascript:void(0);" class="profile_info" data-username="Huny" data-ori="">
                
                  </a>
                  <div class="unit_info">
                    <em class="screen_out">작성자 : </em>
                    <a href="#none" class="link_user">
                      <div class="inner_user">
                        <span class="txt_username">Huny</span>
                          <div class="badge_info">
                            <span class="ico_badge">브론즈 배지</span>
                            <span class="txt_badge"><span class="screen_out">레벨</span>1</span>
                          </div>
                      </div>
                    </a>
                    <span class="bg_bar"></span>
                    <span class="txt_item">후기</span>
                    <span class="txt_desc">1</span>
                    <span class="txt_item">별점평균</span>
                    <span class="txt_desc">1.0</span>
                      <span class="bg_bar"></span>
                    <span class="screen_out">최종수정일 : </span>
                    <span class="time_write">2024.11.24.</span>
                  </div>
                  <div class="star_info">
                    <div class="grade_star size_s">
                      <span class="ico_star star_rate">
                        <span class="ico_star inner_star" style="width:20%;"></span>
                      </span>
                    </div>
                  </div>
                  <div class="comment_info">
                      <p class="txt_comment"><span>주방위생, 서비스</span><button type="button" class="btn_fold">더보기</button></p>
                      <div class="append_item">
                        <a href="#none" class="link_like">
                          <span class="ico_comm ico_like"></span> 좋아요 <span class="num_g" style="display:none;">0</span>
                        </a>
                      </div>
                  </div>
                    <div class="wrap_util">
                      <button type="button" class="btn_util">
                        <span class="ico_comm ico_more">메뉴 더보기</span>
                      </button>
                      <div class="layer_util" data-commentid="11494720" data-isbooking="">
                        <ul class="list_opt">
                            <li><a href="#none" data-id="spamLink" class="link_util">신고</a></li>
                        </ul>
                      </div>
                    </div>
                </li>
                <li data-id="11395274" data-ismy="false" data-userid="1009066423" class="" data-is-block="false">
                  <a href="javascript:void(0);" class="profile_info" data-username="아침" data-ori="">
                
                  </a>
                  <div class="unit_info">
                    <em class="screen_out">작성자 : </em>
                    <a href="#none" class="link_user">
                      <div class="inner_user">
                        <span class="txt_username">아침</span>
                          <div class="badge_info">
                            <span class="ico_badge ico_badge_silver">실버 배지</span>
                            <span class="txt_badge"><span class="screen_out">레벨</span>17</span>
                          </div>
                      </div>
                    </a>
                    <span class="bg_bar"></span>
                    <span class="txt_item">후기</span>
                    <span class="txt_desc">37</span>
                    <span class="txt_item">별점평균</span>
                    <span class="txt_desc">4.5</span>
                      <span class="bg_bar"></span>
                    <span class="screen_out">최종수정일 : </span>
                    <span class="time_write">2024.11.10.</span>
                  </div>
                  <div class="star_info">
                    <div class="grade_star size_s">
                      <span class="ico_star star_rate">
                        <span class="ico_star inner_star" style="width:80%;"></span>
                      </span>
                    </div>
                  </div>
                  <div class="comment_info">
                      <p class="txt_comment"><span>육개장이 제일 유명. 맛있음 다만 재료는 소고기와 대파밖에 안들어감 고사리등은 전혀없음</span><button type="button" class="btn_fold">더보기</button></p>
                      <div class="append_item">
                        <a href="#none" class="link_like">
                          <span class="ico_comm ico_like"></span> 좋아요 <span class="num_g" style="display:none;">0</span>
                        </a>
                      </div>
                  </div>
                    <div class="wrap_util">
                      <button type="button" class="btn_util">
                        <span class="ico_comm ico_more">메뉴 더보기</span>
                      </button>
                      <div class="layer_util" data-commentid="11395274" data-isbooking="">
                        <ul class="list_opt">
                            <li><a href="#none" data-id="spamLink" class="link_util">신고</a></li>
                        </ul>
                      </div>
                    </div>
                </li>
        </ul>
            <a href="#none" class="link_more"><span class="txt_more">후기 더보기</span><span class="ico_comm ico_more"></span></a>
    </div>
</div>

        <div class="cont_review" data-viewid="review" data-root="">
    <div class="particular_head">
        <h3 class="tit_subject">리뷰</h3>
            <span class="num_g">182<span class="screen_out">개</span></span>
    </div>
        <div class="wrap_list">
            <strong class="screen_out">리뷰 리스트</strong>
            <ul class="list_review">
                    <li data-id="74193766" class="story_type2">
                        <!-- 타이틀(클래스 tit_story)이 2줄 일 때 story_type2 추가 -->
                        <a href="http://blog.naver.com/muckduck99/223672810241" target="_blank" class="link_review" data-logtarget="" data-logevent="review,list1">
                            <div class="review_thumb exist_img">
                                    <span class="item_photo" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C204x110.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyNDExMjVfMjQ3%2FMDAxNzMyNTQ0MjgwMzYw.6DML91HK2bzwfXK6kq30hWdj4lkkNAcrQbdiXGptbjYg.wjr0TKzJqxo-8zC8OxCAl_HIJlBbYLosXdULsop6400g.JPEG%2F1732544277830.jpg%3Ftype%3Dw966')"></span>
                                    <span class="frame_g"></span>
                            </div>
                            <div class="review_story">
                                <strong class="tit_story">시청 을지로 _ 부민옥 육개장</strong>
                                <p class="txt_story">대파와 고기 잔뜩 육개장 기본반찬도 푸짐 아삭아삭한 깍두기 &amp; 멸치볶음 ✨️ 뜨끈한 국물 생각나는 쌀쌀한 날씨엔 육개장 한그릇 뚝딱 중구 다동 시청근처 60년 전통 오래된 가게 ✨️ 기본찬도 맛있고 고기만큼 큼직한 대파도 특색있는 육개장 맛집 ? 부민옥 서울특별시 중구 다동길 24-12</p>
                            </div>
                        </a>
                        <span class="info_user">
                            <span class="txt_user">Seoulduck</span>
                            <span class="bg_bar">|</span>
                            <span class="txt_date">2024.11.25.</span>
                        </span>
                        <span class="frame_g"></span>
                    </li>
                    <li data-id="73632783" class="">
                        <!-- 타이틀(클래스 tit_story)이 2줄 일 때 story_type2 추가 -->
                        <a href="http://aromanticwriter.tistory.com/10" target="_blank" class="link_review" data-logtarget="" data-logevent="review,list2">
                            <div class="review_thumb exist_img">
                                    <span class="item_photo" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C204x110.q50/?fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FnONEo%2FbtsKUgDQeAg%2FuaSTExoL7OCBzzcRwsJHmk%2Fimg.jpg')"></span>
                                    <span class="frame_g"></span>
                            </div>
                            <div class="review_story">
                                <strong class="tit_story">부민옥 육개장</strong>
                                <p class="txt_story">을지로 부민옥 2024. 4. 18. 유튜브에서 육개장 맛집으로 을지로 부민옥이라는 상호를 소개 받고 오늘 점심 때 육개장 한 사발 했다. 주문한 육개장 받아 숟가락으로 국물 한 입 떠먹으니 나도 모르게 &amp;lsquo;이 맛이야&amp;rsquo;(*) 소리가 나왔다. 비록 반은 미원 맛이겠거니 하지만 내가 기억하고 있는, 한 동안 잊고 지내온 육개장 맛 바로 그 맛이었다. 다만 을지로 부민옥 육개장에는 흔한 고사리는커녕 숙주 한 올 들어있지 않고 오직 굵은 대파와 투박하게 숭덩숭덩 썰어낸 소고기 양지 그리고 고추기름 동동 떠다니는 국물로만 맛을 내었는데 잔기술을 부리지 않고 기본기로만 승부하는 진정한 요식업계의 파이터 중 하나가 아닐까 그런 생각도 들었다. 육개장 떠먹으며 메뉴판을 보니 식사 메뉴로 육개장과 양곰탕이 주 종목이고 술안주 메뉴로는 양무침이 대표 선수로 보였다. 식사 하는 동안 테이블 창밖에 쌓여 있는 술병들이 이 집 양무침의 실력을 말없이 증명하여 언제 지인들 꼬득여 양무침에</p>
                            </div>
                        </a>
                        <span class="info_user">
                            <span class="txt_user">혼밥식객 · 주당천리</span>
                            <span class="bg_bar">|</span>
                            <span class="txt_date">2024.11.24.</span>
                        </span>
                        <span class="frame_g"></span>
                    </li>
                    <li data-id="73366935" class="story_type2">
                        <!-- 타이틀(클래스 tit_story)이 2줄 일 때 story_type2 추가 -->
                        <a href="http://blog.naver.com/foodie_travel/223662975096" target="_blank" class="link_review" data-logtarget="" data-logevent="review,list3">
                            <div class="review_thumb exist_img">
                                    <span class="item_photo" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C204x110.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyNDExMTZfMTE1%2FMDAxNzMxNzQwOTY3OTM1.B0chmg_6TDXA_ezcGJ8_gFlhozH9N-Src7Qmj0f9Qbsg.gq4IFFFKUb5E_2bRIqe9eLzE-cDoCRRNPHS8hpqFm2Ug.PNG%2FSE-f9fa6197-b549-4f9c-8a67-549a61a0a961.png%3Ftype%3Dw773')"></span>
                                    <span class="frame_g"></span>
                            </div>
                            <div class="review_story">
                                <strong class="tit_story">[다동.EAT] 60년 노포의 근본 육개장, 을지로 '부민옥'</strong>
                                <p class="txt_story">음식이란 지극히 주관적인 취향의 영역이라 모두가 동의하는 '최고'란 존재하기 힘들죠. 그래서 이 곳 부민옥은 '최고'라기 보다는 제가 '개인적으로 가장 좋아하는 육개장을 내는 곳'입니다. 요즘말로 '최애(最愛)'인 셈이죠. 날씨가 쌀쌀해지니 뜨끈한 육개장 한 그릇이 그리워 찾아왔습니다. 무려 1956년부터 이 곳 다동을 지켜왔으니, 이미 그 업력은 60년을 훌쩍 넘어 이제 70년을 바라봅니다. 전후 개업했던 2세대 노포들인 미진,평래옥,열차집 등과 멀지 않은 서울의 중심, 다동에 위치하죠. 부민옥 서울특별시 중구 다동길 24-12 지금이야 조금은 노후된 동네로 여겨지지만 80년대 90년대에는 삼성본관,한국은행,조선일보,시청 등이 근처에 있어 정관계는 물론 언론,금융,경제를 움직이던 사람들의 아지트 같은 곳이</p>
                            </div>
                        </a>
                        <span class="info_user">
                            <span class="txt_user">한끼 여행</span>
                            <span class="bg_bar">|</span>
                            <span class="txt_date">2024.11.16.</span>
                        </span>
                        <span class="frame_g"></span>
                    </li>
                    <li data-id="73329837" class="story_type2">
                        <!-- 타이틀(클래스 tit_story)이 2줄 일 때 story_type2 추가 -->
                        <a href="http://blog.naver.com/hsg8270/223662630021" target="_blank" class="link_review" data-logtarget="" data-logevent="review,list4">
                            <div class="review_thumb exist_img">
                                    <span class="item_photo" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C204x110.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyNDExMTZfMjcy%2FMDAxNzMxNzE3Mjc4MTIx.mORiPTgZYlbWSAQd5PoBPN2Yw_g5Vj3dGdsuR9oEbNQg.eO-WsG4LvhMSuvDiWVXlcXP7hwU881MrM8RINuiVspMg.PNG%2FPhoto_1.png%3Ftype%3Dw773')"></span>
                                    <span class="frame_g"></span>
                            </div>
                            <div class="review_story">
                                <strong class="tit_story">서울 을지로입구역 맛집 부민옥 가격메뉴리뷰주차영업시간</strong>
                                <p class="txt_story">이름 : 부민옥 도로명 주소 : 서울 중구 다동길 24-12 ● 영업시간 - 토 11:30 ~ 21:00 - 월 11:00 ~ 22:00 - 화 11:00 ~ 22:00 - 수 11:00 ~ 22:00 - 목 11:00 ~ 22:00 - 금 11:00 ~ 22:00 전화번호 : 02-777-2345 옵션사항 : ? 상품 － 1. 육개장 : 11000원 － 2. 양곰탕 : 12000원 － 3. 복국 : 15000원 － 4. 선지국 : 9000원 － 5. 비빔밥 : 10000원 － 6. 사골우거지국 : 7000원 － 7. 양무침 소 : 38000원 － 8. 수육 소 : 35000원 － 9. 곱창전골 중 : 60000원 － 10. 부산찜 : 40000원 － 11. 낙지볶음 : 48000원 － 12. 도가니수육 </p>
                            </div>
                        </a>
                        <span class="info_user">
                            <span class="txt_user">좋은 곳을 추천드려요!</span>
                            <span class="bg_bar">|</span>
                            <span class="txt_date">2024.11.16.</span>
                        </span>
                        <span class="frame_g"></span>
                    </li>
                    <li data-id="73035437" class="story_type2">
                        <!-- 타이틀(클래스 tit_story)이 2줄 일 때 story_type2 추가 -->
                        <a href="http://blog.naver.com/am5246qr/223656034561" target="_blank" class="link_review" data-logtarget="" data-logevent="review,list5">
                            <div class="review_thumb exist_img">
                                    <span class="item_photo" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C204x110.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyNDEwMjVfMTk0%2FMDAxNzI5ODQ4NzY2NjUw.zkJXXByaxuAOP3WzX4w-0zZZI2qUhqmFeROJv2jDsSUg.gMXFZe4OgHYXzYy4EWisAHo8z1VkOmKJY1tJ-UuZnb8g.JPEG%2FIMG_6187.jpg%3Ftype%3Dw580')"></span>
                                    <span class="frame_g"></span>
                            </div>
                            <div class="review_story">
                                <strong class="tit_story">을지로입구역 근처 점심 양곰탕 맛집 , 부민옥</strong>
                                <p class="txt_story">부민옥 서울특별시 중구 다동길 24-12 ?서울시 선정 오래가게? 오래가게는 서울에서 30년 이상 역사와 전통을 이어가는 가게로 ‘오래된, 그리고 더 오래가길 바라는 가게’라는 의미를 담고 있습니다. 서울시는 도시의 옛 문화를 간직한 오래된 가게를 국내외 관광객에게 소개하고자 역사성, 관광매력도 등을 기준으로 오래가게를 선정합니다. ?️주차불가 오랜만에 부민옥! 북엇국 먹으러 왔다가 줄이 길어 부민옥으로~! 양 부위를 좋아하신다면 양곰탕 추천드리고 즐기지 않으시면 육개장 드시길!! 멸치볶음 김치 깍두기 양곰탕(12,000원) 파 잔뜩 올리간 곰탕 어쩌면 슴슴하다고 생각하실 수 있지만 소금과 후추가 준비되어 있으니 기호에 맞게 즐기시길 양을 많이 주는 부민옥 부들부들 야들야들 후들후들 맛있다? 맛점하세</p>
                            </div>
                        </a>
                        <span class="info_user">
                            <span class="txt_user">은술랭로드</span>
                            <span class="bg_bar">|</span>
                            <span class="txt_date">2024.11.11.</span>
                        </span>
                        <span class="frame_g"></span>
                    </li>
                    <li data-id="72700811" class="story_type2">
                        <!-- 타이틀(클래스 tit_story)이 2줄 일 때 story_type2 추가 -->
                        <a href="http://blog.naver.com/ggam614/223648792230" target="_blank" class="link_review" data-logtarget="" data-logevent="review,list6">
                            <div class="review_thumb exist_img">
                                    <span class="item_photo" style="background-image:url('//img1.kakaocdn.net/cthumb/local/C204x110.q50/?fname=https%3A%2F%2Fpostfiles.pstatic.net%2FMjAyNDEwMjRfMjQx%2FMDAxNzI5NzI1NTA4NTEx.CYpypsB7ayIA1K2qDOz-OLgGL09pZz8GoIZUlyg8iNMg.SFcNblqX9wU_jsnMVFu-yikXxYxae2TkiM3TE0AIl7kg.PNG%2F%25EA%25B7%25B8%25EB%25A6%25BC2.png%3Ftype%3Dw966')"></span>
                                    <span class="frame_g"></span>
                            </div>
                            <div class="review_story">
                                <strong class="tit_story">[을지로 맛집 추천] 부민옥(+양무침과 육개장 까지)</strong>
                                <p class="txt_story">이제 조금은 아침 저녁으로 쌀쌀한 날씨가 되었네요. 쌀쌀한 날씨에는 뜨끈한 국물이 땡기는 것은 당연지사겠죠? 오늘은 을지로 쪽으로 외근을 나와 동료들과 뜨끈한 육개장 한그릇을 하기로 했어요. 부민옥 부민옥은 이미 을지로에서 맛집으로도 유명하고 특히 육개장과 양무침이 어마무시하게 유명한 집이라고 소문이 자자하더라구요. 바로 달려가보았습니다. 부민옥 서울특별시 중구 다동길 24-12 위치는 을지로입구역 1-1번 출구 쪽 뒷골목 음식점들이 모인 공간에 위치해있어요 들어가는 입구에서는 안에가 작지 않을까 싶었는데 그런걱정은 전혀 없네요. 엄청나게 넓은 공간으로 구성되어 있습니다. (특별히 웨이팅을 걱정하실 필요는 없을듯!) 점심시간이라 그런지 이미 많은 분들이 식사 중이셨고 꽤나 사람이 많은 것으로 보니 맛집이 맞</p>
                            </div>
                        </a>
                        <span class="info_user">
                            <span class="txt_user">꿈벅</span>
                            <span class="bg_bar">|</span>
                            <span class="txt_date">2024.11.06.</span>
                        </span>
                        <span class="frame_g"></span>
                    </li>
            </ul>

                <a href="#none" data-moreid="72700811" class="link_more">
                    <!-- 리뷰 접기: link_close 추가-->
                    <span class="txt_more">리뷰 더보기</span>
                    <span class="ico_comm ico_more"></span>
                </a>
        </div>
</div>

        <div data-viewid="findway" data-root="" class="cont_findway">
    <h3 class="tit_subject">찾아가는 길</h3>
    <div class="findway_map">
        <h4 class="screen_out">지도 보기</h4>
        <div class="view_map" id="map" style="overflow: hidden; background: url(&quot;https://t1.daumcdn.net/mapjsapi/images/bg_tile.png&quot;);"><div style="position: absolute; left: 0px; top: 0px; width: 100%; height: 100%; touch-action: none; cursor: url(&quot;https://t1.daumcdn.net/mapjsapi/images/cursor/openhand.cur.ico&quot;) 7 5, url(&quot;https://t1.daumcdn.net/mapjsapi/images/cursor/openhand.cur.ico&quot;), default;"><div style="position: absolute; left: 164px; top: -72px;"><div style="position: absolute; z-index: 0;"></div><div style="position: absolute; z-index: 1; left: 0px; top: 0px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/499/221.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -329px; top: 192px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/499/222.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -73px; top: 192px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/499/223.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 183px; top: 192px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/499/224.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 439px; top: 192px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/500/221.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -329px; top: -64px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/500/222.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -73px; top: -64px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/500/223.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 183px; top: -64px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/500/224.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 439px; top: -64px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/501/221.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -329px; top: -320px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/501/222.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: -73px; top: -320px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/501/223.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 183px; top: -320px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"><img src="https://mts.daumcdn.net/api/v1/tile/PNGSD02/v04_3zpx5/latest/5/501/224.png" alt="" draggable="false" style="position: absolute; user-select: none; -webkit-user-drag: none; min-width: 0px; min-height: 0px; max-width: none; max-height: none; left: 439px; top: -320px; opacity: 1; transition-property: opacity; transition-duration: 0.2s; transition-timing-function: ease; width: 256px; height: 256px;"></div><div style="position: absolute; z-index: 1;"></div><div style="width: 638px; height: 258px; position: absolute; z-index: 1;"></div><div style="position: absolute; z-index: 1;"><svg version="1.1" style="stroke: none; stroke-dashoffset: 0.5; stroke-linejoin: round; fill: none; transform: translateZ(0px); position: absolute; left: -1440px; top: -444px; width: 3190px; height: 1290px;" viewBox="0 0 3190 1290"><defs></defs></svg></div><div style="position: absolute; z-index: 1; width: 100%; height: 0px; transform: translateZ(0px);"><div style="position: absolute; margin: -48px 0px 0px -17px; z-index: 999; left: 160px; top: 193px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(0px, 66px, 50px, 30px); top: 0px; left: -30px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 170px; top: 231px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 176px; top: 231px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 163px; top: 238px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 158px; top: 146px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 209px; top: 190px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 217px; top: 187px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 218px; top: 180px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 95px; top: 193px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 127px; top: 256px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div><div style="position: absolute; margin: -17px 0px 0px -15px; z-index: 0; left: 94px; top: 166px;"><img draggable="false" src="//t1.daumcdn.net/localimg/localimages/07/2018/pc/rtn/ico_findway.png" alt="" role="presentation" title="" style="min-width: 0px; min-height: 0px; max-width: 99999px; max-height: none; border: 0px; display: block; position: absolute; user-select: none; -webkit-user-drag: none; clip: rect(30px, 30px, 60px, 0px); top: -30px; left: 0px; width: 70px; height: 70px;"></div></div></div></div><div style="position: absolute; cursor: default; z-index: 1; margin: 0px 6px; height: 19px; line-height: 14px; bottom: 0px; color: rgb(0, 0, 0); right: 0px;"><div style="color: rgb(0, 0, 0); text-align: center; font-size: 10px; float: right;"><div style="float: left; margin: 2px 3px 0px 4px; height: 6px; transition: width 0.1s; border-top: none rgb(0, 0, 0); border-right: 2px solid rgb(0, 0, 0); border-bottom: 2px solid rgb(0, 0, 0); border-left: 2px solid rgb(0, 0, 0); border-image: initial; width: 58px;"></div><div style="float: left; margin: 0px 4px 0px 0px; font-family: AppleSDGothicNeo-Regular, 돋움, dotum, sans-serif; font-weight: bold; color: rgb(0, 0, 0);">250m</div></div><div style="margin: 0px 4px; float: right;"><a target="_blank" href="http://map.kakao.com/" style="float: left; width: 32px; height: 10px;"><img src="https://t1.daumcdn.net/mapjsapi/images/m_bi_b.png" alt="Kakao 맵으로 이동(새창열림)" style="float: left; width: 32px; height: 10px; border: none;"></a><div style="font: 11px / 11px Arial, Tahoma, Dotum, sans-serif; float: left;"></div></div></div><div style="cursor: auto; position: absolute; z-index: 2; left: 0px; top: 0px;"></div></div><!-- 지도 영역 입니다. -->
        <strong class="screen_out">지도 보기 탭 메뉴</strong>
        <ul class="tab_map">
            <li class="on"><a href="#none" class="link_tab link_mapview" data-logtarget="" data-logevent="waytogo,2D_view">지도뷰</a></li>
            <li><a href="#none" class="link_tab link_skyview" data-logtarget="" data-logevent="waytogo,sky_view">스카이뷰</a></li>
        </ul>
        <div class="map_control">
            <div class="bg_control bg_zoomin link_control">
                <a href="#none" class="ico_comm ico_zoomin" data-logtarget="" data-logevent="waytogo,zoomin">확대하기</a>
            </div>
            <div class="bg_control bg_zoomout link_control">
                <a href="#none" class="ico_comm ico_zoomout" data-logtarget="" data-logevent="waytogo,zoomout">축소하기</a>
            </div>
            <div class="bg_control bg_refresh link_control">
                <a href="#none" class="ico_comm ico_refresh" data-logtarget="" data-logevent="waytogo,refresh">새로고침</a>
            </div>
            <div class="bg_control bg_full">
                <a href="https://map.kakao.com?urlX=495653&amp;urlY=1129991&amp;urlLevel=3&amp;itemId=1346301870&amp;q=%EB%B6%80%EB%AF%BC%EC%98%A5&amp;map_type=TYPE_MAP" target="_blank" class="ico_comm ico_full" data-logtarget="" data-logevent="waytogo,largeview">전체화면</a>
            </div>
        </div>
        <!-- 
        <div class="map_control">
            <a href="#none" class="link_control" data-logtarget data-logevent="waytogo,zoomin"><span class="ico_comm ico_zoomin">확대하기</span></a>
            <a href="#none" class="link_control" data-logtarget data-logevent="waytogo,zoomout"><span class="ico_comm ico_zoomout">축소하기</span></a>
            <a href="#none" class="link_control" data-logtarget data-logevent="waytogo,refresh"><span class="ico_comm ico_refresh">새로고침</span></a>
        </div>
        <a href="https://map.kakao.com?urlX=495653&urlY=1129991&urlLevel=3&itemId=1346301870&q=%EB%B6%80%EB%AF%BC%EC%98%A5&map_type=TYPE_MAP" target="_blank" class="link_full" data-logtarget data-logevent="waytogo,largeview"><span class="ico_comm ico_full">전체화면</span></a>
        -->
    </div>
        <div class="station_wayout">
            <h4 class="tit_findway">지하철역</h4>
            <ul class="list_wayout">
                    <li>
                        <em class="txt_station"><a href="https://map.kakao.com?subwayId=SES0202" target="_blank" class="link_station" data-logtarget="" data-logevent="waytogo,subway">을지로입구역</a></em>
                            <span class="ico_traffic seoul_line2_small">2호선</span><!-- 호선별 대체 텍스트 부탁 드립니다. -->
                        <span class="bg_bar">|</span>
                        <span class="txt_wayout"><span class="num_wayout">1-1</span>번 출구 <span class="num_wayout txt_walk">도보 6분</span></span>
                    </li>
                    <li>
                        <em class="txt_station"><a href="https://map.kakao.com?subwayId=SES0151" target="_blank" class="link_station" data-logtarget="" data-logevent="waytogo,subway">시청역</a></em>
                            <span class="ico_traffic seoul_line1_small">1호선</span><!-- 호선별 대체 텍스트 부탁 드립니다. -->
                            <span class="ico_traffic seoul_line2_small">2호선</span><!-- 호선별 대체 텍스트 부탁 드립니다. -->
                        <span class="bg_bar">|</span>
                        <span class="txt_wayout"><span class="num_wayout">4</span>번 출구 <span class="num_wayout txt_walk">도보 6분</span></span>
                    </li>
                    <li>
                        <em class="txt_station"><a href="https://map.kakao.com?subwayId=SES0152" target="_blank" class="link_station" data-logtarget="" data-logevent="waytogo,subway">종각역</a></em>
                            <span class="ico_traffic seoul_line1_small">1호선</span><!-- 호선별 대체 텍스트 부탁 드립니다. -->
                        <span class="bg_bar">|</span>
                        <span class="txt_wayout"><span class="num_wayout">5</span>번 출구 <span class="num_wayout txt_walk">도보 9분</span></span>
                    </li>
                    <li>
                        <em class="txt_station"><a href="https://map.kakao.com?subwayId=SES2534" target="_blank" class="link_station" data-logtarget="" data-logevent="waytogo,subway">광화문역</a></em>
                            <span class="ico_traffic seoul_line5_small">5호선</span><!-- 호선별 대체 텍스트 부탁 드립니다. -->
                        <span class="bg_bar">|</span>
                        <span class="txt_wayout"><span class="num_wayout">5</span>번 출구 <span class="num_wayout txt_walk">도보 9분</span></span>
                    </li>
            </ul>
        </div>
        <div class="station_ride check_list">
            <h4 class="tit_findway">버스정류장</h4>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=BS326546" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">서울시청/을지로입구</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02100) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 155m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_metroplice">광역</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">M4108<span class="bg_bar">|</span>M4130<span class="bg_bar">|</span>M4137<span class="bg_bar">|</span>M5107<span class="bg_bar">|</span>M5115<span class="bg_bar">|</span>M5121</span>
                                    <a href="https://map.kakao.com?busStopId=BS326546" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_circle">순환</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">TOUR11</span>
                                    <a href="https://map.kakao.com?busStopId=BS326546" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_direct">직행</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">3201<span class="bg_bar">|</span>4101<span class="bg_bar">|</span>4103<span class="bg_bar">|</span>4108<span class="bg_bar">|</span>8800<span class="bg_bar">|</span>8800<span class="txt_bustype">(예약)</span><span class="bg_bar">|</span>9007<span class="bg_bar">|</span>P9110<span class="txt_bustype">(출근)(예약)</span><span class="bg_bar">|</span>P9211<span class="txt_bustype">(출근)</span><span class="bg_bar">|</span>P9211<span class="txt_bustype">(퇴근)</span></span>
                                    <a href="https://map.kakao.com?busStopId=BS326546" target="_blank" class="btn_more" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=11020521018" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">을지로입구.시청입구</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02157) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 164m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_blue">간선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">172<span class="bg_bar">|</span>400<span class="bg_bar">|</span>472<span class="bg_bar">|</span>500<span class="bg_bar">|</span>504<span class="bg_bar">|</span>N62<span class="txt_bustype">(심야)</span><span class="bg_bar">|</span>N73<span class="txt_bustype">(심야)</span></span>
                                    <a href="https://map.kakao.com?busStopId=11020521018" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_green">지선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">8101<span class="txt_bustype">(출근)</span></span>
                                    <a href="https://map.kakao.com?busStopId=11020521018" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=BS513729" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">을지로입구역롯데호텔</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02639) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 181m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_airport">공항</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">6701<span class="bg_bar">|</span>N6701<span class="txt_bustype">(심야)</span></span>
                                    <a href="https://map.kakao.com?busStopId=BS513729" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=11010611039" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">서린동.SK서린빌딩</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(01173) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 192m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_green">지선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">7018</span>
                                    <a href="https://map.kakao.com?busStopId=11010611039" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=12010631026" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">을지로입구역.광교</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02246) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 197m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_blue">간선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">151<span class="bg_bar">|</span>162<span class="bg_bar">|</span>173<span class="bg_bar">|</span>201<span class="bg_bar">|</span>262<span class="bg_bar">|</span>506<span class="bg_bar">|</span>702A서오릉<span class="bg_bar">|</span>702B용두초교<span class="bg_bar">|</span>705<span class="bg_bar">|</span>N15<span class="txt_bustype">(심야)</span><span class="bg_bar">|</span>N31<span class="txt_bustype">(심야)</span><span class="bg_bar">|</span>N62<span class="txt_bustype">(심야)</span></span>
                                    <a href="https://map.kakao.com?busStopId=12010631026" target="_blank" class="btn_more" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_metroplice">광역</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">M4101<span class="bg_bar">|</span>M4102</span>
                                    <a href="https://map.kakao.com?busStopId=12010631026" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_direct">직행</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">1101<span class="bg_bar">|</span>1150<span class="bg_bar">|</span>5007<span class="bg_bar">|</span>8100<span class="bg_bar">|</span>9003<span class="bg_bar">|</span>9300<span class="bg_bar">|</span>9301</span>
                                    <a href="https://map.kakao.com?busStopId=12010631026" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=11020521019" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">우리은행종로지점</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02139) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 232m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_blue">간선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">103<span class="bg_bar">|</span>143<span class="bg_bar">|</span>151<span class="bg_bar">|</span>162<span class="bg_bar">|</span>172<span class="bg_bar">|</span>173<span class="bg_bar">|</span>201<span class="bg_bar">|</span>262<span class="bg_bar">|</span>401<span class="bg_bar">|</span>406<span class="bg_bar">|</span>701<span class="bg_bar">|</span>704<span class="bg_bar">|</span>N15<span class="txt_bustype">(심야)</span><span class="bg_bar">|</span>N31<span class="txt_bustype">(심야)</span><span class="bg_bar">|</span>N62<span class="txt_bustype">(심야)</span></span>
                                    <a href="https://map.kakao.com?busStopId=11020521019" target="_blank" class="btn_more" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_green">지선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">7017<span class="bg_bar">|</span>7021<span class="bg_bar">|</span>7022</span>
                                    <a href="https://map.kakao.com?busStopId=11020521019" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_metroplice">광역</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">9401</span>
                                    <a href="https://map.kakao.com?busStopId=11020521019" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_direct">직행</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">1101<span class="bg_bar">|</span>5500-2<span class="bg_bar">|</span>9000<span class="bg_bar">|</span>9000-1<span class="txt_bustype">(출근)</span><span class="bg_bar">|</span>9200<span class="bg_bar">|</span>G8110</span>
                                    <a href="https://map.kakao.com?busStopId=11020521019" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=BS546088" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">광교</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02136) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 238m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_metroplice">광역</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">M5107<span class="bg_bar">|</span>M5115<span class="bg_bar">|</span>M5121</span>
                                    <a href="https://map.kakao.com?busStopId=BS546088" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_direct">직행</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">5007<span class="bg_bar">|</span>8800</span>
                                    <a href="https://map.kakao.com?busStopId=BS546088" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=BS116825" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">프레스센터</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02507) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 261m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_blue">간선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">402<span class="bg_bar">|</span>709<span class="bg_bar">|</span>N75<span class="txt_bustype">(심야)</span></span>
                                    <a href="https://map.kakao.com?busStopId=BS116825" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_airport">공항</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">6701</span>
                                    <a href="https://map.kakao.com?busStopId=BS116825" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_normal">일반</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">799</span>
                                    <a href="https://map.kakao.com?busStopId=BS116825" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_town">마을</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">종로09<span class="bg_bar">|</span>종로11</span>
                                    <a href="https://map.kakao.com?busStopId=BS116825" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=BS292357" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">서울광장</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02641) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 284m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_blue">간선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">172<span class="bg_bar">|</span>405<span class="bg_bar">|</span>472<span class="bg_bar">|</span>N62<span class="txt_bustype">(심야)</span><span class="bg_bar">|</span>N73<span class="txt_bustype">(심야)</span></span>
                                    <a href="https://map.kakao.com?busStopId=BS292357" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_direct">직행</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">P9110<span class="txt_bustype">(퇴근)(예약)</span></span>
                                    <a href="https://map.kakao.com?busStopId=BS292357" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
                <div class="ride_wayout"><!-- 지도에서 일치하는 정류장에 마우스 오버 했을 때 클래스 ride_on 추가 -->
                    <strong class="tit_wayout">
                        <a href="https://map.kakao.com?busStopId=11020521015" class="link_wayout" target="_blank" data-logtarget="" data-logevent="waytogo,busstop">
                            <span class="txt_busstop">시청.서울신문사</span>
                            <span class="txt_number"><span class="screen_out">정류장 번호: </span>(02137) <span class="bg_bar">|</span> <span class="screen_out">거리: </span> 287m</span>
                        </a>
                    </strong>
                    <ul class="list_ride">
                            <li>
                                <em class="ico_traffic bus_blue">간선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">101<span class="bg_bar">|</span>150<span class="bg_bar">|</span>501<span class="bg_bar">|</span>506<span class="bg_bar">|</span>708<span class="bg_bar">|</span>N51<span class="txt_bustype">(심야)</span></span>
                                    <a href="https://map.kakao.com?busStopId=11020521015" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_green">지선</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">1711<span class="bg_bar">|</span>7016</span>
                                    <a href="https://map.kakao.com?busStopId=11020521015" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_circle">순환</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">01A</span>
                                    <a href="https://map.kakao.com?busStopId=11020521015" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                            <li>
                                <em class="ico_traffic bus_airport">공항</em><!-- 버스 선별로 대체 텍스트 부탁 드립니다. -->
                                <div class="bus_ride">
                                    <span class="num_ride">6005</span>
                                    <a href="https://map.kakao.com?busStopId=11020521015" target="_blank" class="btn_more hide" data-logtarget="" data-logevent="waytogo,busstop_more"><span class="ico_comm ico_more">더보기</span></a>
                                </div>
                            </li>
                    </ul>
                </div>
        </div>
        <p class="txt_caution"><span class="ico_comm ico_dot"></span>버스방면정보를 확인하세요</p>
</div>
        <div id="photoList" class="map_layer hide"></div>
        <div id="roughMap" class="map_layer hide">
    <iframe data-id="frame" frameborder="0" border="0" class="frame" src="" style="width: 1017px; height: 693px;"></iframe>
</div>

        <social-share class="news_share_container" id="news_share_container" hidden=""></social-share>
        <div data-viewid="fiyLayer" data-root="" id="fiyModalLayer" style="display:none">
    <div class="fiy_wrap">
        <iframe frameborder="0" border="0" class="fiyFrame" src=""></iframe>
    </div>
    <div class="modal_bg"></div>
</div>
        <div data-viewid="commentLayer" data-root="" class="evaluation_layer" style="display: none">
  <div class="inner_layer">
    <div class="layer_head"><strong class="tit_layer">부민옥</strong></div>
      <div class="layer_body">
        <form action="#">
          <fieldset>
            <legend class="screen_out">후기작성</legend>
            <div class="group_rate">
              <div class="grade_rate">
                <div class="grade_star size_l">
                  <span class="ico_star star_rate">
                    <span class="ico_star inner_star" style="width:0%"></span>
                  </span>
                </div>
              </div>
              <span class="info_rate">
                <span class="screen_out">선택한 별점</span>
                <span class="num_rate">0</span>/<span class="screen_out">선택 가능한 총 별점</span><span class="num_limit">5</span>
              </span>
            </div>
            <div class="group_like"> <strong class="tit_group">이 장소의 추천포인트는?<span class="txt_guide">(중복선택 가능)</span></strong>
              <div class="box_like">
                  <button type="button" class="btn_like" data-name="맛" data-id="5">
                    <span class="txt_like">맛</span><span class="ico_comm ico_like2"></span>
                  </button>
                  <button type="button" class="btn_like" data-name="가성비" data-id="1">
                    <span class="txt_like">가성비</span><span class="ico_comm ico_like2"></span>
                  </button>
                  <button type="button" class="btn_like" data-name="친절" data-id="2">
                    <span class="txt_like">친절</span><span class="ico_comm ico_like2"></span>
                  </button>
                  <button type="button" class="btn_like" data-name="분위기" data-id="3">
                    <span class="txt_like">분위기</span><span class="ico_comm ico_like2"></span>
                  </button>
                  <button type="button" class="btn_like" data-name="주차" data-id="4">
                    <span class="txt_like">주차</span><span class="ico_comm ico_like2"></span>
                  </button>
              </div>
            </div>
            <div class="box_evaluation">
              <div class="group_revisit">
                <p class="desc_revisit">재방문 의사가 있습니까?</p>
                <button type="button" class="btn_like"><span class="ico_comm ico_check2"></span><span class="txt_like">네</span></button>
              </div>
              <div class="group_review">
                <label for="tfReview" class="screen_out">후기 작성</label>
                <textarea id="tfReview" name="tf_review" class="tf_review" placeholder="작성내용은 마이페이지와 장소상세에 노출되며 매장주를 포함한 다른 사용자들이
볼 수 있으니, 서로를 배려하는 마음을 담아 작성해 주세요."></textarea>
              </div>
              <div class="group_upload">
                <span class="thumb_upload">
                  <label for="imgUpload" class="lab_upload">사진 등록하기</label>
                  <input type="file" id="imgUpload" name="imgUpload" class="inp_upload" accept="image/jpeg, image/png">
                </span>
              </div>
              <div class="group_etc">
                <a href="https://kakaomap.tistory.com/358" target="_blank" class="link_notice">후기 작성 시 주의사항</a>
                <span class="num_letter">
                  <span class="screen_out">등록한 글자수: </span><span class="txt_len">0</span><span class="num_total"> / 2000</span></span>
                
              </div>
            </div>
            <div class="group_btn">
              <button type="reset" class="btn_reset">취소</button>
              <button type="submit" class="btn_submit">등록</button>
            </div>
          </fieldset>
        </form>
      </div>
    </div>
  </div>
</div>

    </div>

<hr class="hide">
<div data-viewid="footer" data-root="" id="kakaoFoot" class="footer_mapdetail" role="contentinfo">
    <div class="inner_mapdetail">
        <h2 class="screen_out">서비스 이용정보</h2>
        <a href="http://policy.daum.net/info/info" class="link_info" target="_blank" data-logtarget="" data-logevent="footer,term">서비스 약관/정책</a>
        <span class="bg_bar"></span>
        <a href="https://cs.kakao.com/requests?locale=ko&amp;service=101" class="link_info" target="_blank" data-logtarget="" data-logevent="footer,service">고객센터</a>
        <span class="bg_bar"></span>
        <a href="https://cs.daum.net/redbell/top.html" class="link_info" target="_blank" data-logtarget="" data-logevent="footer,report">권리침해 신고</a>
        <span class="bg_bar"></span>
        <a href="http://kakaomap.tistory.com/category/%EC%95%8C%EB%A6%BD%EB%8B%88%EB%8B%A4/%EC%97%85%EB%8D%B0%EC%9D%B4%ED%8A%B8" target="_blank" class="link_info" data-logtarget="" data-logevent="footer,notice">공지사항<!--<span class="ico_comm ico_new">새글</span>--></a>
                <span class="bg_bar"></span>
                    <a href="#" data-id="fiyBtn" data-fiytype="detail" data-logtarget="" data-logevent="main_info,FIY" class="link_info">정보 수정 제안</a>
        <small class="txt_copyright">Copyright © <a href="https://www.kakaocorp.com/page/" class="link_kakao" target="_blank">Kakao Corp.</a> All rights reserved.</small>
    </div>
</div>
<!-- 스크롤이 내려 왔을 때 클래스 lbar_on  -->
        <div id="wrapMinidaum"></div>
    </div>
    <div id="daumWrap" style="display:none;">
        <div id="daumContent">
            <div id="shareContainer"></div>
        </div>
    </div>
    <script type="text/javascript" src="//ssl.daumcdn.net/dmaps/map_js_init/v3.js"></script><script src="https://t1.daumcdn.net/mapjsapi/js/main/4.4.19/v3.js"></script>
    <script type="text/javascript" src="//t1.daumcdn.net/tiara/js/v1/tiara.min.js"></script>
    <script type="text/javascript" src="//t1.kakaocdn.net/kakao_js_sdk/2.7.2/kakao.min.js"></script>
    <script type="text/javascript" src="//t1.daumcdn.net/daumtop_deco/socialshare/socialshare-3.0.0.min.js"></script>
    <script>
        window.ENV = 'PROD';
        window.browserversion = 'chrome131';
        
        // 티아라 초기화
        try {
            TiaraTracker.getInstance().init({
                svcDomain: 'place.map.kakao.com',
                deployment: window.ENV === 'PROD' ? 'production' : 'dev'
            });
        } catch(e) {}
        window.placeRestrictType = 'NONE'
        window._cp = '';
        window.msaConfigChain = '949d0d4414084edab1da3bd7e8c522c2|5664';
    </script>
    
        
            <script type="text/javascript" src="https://t1.daumcdn.net/kakaomapweb/place/lib/Chart_2.4.0.min.js"></script>
            <script type="text/javascript" src="//t1.daumcdn.net/kakaomapweb/place/jscss/pc.fcbf3bfe.js"></script><iframe src="mapclick.html?_=1733894412344" style="position: absolute; left: 0px; top: 0px; width: 0px; height: 0px; border: 0px;"></iframe>
        
    
    <!--
    <script>
        var minidaum_options = {
            disableTracker: true, // 미니다음에서 tiara 사용안함
            bgType: "white",
            enableLogoutRetun: true,
            returnUrl: '',
            disableHotissue: true,
            disableLogo:true,
            enableShield: false
        };
    </script>
    <script async src="//go.daum.net/jsa_minidaum_pc.daum" charset="utf-8" type="text/javascript"></script>
    -->


</body>
</body>
</html>