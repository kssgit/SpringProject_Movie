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
		<div id="header" >
			<%-- <div class="main_bg"><img src="${ pageContext.request.contextPath }/resources/img/main_bg.png"></div> --%>
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
	</div>
</body>
</html>