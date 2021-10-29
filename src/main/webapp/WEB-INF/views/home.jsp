<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html>
<head>
	
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/main.css">
	<link rel="shortcut icon" type="image/x-icon" href="${ pageContext.request.contextPath }/resources/img/icon.jpg"/>
	
	
	<title>Cinema</title>	
</head>
<body>
	
	<div id="moviewrap">
		<!-- header -->
		<div id="header">
			<div class="main_bg"><img src="${ pageContext.request.contextPath }/resources/img/main_bg.png"></div>
			<div class="gnb">
				<ul>
			<c:if test="${empty sessionScope.user}">
					<li><a href="login_form.do?seat=0">로그인</a></li>
					<li><a href="register_form.do">회원가입</a></li>
			</c:if>
			
			<c:if test="${not empty sessionScope.user }">
					<li style='color:white;'><span style='font-weight: bold;'>${ sessionScope.user.name }</span> 님 환영합니다.</li>
					<li><a href="logout.do">로그아웃</a></li>
					<li><a href="mypage.do?l_idx=${ sessionScope.user.l_idx }">마이페이지</a></li>
			</c:if>
				</ul>
			</div>
			<div class="nav">
				<h1 id="nav_left"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></h1>
				<h2><img src="${ pageContext.request.contextPath }/resources/img/nav_logo.png"></h2>
				<ul>
					<li><a href="movieReleaseList.do">영화</a></li>
					<li><a href="ticketing.do">예매</a></li>
					<li><a href="location.do">영화관</a></li>
					<li><a href="review.do">커뮤니티</a></li>				
				</ul>
				<h1 id="nav_right"><img src="${ pageContext.request.contextPath }/resources/img/logo_test2.png"></h1>
				
			</div>
			
		</div>
		<!-- header 끝 -->
		
		<!-- contents 1 -->
		<div id="movie_list">
			<div class="m_list_bg"><img src="${ pageContext.request.contextPath }/resources/img/m_list_bg.png"></div>
			<div class="main_movie_list">
				<p>상영 영화 안내</p>
				<ul>
					<li>
						<img src="${ pageContext.request.contextPath }/resources/img/main_poster1.jpg">
						<div class="h_info">
							<a href="movieInfoDetailRank.do?releaseDts=20171220&title=위대한%20쇼맨&trailer=https://www.youtube.com/embed/cnIOq6P8PUU"><p>
								불가능한 꿈, 그 이상의 쇼!<br>
								<br>
								쇼 비즈니스의 창시자이자, 꿈의 무대로 전세계를 매료시킨 남자 ‘바넘’의 이야기에서 영감을 받아 탄생한 오리지널 뮤지컬 영화 <위대한 쇼맨>. 
								<레미제라블> 이후 다시 뮤지컬 영화로 돌아온 휴 잭맨부터 잭 에프론, 미셸 윌리엄스, 레베카 퍼거슨, 젠다야까지 할리우드 최고의 배우들이 합류해 환상적인 앙상블을 선보인다.
								여기에 <미녀와 야수> 제작진과 <라라랜드> 작사팀의 합류로 더욱 풍성해진 비주얼과 스토리, 음악까지 선보일 <위대한 쇼맨>은 ‘우리는 누구나 특별하다’는 메시지로 관객들에게 재미는 물론, 감동까지 선사할 것이다.<br>
								THIS IS ME! 우리는 누구나 특별하다!
							</p></a>
						</div>
						<div class="case"><a href="ticketing.do?m_name=위대한 쇼맨">예 매</a></div>
						<div class="like"><a href="#">Like</a></div>
					</li>
					<li>
						<img src="${ pageContext.request.contextPath }/resources/img/main_poster2.jpg">
						<div class="h_info">
							<a href="movieInfoDetailRank.do?releaseDts=20200520&title=카페%20벨에포크&trailer=https://www.youtube.com/embed/HRf5kRhfKrM"><p>
								1분 1초 설레며, 24시간 사랑했던
								내 인생 가장 찬란했던 순간으로 돌아갈 수 있다면?
								<br>
								<br>
								행복했던 그때 그 모든 것이 그리워진 ‘빅토르’는
								100% 고객 맞춤형 핸드메이드 시간여행의 설계자 ‘앙투안’의 초대로
								하룻밤의 시간여행을 떠난다.
								그의 눈 앞에 마법처럼 펼쳐진 ‘카페 벨에포크’에서
								‘빅토르’는 꿈에 그리던 첫사랑과 재회하게 되는데...
							</p></a>
						</div>
						<div class="case"><a href="ticketing.do?m_name=카페 벨에포크">예 매</a></div>
						<div class="like"><a href="#">Like</a></div>
					</li>
					<li>
						<img src="${ pageContext.request.contextPath }/resources/img/main_poster3.jpg">
						<div class="h_info">
							<a href="movieInfoDetailRank.do?releaseDts=20200506&title=프리즌%20이스케이프&trailer=https://www.youtube.com/embed/KYXPiPohZw0"><p>
								404일의 감금, 나가야 할 문은 15개!<br>
								성공률 0%의 탈옥이 시작된다!<br>
								<br>
								인권운동가 ‘팀’과 ‘스티븐’은 억울한 판결로 투옥된다.
								둘은 불의에 굴복하지 않고 탈출을 결심한다.
								나가기 위해 열어야 할 강철 문은 15개!
								그들은 나뭇조각으로 열쇠를 만들기 시작하고,
								지금껏 아무도 성공한 적 없는 0%의 확률 속에서
								목숨을 건 단 한 번의 기회를 노리는데…
							</p></a>
						</div>
						<div class="case"><a href="ticketing.do?m_name=프리즌 이스케이프">예 매</a></div>
						<div class="like"><a href="#">Like</a></div>
					</li>
					<li>
						<img src="${ pageContext.request.contextPath }/resources/img/main_poster4.jpg">
						<div class="h_info">
							<a href="movieInfoDetailRank.do?releaseDts=20200527&title=미스비헤이비어&trailer=https://www.youtube.com/embed/Zg3wm2ELgvA"><p>
								“왕관을 거부한 유쾌한 반란”<br>
								<br>
								우리는 예쁘지도 추하지도 않다! 우리는 화가 났을 뿐!
								여자라는 이유만으로 학계에서 무시당하지만
								실력으로 이기겠다는 여성 운동가이자 역사가 ‘샐리’(키이라 나이틀리)
								성적 대상화의 주범 미스월드에
								한 방 먹일 작전을 짠 페미니스트 예술가 ‘조’(제시 버클리)
								역사상 최초의 미스 그레나다로서
								흑인 아이들에게 희망을 전하고 싶은 ‘제니퍼’(구구 바샤-로)
								1970년, 달 착륙과 월드컵 결승보다 더 많은 1억 명이 지켜본 ‘미스월드’
								성적 대상화를 국민 스포츠로 만든 미스월드에 맞서
								자신의 스타일대로 진정한 자유를 외친 여성들의 유쾌한 반란이 시작된다!
							</p></a>
						</div>
						<div class="case"><a href="ticketing.do?m_name=미스비헤이비어">예 매</a></div>
						<div class="like"><a href="#">Like</a></div>
					</li>
				</ul>			
						<div class="mouse"><img src="${ pageContext.request.contextPath }/resources/img/mouse_white.png"></div>
			</div>		
		</div>
		
		<!-- contents 2 -->
		<div id="contents">
			<div class="main_teaser">
				<p>Recommend</p>
				<div class="poster"><img src="${ pageContext.request.contextPath }/resources/img/main_movie_poster.jpg"></div>
				<div class="t_video">
					<iframe width="750" height="500" src="https://www.youtube.com/embed/iAKApms7jJk" 
						frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen>
					</iframe>
				</div>
				<div class="t_info">
					<p class="tit">톰보이</p>
					<p class="txt">
						새로 이사 온 아이, ‘미카엘’.				
						파란색을 좋아하고, 끝내주는 축구 실력과 유난히 잘 어울리는 짧은 머리로
						친구들을 사로잡는 그의 진짜 이름은 ‘로레’!
						눈물겹게 아름답고, 눈부시게 다정했던
						10살 여름의 비밀 이야기가 시작된다!
					 </p>
				</div>
			</div>
			
			<div class="main_editor">
				<p>Event</p>
				<ul>
					<li>
						<div class="pick_who">
							<p>민형's pick!</p>
						</div>
						<div class="pick_img">
							<img src="${ pageContext.request.contextPath }/resources/img/editor_pick_1.jpg">
						</div>
						<div class="pick_info">
							<span>#겨울왕국</span>
							<p>
								얼어붙은 세상을 녹일 자매가 온다!
								서로가 최고의 친구였던 자매 ‘엘사’와 ‘안나’. 
								하지만 언니 ‘엘사’에게는 하나뿐인 동생에게조차 말 못할 비밀이 있다. 
								모든 것을 얼려버리는 신비로운 힘이 바로 그것. 
								‘엘사’는 통제할 수 없는 자신의 힘이 두려워 왕국을 떠나고, 
								얼어버린 왕국의 저주를 풀기 위해 ‘안나’는 언니를 찾아 환상적인 여정을 떠나는데……
								</p>
						</div>
					</li>
					<li>
						<div class="pick_who">
							<p>성수's pick!</p>
						</div>						
						<div class="pick_img">
							<img src="${ pageContext.request.contextPath }/resources/img/editor_pick_2.jpg">
						</div>						
						<div class="pick_info">
							<span>#존 윅</span>
							<p>
								그를 건드리지 말았어야 했다
								상대를 잘못 고른 적들을 향한 통쾌한 복수!
								전설이라 불리던 킬러 ‘존 윅’(키아누 리브스)은 사랑하는 여인을 만나 결혼을 하면서 범죄의 세계에서 은퇴한다. 행복도 잠시, 투병 끝에 부인이 세상을 떠나고 그의 앞으로 부인이 죽기 전에 보낸 강아지 한 마리가 선물로 배달된다. 그러던 어느 날, 그의 집에 괴한들이 들이닥치는데…
								더 이상 잃을 것이 없다. 오직 너희만 죽인다!
								건드리지 말아야 할 그의 분노를 잘못 깨웠다.
								받은 것보다 더 돌려주는 통쾌한 복수, 존 윅의 거침없는 복수가 마침내 폭발한다!
							</p>
						</div>
					</li>
					<li>
						<div class="pick_who">
							<p>우성's pick!</p>
						</div>						
						<div class="pick_img">
							<img src="${ pageContext.request.contextPath }/resources/img/editor_pick_3.jpg">
						</div>
						<div class="pick_info">
							<span>#나는 내일, 어제의 너와 만난다.</span>
							<p>
								내일, 만날 수 있을까?
								어제의 너를-
								스무 살의 ‘타카토시’는 지하철에서 우연히 만난
								‘에미’를 보고 순식간에 마음을 빼앗긴다.
								운명 같은 끌림을 느낀 타카토시의 고백으로
								두 사람은 연인이 되고, 매일 만나 행복한 데이트를 한다.
								 
								하지만, 왠지 종종 의미를 알 수 없는 눈물을 보이던 에미로부터
								믿을 수 없는 비밀을 듣게 된 타카토시는 큰 혼란에 빠진다.
								 
								그 비밀은 바로 타카토시와 에미의 시간은 서로 반대로 흐르고 있고,
								교차되는 시간 속에서 함께 할 수 있는 시간은 오직 30일뿐이라는 것.
								 
								30일 후에도, 이 사랑은 계속될 수 있을까?
							</p>
						</div>
					</li>
					<li>
						<div class="pick_who">
							<p>선영's pick!</p>
						</div>						
						<div class="pick_img">
							<img src="${ pageContext.request.contextPath }/resources/img/editor_pick.jpg">
						</div>						
						<div class="pick_info">
							<span>#닥터스트레인지</span>
							<p>
								마블 히어로의 새로운 시작!
								모든 것을 초월한, 역사상 가장 강력한 히어로가 온다!
								불의의 사고로 절망에 빠진 천재 외과의사 ‘닥터 스트레인지(베네딕트 컴버배치)’.
								마지막 희망을 걸고 찾아 간 곳에서 ‘에인션트 원(틸다 스윈튼)’을 만나 세상을 구원할 강력한 능력을 얻게 되면서,
								모든 것을 초월한 최강의 히어로로 거듭나는데...
							 </p>
						</div>
					</li>
					<li>
						<div class="pick_who">
							<p>원경's pick!</p>
						</div>						
						<div class="pick_img">
							<img src="${ pageContext.request.contextPath }/resources/img/editor_pick_4.jpg">
						</div>						
						<div class="pick_info">
							<span>#인피니티 워</span>
							<p>
								새로운 조합을 이룬 어벤져스,
								역대 최강 빌런 타노스에 맞서 세계의 운명이 걸린
								인피니티 스톤을 향한 무한 대결이 펼쳐진다!
								 
								마블의 클라이맥스를 목격하라!
							</p>
						</div>
					</li>
					<li>
						<div class="pick_who">
							<p>유진's pick!</p>
						</div>						
						<div class="pick_img">
							<img src="${ pageContext.request.contextPath }/resources/img/editor_pick_6.gif">
						</div>						
						<div class="pick_info">
							<span>#인셉션</span>
							<p>
								타인의 꿈에 들어가 생각을 훔치는 특수 보안요원 코브.
								그를 이용해 라이벌 기업의 정보를 빼내고자 하는 사이토는
								코브에게 생각을 훔치는 것이 아닌, 생각을 심는 ‘인셉션’ 작전을 제안한다.
								성공 조건으로 국제적인 수배자가 되어있는 코브의 신분을 바꿔주겠다는
								거부할 수 없는 제안을 하고, 사랑하는 아이들에게 돌아가기 위해 그 제안을 받아들인다.
								최강의 팀을 구성, 표적인 피셔에게 접근해서 ‘인셉션’ 작전을 실행하지만
								예기치 못한 사건들과 마주하게 되는데…
								꿈 VS 현실
								시간, 규칙, 타이밍 모든 것이 완벽해야만 하는,
								단 한 번도 성공한 적 없는 ‘인셉션’ 작전이 시작된다!
							</p>
						</div>
					</li>
				</ul>
			</div>
		</div>
		<!-- contents 끝 -->

		<!-- footer -->
		<div id="footer">
			<div class="f_bg"><img src="${ pageContext.request.contextPath }/resources/img/footer_bg.png"></div>
			<div class="f_txt">
				<p class="f_logo"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></p>
				<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
				<p class="team1">2조 Spring Project Movie</p>
				<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
			</div>
		</div>
		<!-- footer 끝 -->
	</div>	
	
</body>
</html>
