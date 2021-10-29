<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 확인</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/user.css">
		
	<link rel="shortcut icon" type="image/x-icon" href="${ pageContext.request.contextPath }/resources/img/icon.jpg" />

	<style type="text/css">
		body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat; 
       }	
		.field_form {align:center; padding-top:40px;}
		.field_form ul > li {list-style:none; padding-top:40px;}
		.field_form ul > li > h3 {width:300px; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px; margin-bottom:20px;}
		.li1{float:left; width:300px; height:auto; margin-left:800px;}
		.field_form{overflow:hidden;}
		
		h4{margin:auto; color:red; text-align:center; font-weight:bold;}
	</style>

	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>

	<script type="text/javascript">
	
		function save(f) {
			
			var input_pwd = f.input_pwd.value.trim();
			
			if(input_pwd == ''){
				alert("비밀번호를 입력 후 확인을 눌려주세요.");
				return;
			}
			
			if( !confirm("모든 정보가 삭제됩니다. 정말로 회원 탈퇴 하시겠습니까?")){
				return;

			}else {
				var url = "delete_user.do"
				var param = "l_idx=" + ${param.l_idx} + "&input_pwd=" + input_pwd;
				sendRequest(url, param, resultFn, "post");
			}
			
		function resultFn() {
			var data = xhr.responseText;
			
			if(data == 'fail'){
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
			
			if(data == 'success'){
				alert("회원이 탈퇴 되었습니다. 회원 정보가 모두 삭제 되었습니다.");
				return location.href='home.do';
			}
			
			
		}
			
		}
	
	</script>

</head>
<body>
	
	<div id="moviewrap">
		<jsp:include page="../header.jsp"/>
		<!-- header -->
		<%-- <div id="header"  onclick="location.href='/movie/'">
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
			
			<h4><i>* 고객님의 개인정보 보호를 위한 절차이오니, 로그인 시 사용하는 비밀번호를 입력해 주세요. *</i></h4>
				<ul>
					<li class="li1">				
						<h3>비밀번호 확인</h3>
					   	<form>					   	
					   		<div class="input_wrapper">
					   			<input class="form_field" name="id" id="id" value="${ sessionScope.user.id }" readonly />
					   			<input type="password" class="form_field" placeholder="Password" name="input_pwd" id="input_pwd" required />
					   			<input type="button" value="확    인" class="btn btn-primary btn-block btn-large" onClick="save(this.form)">
								<input type="button" value="취    소" class="btn btn-primary btn-block btn-large" onClick="location.href='mypage.do?l_idx=${param.l_idx}';" style="margin-top:10px;">
					    	</div>
					    </form>
			    	</li>
			    </ul>
			</div>
		</div>
	
		<!-- footer -->
		<div id="footer">
			<div class="f_bg">
				<img
					src="${ pageContext.request.contextPath }/resources/img/footer_bg.png">
			</div>
			<div class="f_txt">
				<p class="f_logo">
					<img
						src="${ pageContext.request.contextPath }/resources/img/logo_test.png">
				</p>
				
				<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
				<p class="team1">2조 Spring Project Movie</p>
				<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
			</div>
		</div>
		<!-- footer 끝 -->

	</div>
	
	<%-- <h3 align="center">비밀번호 확인</h3>
	
	<p align="center">고객님의 개인정보 보호를 위한 절차이오니, CGV 로그인 시 사용하는 비밀번호를 입력해 주세요.</p>
	
	<br>
	<br>
	
	<form>
		
		<div align="center" class="info-confim_pwd">
			<table>
			<tr>
				<td width="100"><strong>아이디</strong></td>
				<td><span>${ sessionScope.user.id }</span></td>
			</tr>
			
			<tr>
				<td><strong>비밀번호</strong></td>
				<td><input type="password" name="input_pwd"></td>
			</tr>
			</table>
		</div>
		
		<br>
		
		<div align="center" class="button">
			<input type="button" value="확인" onClick="save(this.form)">
			<input type="button" value="취소" onClick="location.href='mypage.do?l_idx=${param.l_idx}'">
		</div>
		
	</form> --%>
	
</body>
</html>