<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>영화관 위치정보</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/user.css">
	
	<style>
		 body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat; 
       }
	  .field_form {width:80%; height:620px; position:relative; margin:50px auto;}
      .field_form > ul{width:100%; height:580; position:absolute; background:rgb(119, 119, 119, 0.5); border-radius:40px; }
      .field_form > ul > li {list-style:none; margin-top:30px; }
      .field_form h3 {width:300px; height:50px; background:rgb(255, 255, 255, 0.3); color:white; border-radius:20px; text-align:center; font-family: sans-serif; letter-spacing:1px; font-size:18px; font-weight:1.5em; line-height:50px; margin-bottom:20px;}
      .li1{float:left; width:55%; height:500px; margin-left:30px;}
      .li2{float:left; width:40%; height:500px; margin-left:30px; display:block;}
      .input_wrapper {float:left;}
      
      .find_way ul{ list-style:none; }
      .find_way p{width:90%; margin-left:10px; color:white; font-size:15px; font-family: sans-serif; letter-spacing:1px;}
      .find_way strong{ width:90%; color:white; margin-left:10px; font-size:17px; text-decoration:underline; letter-spacing:2px; line-height:50px; font-family: sans-serif;}
      
   
      #footer{ width:100%; height:200px; margin-top:920px;}
	</style>

