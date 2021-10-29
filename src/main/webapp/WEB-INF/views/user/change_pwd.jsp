<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 재설정</title>

		<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/user.css">
		<link rel="shortcut icon" type="image/x-icon" href="${ pageContext.request.contextPath }/resources/img/icon.jpg" />

		<style type="text/css">
		body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat; 
       }
		.field_form {align:center; padding-top:40px;}
		.field_form ul > li {list-style:none;}
		.field_form ul > li > h3 {width:300px; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px; margin-bottom:20px;}
		.li1{float:left; width:300px; height:auto; margin-left:800px;}
		.field_form{overflow:hidden;}
		</style>

	<script type="text/javascript">
	
		function change_pwd(f) {
			
			var l_idx = f.l_idx.value.trim();
			var pwd = f.pwd.value.trim();
			var new_pwd_cfm = f.new_pwd_cfm.value.trim();
			
			// 유효성 체크
			if(pwd == ''){
				alert("새로운 비밀번호를 입력해 주세요.");
				return;
			}
			
			if(new_pwd_cfm == ''){
				alert("새로운 비밀번호 확인을 입력해 주세요.");
				return;
			}
			
			if(pwd != new_pwd_cfm){
				alert("비밀번호가 일치하지 않습니다.");
				return;
			}
			
			f.method = "post";
			f.action = "change_pwd.do";
			f.submit();
			
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
				
				<div class="field_form">
					<ul>
						<li class="li1">				
							<h3>비밀번호 재설정</h3>
						   	<form>
						   		<input type="hidden" name="l_idx" value=${ l_idx }>
						   	
						   		<div class="input_wrapper">
						   			<input type="password" class="form_field" placeholder="New Password" name="pwd" id="pwd" required />
						   			<input type="password" class="form_field" placeholder="New Password_Confirm" name="new_pwd_cfm" id="new_pwd_cfm" required />
						   			<input type="button" value="변경하기" class="btn btn-primary btn-block btn-large" onClick="change_pwd(this.form);">
									<input type="button" value="취      소" class="btn btn-primary btn-block btn-large" onClick="location.href='login_form.do';" style="margin-top:10px;">
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

	
	<%-- <h3 align="center">비밀번호 변경</h3>

	<form>
	
		<input type="hidden" name="l_idx" value=${ l_idx }>

		<table align="center" width="400">
	
			<tr>
				<td align="center">새로운 비밀번호 :</td>
				<td><input type="password" id="pwd" name="pwd"></td>
			</tr>
	
			<tr>
				<td align="center">새로운 비밀번호 확인 :</td>
				<td><input type="password" id="new_pwd_cfm" name="new_pwd_cfm"></td>
			</tr>
			
			<tr>
				<td colspan="2"><br></td>
			</tr>
					
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="변경하기" onClick="change_pwd(this.form);">
					<input type="button" value="취소" onClick="location.href='login_form.do'">
				</td>
			</tr>
			

		</table>

	</form> --%>

	
	
</body>
</html>