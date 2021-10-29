<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
   
   <link rel="shortcut icon" type="image/x-icon" href="${ pageContext.request.contextPath }/resources/img/icon.jpg"/>
   <title>Cinema</title>   
   <style type="text/css">
   * { magin:0; padding:0; }
 #moviewrap{width:100%; height:100%; position:relative; }
 
 /* background img */
.main_bg{ width:100%; height:300px; z-index:-1000; position:absolute; }
.main_bg > img{ width:100%; height:300px; background-repeat: no-repeat; }

/* header */
#header{ width:100%; height:300px; position:absolute; }

#header .gnb{ width:80%; height:40px; position:relative; margin:0 auto; }
#header .gnb ul{ width:200px; float:right; list-style:none; }
#header .gnb ul li{ float:right; margin-right:10px; }
#header .gnb ul > li > a{ text-decoration:none; color:white; letter-spacing:2px; font-size:13px; }

#header .nav{ width:80%; height:240px; position:relative; margin:10px auto; }
#header .nav #nav_left{ width:180px; height:180px; position:absolute; margin:30px 4%; }
#header .nav #nav_left > img{ width:180px; height:180px; }
#header .nav #nav_right{ width:180px; height:180px; position:absolute; margin-left:82%; margin-top:40px; }
#header .nav #nav_right > img{ width:220px; height:160px; }
#header .nav > h2{ width:50%; height:70px; position:absolute; margin:30px 25%; }
#header .nav > h2 > img{ width:100%; height:70px; }

#header .nav ul{ width:60%; height:60px; list-style:none; position:absolute; margin-top:120px; margin-left:20%; }
#header .nav ul > li{ float:left; width:25%; height:50px; text-align:center; line-height:80px; }
#header .nav ul > li > a{ text-decoration:none; color:white; font-size:18px; font-weight:400px; letter-spacing:2px; text-shadow: 5px 5px 5px white, 0 0 120px purple, 0 0 5px maroon; }
#header .nav ul > li > a:visited { text-decoration: none; }

   </style>
</head>
<body>
   
   <div id="moviewrap">
   
   	<jsp:include page="../header.jsp"/>
      <!-- header -->
      <%-- <div id="header">
         <div class="main_bg"><img src="${ pageContext.request.contextPath }/resources/img/main_bg.png"></div>
         <div class="gnb">
            
         </div>
         <div class="nav">
            <h1 id="nav_left"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></h1>
            <h2><img src="${ pageContext.request.contextPath }/resources/img/nav_logo.png"></h2>
            <ul>
               <li><a href="movieReleaseList.do">영화</a></li>
               <li><a href="ticketing.do">예매</a></li>
               <li><a href="#">영화관</a></li>
               <li><a href="review.do">커뮤니티</a></li>            
            </ul>
            <h1 id="nav_right"><img src="${ pageContext.request.contextPath }/resources/img/logo_test2.png"></h1>
         </div>
      </div> --%>
      <!-- header 끝 -->
      </div>
      
</body>
</html>