</head>
<body>
	
	<div id="moviewrap">
		<jsp:include page="../header.jsp"/>
		<!-- header -->
			<%-- <div id="header" onclick="location.href='/movie/'">
				<div class="main_bg"><img src="${ pageContext.request.contextPath }/resources/img/main_bg.png"></div>
				<div class="gnb">
					<ul>
						<li><a href="login_form.do">로그인</a></li>
						<li><a href="register_form.do">회원가입</a></li>
					</ul>
				</div>
				<div class="nav">
					<h1 id="nav_left"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></h1>
					<h2><img src="${ pageContext.request.contextPath }/resources/img/nav_logo.png"></h2>
					<ul>
						<li><a href="movieReleaseList.do">영화</a></li>
						<li><a href="#">예매</a></li>
						<li><a href="#">영화관</a></li>
						<li><a href="review.do">커뮤니티</a></li>				
					</ul>
					<h1 id="nav_right"><img src="${ pageContext.request.contextPath }/resources/img/logo_test2.png"></h1>
				</div>
			</div> --%>
		<!-- header 끝 -->

		<div id="container">

			<div class="field_form">
				<ul>
					<li class="li1">
					<h3>NIGHT CINEMA 위치</h3>
							<div id="map" style="width: 800px; height: 400px;"></div>
							
							<!-- 카카오지도 API -->
							<script type="text/javascript"
								src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2c495537dfdb95fa59c9af35372bf3ca"></script>
							<script>
								var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
								mapOption = {
									center : new kakao.maps.LatLng(37.554480, 126.936092), // 지도의 중심좌표
									level : 2
								// 지도의 확대 레벨
								};
						
								var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다
						
								// 마커가 표시될 위치입니다 
								var markerPosition  = new kakao.maps.LatLng(37.554150, 126.935714); 
						
								// 마커를 생성합니다
								var marker = new kakao.maps.Marker({
								    position: markerPosition
								});
						
								// 마커가 지도 위에 표시되도록 설정합니다
								marker.setMap(map);
						
								var iwContent = '<div style="padding:5px; margin-left:10px;"><i>NIGHT CINEMA</i></div>';
								    iwPosition = new kakao.maps.LatLng(37.554150, 126.935714); //인포윈도우 표시 위치입니다
						
								// 인포윈도우를 생성합니다
								var infowindow = new kakao.maps.InfoWindow({
								    position : iwPosition, 
								    content : iwContent 
								});
								  
								// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
								infowindow.open(map, marker); 
							</script>
						
					</li>
					
					<li class="li2">
						<h3>오시는 길</h3>
						
							<div class="find_way">
								<ul>
									<li><strong>주소 :</strong></li>
									<li style="margin-bottom:10px;"><p>서울특별시 마포구 서강로 136 아이비타워 2층,3층(노고산동)</p></li>
									
									<li><strong>대표번호 :</strong></li>
									<li style="margin-bottom:10px;"><p>02-313-7300</p></li>
									
									<li><strong>지하철 이용 시 :</strong></li>
									<li style="margin-bottom:10px;"><p>신촌역 2호선 7번 출구</p></li>
									
									<li><strong>버스 이용시 :</strong></li>
									<li>
										<ul>
											<li><p>BLUE : 163, 170, 171, 172, 271, 371, 472, 602, 603, 705</p></li>
											<li><p>GREEN : 5711, 5712, 5713, 7011, 7012, 7014, 7015, 7611, 마포07, 마포10, 서대문05</p></li>
										</ul>
									</li>
								</ul>
							</div>					
					</li>
				</ul>
			</div>
			
		</div>
	
		<!-- footer -->
			<div id="footer" style="margin-top:900px;">
				<div class="f_bg">
					<img
						src="${ pageContext.request.contextPath }/resources/img/footer_bg.png">
				</div>
				<div class="f_txt">
					<p class="f_logo">
						<img src="${ pageContext.request.contextPath }/resources/img/logo_test.png">
					</p>
					
					<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
					<p class="team1">2조 Spring Project Movie</p>
					<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
				</div>
			</div>
		<!-- footer 끝 -->

	</div>
	

	<!-- <table>
		<tr>
			<td><div id="map" style="width: 800px; height: 400px;"></div></td>
		</tr>
	</table> -->
	
	<!-- 카카오지도 API -->
	<!-- <script type="text/javascript"
		src="//dapi.kakao.com/v2/maps/sdk.js?appkey=2c495537dfdb95fa59c9af35372bf3ca"></script>
	<script>
		var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
		mapOption = {
			center : new kakao.maps.LatLng(37.554480, 126.936092), // 지도의 중심좌표
			level : 2
		// 지도의 확대 레벨
		};

		var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

		// 마커가 표시될 위치입니다 
		var markerPosition  = new kakao.maps.LatLng(37.554150, 126.935714); 

		// 마커를 생성합니다
		var marker = new kakao.maps.Marker({
		    position: markerPosition
		});

		// 마커가 지도 위에 표시되도록 설정합니다
		marker.setMap(map);

		var iwContent = '<div>THEATER</div>';
		    iwPosition = new kakao.maps.LatLng(37.554150, 126.935714); //인포윈도우 표시 위치입니다

		// 인포윈도우를 생성합니다
		var infowindow = new kakao.maps.InfoWindow({
		    position : iwPosition, 
		    content : iwContent 
		});
		  
		// 마커 위에 인포윈도우를 표시합니다. 두번째 파라미터인 marker를 넣어주지 않으면 지도 위에 표시됩니다
		infowindow.open(map, marker); 
	</script>
	
	<br> -->
	
	<!-- 오시는 길 -->
	<!-- <table class="directions" width="800" align="center">
		<caption><b>KOREA THEATER 오시는 길</b></caption>
		
		<tr height="30"></tr>
		
		<tr>
			<th>주소 : </th>
			<td>서울특별시 마포구 서강로 136 아이비타워 2층,3층(노고산동)</td>
		</tr>
		
		<tr height="15"></tr>
		
		<tr>
			<th>대표번호 : </th>
			<td>02-313-7300</td>
		</tr>
		
		<tr height="15"></tr>
		
		<tr>
			<th>지하철 이용시 : </th>
			<td>신촌역 2호선 7번 출구</td>
		</tr>
		
		<tr height="15"></tr>
		
		<tr>
			<th rowspan="2">버스 이용시 : </th>
			<td>BLUE : 163, 170, 171, 172, 271, 371, 472, 602, 603, 705</td>
		</tr>
			
		<tr>
			<td>GREEN : 5711, 5712, 5713, 7011, 7012, 7014, 7015, 7611, 마포07, 마포10, 서대문05</td>
		</tr>
		
		<tr>
			<td height="30"></td>
		</tr>
		
		<tr>
			<td colspan="2" align="center"><input type="button" value="영화 예매하러 가기" onClick="location.href='movie_list.do'"></td>
		</tr>
	</table> -->
	
</body>
</html>