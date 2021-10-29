<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>영화 그 이상의 감동. CGW</title> 
   
   <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_rank.css">
   <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_release.css">
   <link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/movie_query.css">
   
   <style type="text/css">
       
       body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat; 
       }
       
		#back-top {
			position: fixed;
			bottom: 30px;
			margin-left: -150px;
		}

		#back-top a {
			width: 108px;
			display: block;
			text-align: center;
			font: 11px/100% Arial, Helvetica, sans-serif;
			text-transform: uppercase;
			text-decoration: none;
			color: #bbb;
			
			/* transition */
			-webkit-transition: 1s;
			-moz-transition: 1s;
			transition: 1s;
		}
		#back-top a:hover {
			color: #000;
		}
		
		/* arrow icon (span tag) */
		#back-top span {
			width: 108px;
			height: 108px;
			display: block;
			margin-bottom: 7px;
			background: #ddd url(up-arrow.png) no-repeat center center;
			
			/* rounded corners */
			-webkit-border-radius: 15px;
			-moz-border-radius: 15px;
			border-radius: 15px;
			
			/* transition */
			-webkit-transition: 1s;
			-moz-transition: 1s;
			transition: 1s;
		}
		#back-top a:hover span {
			background-color: #777;
		}
        
        #header .nav > h2 > img{ width:100%; height:70px;   
			animation: main_bg 0.7s linear infinite;
			animation-iteration-count: 2;}
		@keyframes main_bg{
		    50% {opacity:0.2;}
		    100% {opacity:1;}
		}
   </style>
   
   <script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
   <script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/needDate.js"></script>
   <script type="text/javascript">
   
      window.onload=function(){
         load_release_list();

         //저장되있는 쿠키 출력
         for(var i = 0; i < 3 ; i++){
            var st = getCookie("id"+i);
            if( st != undefined ){
               document.getElementById("recent_query_data_"+i).value = st;
               document.getElementById("recent_query_"+i).innerHTML = st;
               document.getElementById("del_icon_"+i).style.display = "block";
            }
         }
         
         if( getCookie("check") == 'yes' ){
            queryMovie();
            deleteCookie("check");
            
         }
      };
      
      //날짜 비교 
      var date = new Date();
      
      var today = loadDate()-1;//1일에 문제될수있음
      var releaseStart = releaseDtStart();
      var releaseEnd = releaseDtEnd();

      var moreCount = 1;//더보기 카운트
   
      function more_list(){
         moreCount++;
         document.getElementById("select_movie_lists_release_"+moreCount).style.display="block";
         if(moreCount == 4){
            var moreButton = document.getElementById("movie_release_list_moreSee");
            moreButton.removeChild( moreButton.children[0] );
         }
      }
      //박스오피스 버튼
      function boxOfficeView(){
         load_boxOff_list();
         document.getElementById("contents_release").style.display="none";
         document.getElementById("contents_query").style.display="none";
         document.getElementById("contents_rank").style.display="block";
      }
      //상영예정작 버튼
      function scheduledScreenView(){
         load_release_list();
         document.getElementById("contents_rank").style.display="none";
         document.getElementById("contents_query").style.display="none";
         document.getElementById("contents_release").style.display="block";
      }
      //검색버튼
      function queryMovie(){
         document.getElementById("contents_release").style.display="none";
         document.getElementById("contents_rank").style.display="none";
         document.getElementById("contents_query").style.display="block";
      }
      //여러개 포스터 잘라쓰기
      function cutPoster(posters) {
           if (posters.indexOf("|") !== -1) {
             posters = posters.substring(0, posters.indexOf("|"));
           }
           if (posters === "") {
             posters = "${ pageContext.request.contextPath }/resources/img/nullImg.png";
           }
           return posters;
      }
      
      //성영 예정작 목록을 가져오는 함수
      function load_release_list(){
         //192.168.1.101:9090/vs/list.do
         var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
         var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&releaseDts='+releaseStart+'&releaseDte='+releaseEnd+'&listCount=32';
         console.log(releaseStart + "/"+releaseEnd+"/");
         sendRequest( url, param, resultFnRel, "GET" );
      }
      
      function resultFnRel(){   
         if( xhr.readyState == 4 && xhr.status == 200 ){      
            var data = xhr.responseText;
            var json = eval("["+data+"]");      
            
            for(var i=0 ; i<json[0].Data[0].Result.length ; i++){
               
                var moviePoster = cutPoster(json[0].Data[0].Result[i].posters);//json형식으로 넘어온 값이 여러개의 포스터일 경우 하나의 포스터를 가져옴
                var releaseTitle = json[0].Data[0].Result[i].title;
                if( releaseTitle == null ){
                   releaseTitle = '불러오지 못함';
                }
                document.getElementById("movie_release_movieId_"+i).value=json[0].Data[0].Result[i].movieId;//영화 코드1
                document.getElementById("movie_release_movieSeq_"+i).value=json[0].Data[0].Result[i].movieSeq;//영화 코드2
                var td = document.getElementById("movie_release_title_data_"+i);
                td.value=releaseTitle;//영화 제목
                document.getElementById("movie_release_title_"+i).innerHTML=releaseTitle;//영화 제목
                document.getElementById("movie_release_poster_"+i+"_img").src=moviePoster;//포스터
                
                //개봉날짜 체크
                var releaseY = json[0].Data[0].Result[i].repRlsDate.substring(0,4);
                var releaseM = json[0].Data[0].Result[i].repRlsDate.substring(4,6);
                var releaseD = json[0].Data[0].Result[i].repRlsDate.substring(6,8);
                var releaseDate = releaseY+"."+releaseM+"."+releaseD+" 개봉";
                if(releaseD=="00"){
                   releaseDate =  releaseY+"."+releaseM+". 개봉";
                }
                
                document.getElementById("movie_release_relDate_"+i).innerHTML=releaseDate;//개봉일
                document.getElementById("movie_release_runtime_"+i).innerHTML=json[0].Data[0].Result[i].runtime+"분";//상영시간
                var movie_add_button=document.getElementById("movie_action_button_text_"+i); 
                if(movie_add_button.children[0] == undefined ){
                   if(today >= json[0].Data[0].Result[i].repRlsDate-2){
                       var aTag=document.createElement("a");
                       aTag.href="ticketing.do?m_name="+releaseTitle; 
                       aTag.innerHTML="예매하기";
                       movie_add_button.appendChild(aTag);
                      /* document.getElementById("movie_action_button_text_"+i).innerHTML="예매"; */
                   } else{
                       var pTag=document.createElement("p");
                       pTag.innerHTML="개봉예정";
                       movie_add_button.appendChild(pTag);
                   }
                }
            }      
         }
      }
      
      //영화 코드 컨트롤러로 넘기기(영화 상세보기 위해서)
      function detail( movieId, movieSeq, m_name ){
         return location.href="movieInfoDetail.do?movieId="+movieId+"&movieSeq="+movieSeq+"&m_name="+encodeURIComponent(m_name);
      }
      
      //------------------rank----------------------------------------------------------
      function loading_del(){
          var loadingText = document.getElementById("loadingText");
         if( loadingText.children[0] != undefined ){
            loadingText.removeChild( loadingText.children[0] );                         
         }
      }
      
      //박스오피스를 가져오는 함수
      function load_boxOff_list(){
         //192.168.1.101:9090/vs/list.do
         var url ='http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json';
         var param = 'key=a7c6bfb2e16d4d1ae14730f90bc6726a&targetDt='+today;
         sendRequest( url, param, resultFnRank, "GET" );   
      }
      
      
      function resultFnRank(){
         if( xhr.readyState == 4 && xhr.status == 200 ){
            var data = xhr.responseText;
            var json = eval("["+data+"]");   
            var movie_list =document.getElementById("movie_list");
            for(var i=0 ; i<json[0].boxOfficeResult.dailyBoxOfficeList.length ; i++){

               var openDts = noFormDates(json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt);
               document.getElementById("movie_openDt_"+i).value=openDts;//영화 코드(영진위)
               document.getElementById("movie_movieNm_"+i).value=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;//영화 제목에서 자르기(영진위)
                document.getElementById("movie_rank_movieNm_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;;//영화 제목
                document.getElementById("ticket"+i).href="ticketing.do?m_name="+json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;
                document.getElementById("movie_rank_rank_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].rank+" 위";//순위
                document.getElementById("movie_rank_salesShare_"+i).innerHTML="예매율 : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].salesShare+" %";//예매율
                document.getElementById("movie_rank_audiAcc_"+i).innerHTML="누적관객수 : "+json[0].boxOfficeResult.dailyBoxOfficeList[i].audiAcc+"명";//누적관객수
                document.getElementById("movie_rank_openDt_"+i).innerHTML=json[0].boxOfficeResult.dailyBoxOfficeList[i].openDt+"개봉";//개봉일
            }
            load_poster();
            loading_del();      
         }      
      }
      
      //박스오피스의  DB에서 포스터 가져오기
      function load_poster(){
         var url2 ="moviePosterLoad.do";
         var param2 = "";
         sendRequest( url2, param2 , resultFnPos, "GET");
      }
      
      function resultFnPos(){            
         if( xhr.readyState == 4 && xhr.status == 200 ){
            var data = xhr.responseText;
            var json = eval(data);
            
            outer : for( var i = 0; i < json.length ; i++){
               var jsonLoadMovieNm = json[i].movieNm.trim();
               var jsonLoadPoster=json[i].posterNm;
               var jsonLoadTrailer=json[i].trailerSrc;
               for(var j = 0; j < 10 ; j++){
                   if( jsonLoadMovieNm == document.getElementById("movie_movieNm_"+j).value.trim() ){
                      document.getElementById("movie_rank_poster_"+j+"_img").src=jsonLoadPoster;
                      document.getElementById("movie_trailer_src_"+j).value=jsonLoadTrailer;
                      continue outer;
                   }               
               }
            }
         }
      }
      
      function detailRank( releaseDts, title, trailer ){
         return location.href="movieInfoDetailRank.do?releaseDts="+releaseDts+"&title="+encodeURIComponent(title)+"&trailer="+trailer;
      }
      //---------------------query---------------------------------------------------
      //쿠키 생성
      function setCookie(cookie_name, value, days) {
         var exdate = new Date();
         exdate.setDate(exdate.getDate() + days);
         
         var cookie_value = escape(value) + ((days == null) ? '' : '; expires=' + exdate.toUTCString());
         document.cookie = cookie_name + '=' + cookie_value;
      }
      //쿠키 가져오기
      function getCookie(cookie_name) {
         var x, y;
         var val = document.cookie.split(';');

         for (var i = 0; i < val.length; i++) {
            x = val[i].substr(0, val[i].indexOf('='));
            y = val[i].substr(val[i].indexOf('=') + 1);
            x = x.replace(/^\s+|\s+$/g, ''); // 앞과 뒤의 공백 제거하기
            if (x == cookie_name) {
               return unescape(y); // unescape로 디코딩 후 값 리턴
            }
         }
      }
      //쿠키제거
      var deleteCookie = function(name) {
         document.cookie = name + '=; expires=Thu, 01 Jan 1999 00:00:10 GMT;';
      }
      
      //어떤 영화가 궁금한가요? 텍스트 지움 매서드
      function text_del(){
          var delText = document.getElementById("searchText");
          delText.removeChild( delText.children[0] );
      }
      
      //검색 결과를 가지고 오는 Ajax매서드
      function load_Query( f ){
         var query = f.query.value.trim();
         var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
         var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&sort=prodYear,1&listCount=6&query='+query;
         sendRequest( url, param, resultFnQu, "GET" );
      }
      
      function load_Query2( query ){
         var url ='http://api.koreafilm.or.kr/openapi-data2/wisenut/search_api/search_json2.jsp';
         var param = 'collection=kmdb_new2&detail=Y&ServiceKey=U8ECM752YKB763PI62AV&sort=prodYear,1&listCount=6&query='+query;
         sendRequest( url, param, resultFnQu, "GET" );
      }
      
      function resultFnQu(){
         
         if( xhr.readyState == 4 && xhr.status == 200 ){
            var data = xhr.responseText;
            var json = eval("["+data+"]");      
            
            //쿠키 값 확인
            var gc0 = getCookie("id"+0);
            var gc1 = getCookie("id"+1);
            var gc2 = getCookie("id"+2);
            
            //쿠키 저장 및 정렬
            if( gc0 != undefined ){
               if(gc1 != undefined ){
                  setCookie("id"+2, gc1, '1');                  
               }
               setCookie("id"+1, gc0, '1');
            }
            setCookie("id"+0, json[0].Query, '1');
            document.cookie;
            record_query("id"+0, json[0].Query);
            
            //쿠키 출력
            for(var i = 0; i < 3 ; i++){
               var st = getCookie("id"+i);
               if( st != undefined ){
                  document.getElementById("recent_query_data_"+i).value = st;
                  document.getElementById("recent_query_"+i).innerHTML = st;
                  document.getElementById("del_icon_"+i).style.display = "block";
               }
            } 

            for(var i=0 ; i<json[0].Data[0].Result.length ; i++){

                var moviePoster = cutPoster(json[0].Data[0].Result[i].posters);//json형식으로 넘어온 값이 여러개의 포스터일 경우 하나의 포스터를 가져옴
                var queryTitle = json[0].Data[0].Result[i].title;
                if( queryTitle == null ){
                	queryTitle = '불러오지 못함';
                }
                document.getElementById("movie_movieId_"+i).value=json[0].Data[0].Result[i].movieId;//영화 코드1
                document.getElementById("movie_movieSeq_"+i).value=json[0].Data[0].Result[i].movieSeq;//영화 코드2
                document.getElementById("movie_query_list_title_"+i).innerHTML=queryTitle;//영화 제목
                var td = document.getElementById("movie_query_title_data_"+i);
                td.value=queryTitle;//영화 제목
                document.getElementById("movie_query_list_poster_"+i+"_img").src=moviePoster;//포스터
                
                //개봉날짜 체크
                var releaseYq = json[0].Data[0].Result[i].repRlsDate.substring(0,4);
                var releaseMq = json[0].Data[0].Result[i].repRlsDate.substring(4,6);
                var releaseDq = json[0].Data[0].Result[i].repRlsDate.substring(6,8);
                var releaseDateq = releaseYq+"."+releaseMq+"."+releaseDq+" 개봉";
                if(releaseDq=="00"){
                   releaseDateq =  releaseYq+"."+releaseMq+". 개봉";
                }
                
                document.getElementById("movie_query_list_relDate_"+i).innerHTML=releaseDateq;//개봉일
                document.getElementById("movie_query_list_runtime_"+i).innerHTML=json[0].Data[0].Result[i].runtime+"분";//상영시간
            }
            
            document.getElementById("question_box").style.top="20px";
            
            for(var i = 0 ; i <json[0].Data[0].Result.length; i++ ){
               document.getElementById("result_inv_movie_"+i).style.display="block";
            }

            text_del();//텍스트 지우기
         }
      }
      
      //최근 기록 제거
      function recent_del( i ){
         deleteCookie("id"+i);
         setCookie("check", "yes", '1');
         //새로고침
         location.reload(true);
         location.href = location.href;
         history.go(0);
         
      }
      
      //DB에 검색기록 저장
      function record_query( userId, queryContent ){
         var url3 ="movieQueryRecord.do";
         var param3 = "userId="+userId+"&queryContent="+queryContent;/* userId을 SessionId로 받아오기*/
         sendRequest( url3, param3 , resultFnRec, "GET");
      }
      function resultFnRec(){
         if( xhr.readyState == 4 && xhr.status == 200 ){

         }   
      }
      
      //검색창 엔터 버튼
      function inputEnter(f){
         if(event.keyCode == 13){
            load_Query( f );
         }
      }

   </script> 
</head>
<body>

    <!-- header -->
		<div id="header" style="z-index:3;">
			
			<div class="gnb">
				<ul>
					<c:if test="${empty sessionScope.user}">
						<li><a href="login_form.do?seat=0">로그인</a></li>
						<li><a href="register_form.do">회원가입</a></li>
					</c:if>
					
					<c:if test="${not empty sessionScope.user}">
						<li style='color:white;'><span style='font-weight: bold;'>${ sessionScope.user.name }</span> 님 환영합니다.</li>
						<li><a href="logout.do">로그아웃</a></li>
						<li><a href="mypage.do?l_idx=${ sessionScope.user.l_idx }">마이페이지</a></li>
					</c:if>
				</ul>
			</div>
			
			<div class="nav">
				<h1 id="nav_left"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png" onclick="location.href='/movie/'"></h1>
				<h2><img src="${ pageContext.request.contextPath }/resources/img/nav_logo.png" onclick="location.href='/movie/'"></h2>
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
	
	<%-- <jsp:include page="../header.jsp"/> --%>

    <div id="container">
		<div id="container_inner">
			<div id="page_title">전체 영화</div>
      
      <div id="movie_list_nav">
         <div class="movie_list_nav1"><a href="javascript:void(0);" onclick="boxOfficeView();">박스오피스</a></div><!-- /movie/movieRankList.do -->
         <div class="movie_list_nav2"><a href="javascript:void(0);" onclick="scheduledScreenView();">상영 예정작</a></div><!-- /movie/movieReleaseList.do -->
         <div class="movie_list_nav3"><a href="javascript:void(0);" onclick="queryMovie();">영화 검색</a></div><!-- /movie/movieQuery.do -->
      </div>
      
      <div id="contents_release">
         <div id="movie_chart_release">
            <div id="select_movie_lists_release">
               <c:forEach var="n" begin="0" end="7" step="1">
                  <div id="movie_release_list_${n}">
                     <input type="hidden" id="movie_release_movieId_${n}">
                     <input type="hidden" id="movie_release_movieSeq_${n}">
                     <input type="hidden" id="movie_release_title_data_${n}">
                     
                     
                     <div id="movie_release_poster_${n}">
                        <div class="poster_box">
                           <img id="movie_release_poster_${n}_img">
                           <div class="poster_hover">
                              <div class="poster_hover_text">
                                 <div class="poster_hover_text_2"><div id="movie_action_button_text_${n}"></div></div>      
                                 <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value, movie_release_title_data_${n}.value);">상세보기</a></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     
                     <div class="movie_title_box">
                        <div id="movie_release_title_${n}"></div>
                     </div>  
                     
                     <div class="movie_infos">
                     	<div class="movie_release_rel">
	                        <div id="movie_release_relDate_${n}"></div>
                     	</div>
                        <div id="movie_release_runtime_${n}"></div>
                     </div>
                     
                  </div>
               </c:forEach>
            </div>
            
            <div id="select_movie_lists_release_2">
               <c:forEach var="n" begin="8" end="15" step="1">
                  <div id="movie_release_list_${n}">
                     <input type="hidden" id="movie_release_movieId_${n}">
                     <input type="hidden" id="movie_release_movieSeq_${n}">
                     <input type="hidden" id="movie_release_title_data_${n}">
                     
                     <div id="movie_release_poster_${n}">
                        <div class="poster_box">
                           <img id="movie_release_poster_${n}_img">
                           <div class="poster_hover">
                              <div class="poster_hover_text">
                                 <div class="poster_hover_text_2"><div id="movie_action_button_text_${n}"></div></div>      
                                 <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value, movie_release_title_data_${n}.value);">상세보기</a></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     
                     <div class="movie_title_box">
                        <div id="movie_release_title_${n}"></div> 
                     </div>
                     
                     <div class="movie_infos">
                     	<div class="movie_release_rel">
	                        <div id="movie_release_relDate_${n}"></div>
                     	</div>
                        <div id="movie_release_runtime_${n}"></div>
                     </div>

                  </div>
               </c:forEach>
            </div>
            
            <div id="select_movie_lists_release_3">
               <c:forEach var="n" begin="16" end="23" step="1">
                  <div id="movie_release_list_${n}">
                     <input type="hidden" id="movie_release_movieId_${n}">
                     <input type="hidden" id="movie_release_movieSeq_${n}">
                     <input type="hidden" id="movie_release_title_data_${n}">
                     
                     <div id="movie_release_poster_${n}">
                        <div class="poster_box">
                           <img id="movie_release_poster_${n}_img">
                           <div class="poster_hover">
                              <div class="poster_hover_text">
                                 <div class="poster_hover_text_2"><div id="movie_action_button_text_${n}"></div></div>      
                                 <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value,  movie_release_title_data_${n}.value);">상세보기</a></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     
                     <div class="movie_title_box">
                        <div id="movie_release_title_${n}"></div>
                     </div>
                     
                     <div class="movie_infos">
                     	<div class="movie_release_rel">
	                        <div id="movie_release_relDate_${n}"></div>
                     	</div>
                        <div id="movie_release_runtime_${n}"></div>
                     </div>

                  </div>
               </c:forEach>
            </div>
            
            <div id="select_movie_lists_release_4">
               <c:forEach var="n" begin="24" end="31" step="1">
                  <div id="movie_release_list_${n}">
                     <input type="hidden" id="movie_release_movieId_${n}">
                     <input type="hidden" id="movie_release_movieSeq_${n}">
                     <input type="hidden" id="movie_release_title_data_${n}">
                     
                     <div id="movie_release_poster_${n}">
                        <div class="poster_box">
                           <img id="movie_release_poster_${n}_img">
                           <div class="poster_hover">
                              <div class="poster_hover_text">
                                 <div class="poster_hover_text_2"><div id="movie_action_button_text_${n}"></div></div>      
                                 <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detail(movie_release_movieId_${n}.value, movie_release_movieSeq_${n}.value,  movie_release_title_data_${n}.value);">상세보기</a></div>
                              </div>
                           </div>
                        </div>
                     </div>
                     
                     <div class="movie_title_box">
                        <div id="movie_release_title_${n}"></div>
                     </div>
                     
                     <div class="movie_infos">
                     	<div class="movie_release_rel">
	                        <div id="movie_release_relDate_${n}"></div>
                     	</div>
                        <div id="movie_release_runtime_${n}"></div>
                     </div>

                  </div>
               </c:forEach>
            </div>
            
            <div id="movie_release_list_moreSee">
            	<!-- <input type="button" value="더보기" onclick="more_list();"> -->
             	<button class="btn-1" onclick="more_list();">see more</button>
            </div>
         </div>
      </div>
      
      <div id="contents_rank">
         <div id="contents_rank_title">현재 상영작 <span>TOP 10</span></div>
         <div id="loadingText"><h3>Loading...</h3></div>
         <div id="select_movie_list">
            <ul id="movie_list">
            
              
               <c:forEach var="n" begin="0" end="9" step="1">
                  <li id="movie_list_${n}">
                     <div id="movie_rank_box_one">
                        <input type="hidden" id="movie_openDt_${n}">
                        <input type="hidden" id="movie_movieNm_${n}">
                        
                        
                        <div id="movie_rank_poster_${n}">
                           <div class="poster_box">
                              <img id="movie_rank_poster_${n}_img">
                              <div class="poster_hover">
                                 <div class="poster_hover_text">
                                    <div class="poster_hover_text_2"><a id="ticket${n}">예매하기</a></div>      
                                    <div class="poster_hover_text_1"><a href="javascript:void(0);" onclick="detailRank(movie_openDt_${n}.value, movie_movieNm_${n}.value, movie_trailer_src_${n}.value);">상세보기</a></div>
                                 </div>   
                              </div>
                           </div>
                        </div>
                        
                        <div class="movie_title_box">
                        <div>
                        <c:choose>
	                        <c:when test="${n eq 0 }">
	                        <div style="width:35px; float:left;" id="movie_rank_rank_${n}"></div>
	                        <img style="width:25px; height:32px;" src="${ pageContext.request.contextPath }/resources/img/maedal_one.png">
	                        </c:when>
	                        
	                         <c:when test="${n eq 1 }">
	                        <div style="width:35px; float:left;" id="movie_rank_rank_${n}"></div>
	                        <img style="width:25px; height:32px;" src="${ pageContext.request.contextPath }/resources/img/maedal_two.png">
	                        </c:when>
	                        
	                         <c:when test="${n eq 2 }">
	                        <div style="width:35px; float:left;" id="movie_rank_rank_${n}"></div>
	                        <img style="width:25px; height:32px;" src="${ pageContext.request.contextPath }/resources/img/maedal_three.png">
	                        </c:when>
	                        
	                        <c:otherwise>
	                        <div style="width:35px; float:left;" id="movie_rank_rank_${n}"></div>
	                        </c:otherwise>
	                    </c:choose>
                        </div>
                           <div id="movie_rank_movieNm_${n}"></div>
                        </div>
                        
                        <div class="movie_rank_infos">
                           <div id="movie_rank_salesShare_${n}"></div>
                           <div id="movie_rank_audiAcc_${n}"></div>
                        </div>
                        <input type="hidden" id="movie_rank_openDt_${n}">
                        <input type="hidden" id="movie_trailer_src_${n}">
                     </div>
                  </li>
               </c:forEach>
            </ul>
            


            
         </div>
      </div>
      
      <div id="contents_query">
         
         <div id="question_box" style="z-index:3;">
               <div id="recent_query_box">
                  <div id="recent_query_title">최근 검색어 : </div>
                  <c:forEach var="i" begin="0" end="2" step="1">
                     <div id="recent_querys">
                        <form>
                           <input id="recent_query_data_${i}" value="" type="hidden">
                           <a id="recent_query_${i}" href="javascript:void(0);" onclick="load_Query2(recent_query_data_${i}.value);"></a>
                           <div id="del_img_box">
                              <img id="del_icon_${i}" onclick="recent_del(${i});" style="width:20px" src="${ pageContext.request.contextPath }/resources/img/iconDelwhite.png">
                           </div>
                        </form>
                        
                     </div>
                  </c:forEach>
               </div>
            
            <div id="query_input_box">
               <form id="search_form" name="searchForm" onsubmit="return false;" method="post">
                  <div id="query_widnow">
                     <img id="query_icon" src="${ pageContext.request.contextPath }/resources/img/queryicon.png">
                     <input name="query" id="query" autocomplete="off" onkeypress="inputEnter(this.form);" style="border:none">
                     <input id="btn" type="button" value="검색" onclick="load_Query(this.form);">
                  </div>
                  
                  <div id="searchText"><h3>어떤 영화가 궁금한가요? </h3></div>
               </form>
            </div>
         </div>
         
         <div id="movie_query_list_container">
            <ul id="movie_query_list">
               <c:forEach var="n" begin="0" end="9" step="1">
                  <li id="movie_query_list_${n}">
                     
                     <div id="result_inv_movie_${n}">
                        <div id="movie_query_box_one">
                           <div class="movie_query_result_box_${n}">
                              <input type="hidden" id="movie_movieId_${n}">
                              <input type="hidden" id="movie_movieSeq_${n}">
                              <input type="hidden" id="movie_query_title_data_${n}">
                              
                              <div id="movie_query_list_title_${n}"></div>
                              <div id="movie_query_list_poster_${n}">
                                 <div class="poster_box"> 
                                    <img id="movie_query_list_poster_${n}_img">
                                    <div class="poster_hover">
                                       <div class="poster_hover_text">   
                                          <div class="poster_hover_text_3"><a href="javascript:void(0);" onclick="detail(movie_movieId_${n}.value, movie_movieSeq_${n}.value, movie_query_title_data_${n}.value);">상세보기</a></div>
                                       </div>
                                    </div>
                                 </div>
                              </div>
                              
                              <div class="movie_query_rel_run">
                                  <div class="movie_query_rel">
		                              <div id="movie_query_list_relDate_${n}"></div>
                                  </div>
	                              <div id="movie_query_list_runtime_${n}"></div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </li>
               </c:forEach>
            </ul>
         </div>
      	</div>
      </div>

   </div>
   
    <div id="footer_box">
			<div id="footer">
				<%-- <div class="f_bg"><img src="${ pageContext.request.contextPath }/resources/img/footer_bg.png"></div> --%>
				<div class="f_txt">
					<p class="f_logo"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></p>
					<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
					<p class="team1">2조 Spring Project Movie</p>
					<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
				</div>
			</div>
		</div>
	

</body>
</html>