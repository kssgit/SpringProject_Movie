<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>아이디 찾기</title>

	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/user.css">
	
	<style>
		body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat; 
       }
		.find_id_pwd_form {align:center; padding-top:40px;}
		.find_id_pwd_form ul > li {list-style:none;}
		.find_id_pwd_form ul > li > h3 {width:300px; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px; margin-bottom:20px;}
		.li1{float:left; width:300px; height:auto; margin-left:33%;}
		.li2{float:left; width:300px; height:auto; margin-left:4%;}
		.find_id_pwd_form{overflow:hidden;}
		
		#footer{ width:100%; height:300px; position:absolute; margin-top:900px;}
		#footer .f_logo{ width:150px; height:150px; position:absolute; margin-top:-3px; }
		#footer .f_logo > img{ width:150px; height:150px; }
		
		#footer .f_txt{ width:50%; height:150px; position:relative; margin:25px auto; }
		#footer address{ width:100%; height:30px; position:absolute; margin:30px auto; text-align:center; color:white; }
		#footer .team1{ width:100%; height:30px; position:absolute; margin:60px auto; text-align:center; color:white; }
		#footer .team2{ width:100%; height:30px; position:absolute; margin:90px auto; text-align:center; color:white; }
				
	</style>


	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	
	<script type="text/javascript">
		function send(f) {
			
			var name = f.name.value.trim();
			var email = f.email.value.trim();
			
			// 유효성 체크
			if(name == ''){
				alert("이름을 입력하세요");
				return;
			}
			
			if(email == ''){
				alert("이메일을 입력하세요");
				return;
			}
			
			var url = "find_id.do";
			var param = "name="+encodeURIComponent(name) + "&email="+encodeURIComponent(email);
			sendRequest(url, param, resultFn, "POST");
						
		}
		
		function resultFn() {
			
			if(xhr.readyState == 4 & xhr.status == 200){
				var data = xhr.responseText;
				
				if(data == 'no_id'){
					alert("해당하는 아이디가 존재하지 않습니다.");
					return;
				}else{
					alert("회원님의 아이디는 " + "'"+data+"'" + "입니다.");
				}
			}
		}
		
		// 비밀번호 함수
		function sendEmail(f) {
			
			var id = f.id.value.trim();
			var email = f.email.value.trim();
			
			// 유효성 체크
			if(id == ''){
				alert("아이디을 입력하세요");
				return;
			}
			
			if(email == ''){
				alert("이메일을 입력하세요");
				return;
			}
			
			var url = "check_id.do";
			var param = "id="+encodeURIComponent(id) + "&email="+encodeURIComponent(email);
			sendRequest(url, param, resultFn2, "post");
			
		}
		
		function resultFn2() {
			
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = xhr.responseText;
				
				if(data == ''){
					alert("일치하는 계정이 존재하지 않습니다.");
					return;
				}
				
				var json = eval("["+data+"]");
				
				return location.href="find_pwd_email.do?id="+json[0].id+"&email="+json[0].email+"&l_idx="+json[0].l_idx;
				
			}
			
		}
		
	</script>

</head>
<body>

	<div id="moviewrap">
		<jsp:include page="../header.jsp" />

		<div id="container">
			
			<div class="find_id_pwd_form">
				<ul>
					<li class="li1">				
						<h3>아이디 찾기</h3>
					   	<form>
					   		<div class="input_wrapper">
					   			<input class="form_field" placeholder="Name" name="name" id="name" required />
					   			<input class="form_field" placeholder="Email" name="email" id="email" required />
					   			<input type="button" value="아이디 찾기" class="btn btn-primary btn-block btn-large" onClick="send(this.form);">
								<input type="button" value="취소" class="btn btn-primary btn-block btn-large" onClick="history.go(-1);" style="margin-top:10px;">
					    		<!-- <label for="name" class="form__label">Name</label> -->
					    	</div>
					    </form>
			    	</li>
			    	
			    	<li class="li2">				
						<h3>비밀번호 찾기</h3>
					   	<form>
					   		<div class="input_wrapper">
					   			<input class="form_field" placeholder="ID" name="id" id="id" required />
					   			<input class="form_field" placeholder="Email" name="email" id="email" required />
					   			<input type="button" value="비밀번호 찾기" class="btn btn-primary btn-block btn-large" onClick="sendEmail(this.form);">
								<input type="button" value="취소" class="btn btn-primary btn-block btn-large" onClick="history.go(-1);" style="margin-top:10px;">
					    	</div>
					    </form>
			    	</li>
			    
			    </ul>
			</div>
			
		</div>
	
		<div id="footer" style="margin-top:700px;">
			
			<div class="f_txt">
				<p class="f_logo"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></p>
				<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
				<p class="team1">2조 Spring Project Movie</p>
				<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
			</div>
		</div>

	</div>
	
	<!-- <form>
		<h3 align="center">아이디 찾기</h3>
		<table border="1" align="center">	
			
			<tr>
				<td width="120" height="25" align="center">이름 :</td>
				<td><input type="text" name="name" placeholder="ex) 홍길동"></td>
			</tr>
			
			<tr>
				<td width="120" height="25" align="center">이메일 :</td>
				<td><input type="text" name="email" placeholder="ex) hong@gmail.com"></td>
			</tr>
			
			<tr>
				<td align="center" colspan="2">
					<input type="button" value="아이디 찾기" onClick="send(this.form);">
					<input type="button" value="취소" onClick="location.href='login_form.do'">
				</td>
			</tr>
			
		</table>
	</form> -->
	
	
</body>
</html>