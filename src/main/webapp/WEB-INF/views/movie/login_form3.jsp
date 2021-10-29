<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/user.css">
	<link rel="shortcut icon" type="image/x-icon" href="${ pageContext.request.contextPath }/resources/img/icon.jpg" />

	<style>		
		body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat; 
           overflow:hidden;
       }
		.login_form {align:center; padding-top:40px;}
		.login_form ul > li {list-style:none;}
		.login_form ul > li > h3 {width:300px; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px; margin-bottom:20px;}
		.li1{float:left; width:300px; height:auto; margin-left:800px;}
		.login_form{overflow:hidden;}
		
	</style>

	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	
	<script type="text/javascript">
				
		function send(f) {
			
			var id = f.id.value.trim();
			var pwd = f.pwd.value.trim();
			
			// 유효성 체크
			if(id == '' ){
				alert("아이디를 입력하세요.");
				return;
			}
			
			if(pwd == ''){
				alert("패스워드를 입력하세요.");
				return;
			}
			
			var url = "login.do";
			var param = "id="+encodeURIComponent(id) + "&pwd="+encodeURIComponent(pwd);
			sendRequest(url, param, resultFn, "POST");
			
		}
		
		function resultFn() {
			
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = xhr.responseText;
				var json = eval("[" + data + "]");
				
				if(json == ''){
					alert("회원정보가 일치하지 않습니다.");
					return;
				}else {
					return history.go(-1);
					/* return location.href="ticketform2.do"; */
				}
				
			}
						
		}
		
	
	</script>

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
			<%-- <div class="m_list_bg">
				<img src="${ pageContext.request.contextPath }/resources/img/m_list_bg.png">
			</div> --%>
			
			<div class="login_form">
				<ul>
					<li class="li1">				
						<h3>로그인</h3>
					   	<form>
					   		<div class="input_wrapper">
					   			<input class="form_field" placeholder="ID" name="id" id="id" required />
					   			<input type="password" class="form_field" placeholder="Password" name="pwd" id="pwd" required />
					   			<input type="button" value="로  그  인" class="btn btn-primary btn-block btn-large" onClick="send(this.form);">
								<input type="button" value="회 원 가 입" class="btn btn-primary btn-block btn-large" onClick="location.href='register_form.do';" style="margin-top:10px; margin-bottom:10px;">
					    		<a href="find_id_form.do" style="color:white; text-decoration:none;" ><i>아이디 / 비밀번호 찾기 ></i></a>
					    	</div>
					    </form>
			    	</li>
			    </ul>
			</div>
		</div>
			<!-- footer -->
			<div id="footer" style="margin-top:750px;">
				<div class="f_bg">
					<img src="${ pageContext.request.contextPath }/resources/img/footer_bg.png">
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

			
</body>
</html>