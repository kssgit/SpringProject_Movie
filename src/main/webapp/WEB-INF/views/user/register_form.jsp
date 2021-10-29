<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>회원가입</title>
		
		<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/user.css">
		<link rel="shortcut icon" type="image/x-icon" href="${ pageContext.request.contextPath }/resources/img/icon.jpg" />

		<style type="text/css">
		body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat; 
       }
		.field_form {align:center; padding-top:40px;}
		.field_form ul > li {list-style:none;}
		.field_form h3 {width:620px; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px; margin-bottom:20px;}
		.li1{float:left; width:300px; height:auto; margin-left:34%;}
		.li2{float:left; width:300px; height:auto; margin-left:1%;}
		.field_form{overflow:hidden;}
		
		#footer{ width:100%; height:200px; position:absolute; margin-top:930px; }
		</style>
		
		
		<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
		<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
		
		<script type="text/javascript">
		var id_check_click = false;
		
		var email_random_key = "";
		var email_auth_click = false;
		
		
		function signup( f ) {
				
				var id = f.id.value.trim();
				var pwd = f.pwd.value.trim();
				var pwd2 = f.pwd2.value.trim();
				var name = f.name.value.trim();
				var postcode = f.postcode.value;
				var addr = f.addr.value;
				var d_addr = f.d_addr.value;
				var ex_addr = f.ex_addr.value;
				var email = f.email.value.trim();
				var tell = f.tell.value.trim();
				
				
				
				//아이디 유효성 검사체크
				var id_pat = /^[a-z0-9]{4,20}$/;
				if( !id_pat.test(id)) {
					alert("ID는 영 소문자, 숫자 4~20자리로 입력해 주세요.");
					return;
				}
				
				if(id_check_click == false){
					alert("아이디 중복체크 확인을 해 주세요.");
					return;
				}
				
				//비밀번호 정규식
				var pw_pat = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;			
				if( !pw_pat.test(pwd)) {
					alert("비밀번호는 숫자와 문자 특수문자 포함 형태의 8~15자리 이내로 입력해 주세요.");
					return;
				}
				
				if( pwd != pwd2 ) {
					alert("위 아래 패스워드는 일치하게 입력해주세요");
					return;
					
				}
				
				// 이메일 정규식 패턴 검사
				var email_pat = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;				
				if( !email_pat.test(email)) {
					alert(" 이메일 형식에 맞게 쓰세요.");
					return;
				}
				
				// 이메일 인증
				if(email_auth_click == false){
					alert("이메일 인증을 해주세요");
					return;
				}
				
				// 휴대폰번호 패턴 검사	
				var mobile_pat = /^\d{3}-\d{3,4}-\d{4}$/;
				if( !mobile_pat.test(tell)) {
					alert("-을 포함한 휴대폰 번호를 입력해 주세요. ");
					return;
				}
				
				//signup_success.do 를 컨트롤러에서 맵핑을 설정해주러 간다
				f.action = "register.do";
				f.method = "post";
				f.submit();
				
			}
		
		function id_check(f) {
			
			var id = f.id.value.trim();
			
			if(id == ''){
				alert("아이디를 입력해 주세요.");
				return;
			}
			
			var id_pat = /^[a-z0-9]{4,20}$/;
			if( !id_pat.test(id)) {
				alert("id는 영 소문자, 숫자 4~20자리로 입력 !!");
				return;
			}
			
			var url = "id_check.do";
			var param = "id=" + encodeURIComponent(id);
			sendRequest(url, param, resultFn, "post");
			
		}
		
		function resultFn() {
			
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = xhr.responseText;
				
				if(data == 'have_id'){
					alert("동일한 아이디가 있습니다.");
					return;
				}
				
				alert("사용이 가능한 아이디 입니다.");
				id_check_click = true;
				
				document.getElementById("id").readOnly = true;
				
			}
			
		}
		
		function email_auth(f) {
			
			var email = f.email.value.trim();
			
			if(email == ''){
				alert("이메일을 입력해 주세요.");
				return;
			}
			
			// 이메일 정규식 패턴 검사
			var email_pat = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;				
			if( !email_pat.test(email)) {
				alert(" 이메일 형식에 맞게 쓰세요 !! ");
				return;
			}
			
			var url = "email_auth.do";
			var param = "email=" + encodeURIComponent(email);
			sendRequest(url, param, resultFn_email, "get");
			
		}
		
		function resultFn_email() {
			if(xhr.readyState == 4 && xhr.status == 200){
				email_random_key = xhr.responseText;				
				
				if(email_random_key == ''){
					alert("이미존재하는 이메일입니다. 다른 이메일을 입력해 주세요.");
					return;
				}else if(email_random_key != null){
					alert("인증번호가 전송되었습니다. 입력하신 이메일에서 확인해 주세요.");
				}
				
			}
		}
		
		function email_auth_check(f) {
			
			var auth_text = f.auth_text.value.trim();
			
			if(auth_text == ''){
				alert("인증번호를 입력해 주세요");
				return;
			}
			
			if(auth_text != email_random_key){
				alert("인증번호를 다시 확인해 주세요.");
				return;
			}else if(auth_text == email_random_key){
				alert("이메일 인증이 완료되었습니다.");
				email_auth_click = true;
				
				document.getElementById("auth_text").readOnly = true;
				document.getElementById("email").readOnly = true;
			}
			
		}
		
		function sample6_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var addr = ''; // 주소 변수
	                var extraAddr = ''; // 참고항목 변수

	                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    addr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    addr = data.jibunAddress;
	                }

	                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
	                if(data.userSelectedType === 'R'){
	                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있고, 공동주택일 경우 추가한다.
	                    if(data.buildingName !== '' && data.apartment === 'Y'){
	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                    if(extraAddr !== ''){
	                        extraAddr = ' (' + extraAddr + ')';
	                    }
	                    // 조합된 참고항목을 해당 필드에 넣는다.
	                    document.getElementById("sample6_extraAddress").value = extraAddr;
	                
	                } else {
	                    document.getElementById("sample6_extraAddress").value = '';
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample6_postcode').value = data.zonecode;
	                document.getElementById("sample6_address").value = addr;
	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById("sample6_detailAddress").focus();
	            }
	        }).open();
	    }
		
		
		</script>
		
	</head>
	
	<body>
		
		<div id="moviewrap">
			<jsp:include page="../header.jsp"/>
			<!-- header -->
			<%-- <div id="header">
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
					<form>
						<h3 style="margin-left:34%;">회원가입</h3>
						<ul>
							<li class="li1">				
						   		<div class="input_wrapper">
						   			<input class="form_field" placeholder="ID" name="id" id="id" required width="640px">
						   			
						   			
						   			<input type="password" class="form_field" placeholder="Password" name="pwd" id="pwd" required />
						   			<input type="password" class="form_field" placeholder="Password_Confirm" name="pwd2" id="pwd2" required />
						   			<input class="form_field" placeholder="Name" name="name" id="name" required />
						   			<input class="form_field" placeholder="Telephone" name="tell" id="tell" required />
						   			<input class="form_field" placeholder="Email" name="email" id="email" required />
						   			<input type="button" class="btn btn-primary btn-block btn-large" value="인증 메일 보내기" onClick="email_auth(this.form);" style="margin-bottom:10px;">
						   			
						   			<input class="form_field" placeholder="Post_Code" name="postcode" id="sample6_postcode" required onclick="sample6_execDaumPostcode()"/>
						   			<input class="form_field" placeholder="Detail Address" name="d_addr" id="sample6_detailAddress" required />
						   			
						   			
						   			<input type="button" value="가 입 하 기" class="btn btn-primary btn-block btn-large" onclick="signup(this.form);">
		
						    	</div>
				    		</li>
				    		
				    		<li class="li2">				
						   		<div class="input_wrapper">
						   			<input type="button" class="btn btn-primary btn-block btn-large" value="ID 중복체크" onclick="id_check(this.form);">
						   			<input class="form_field" placeholder="Email Authentication Number" name="auth_text" id="auth_text" required style="margin-top:205px;"/>
						   			<input type="button" class="btn btn-primary btn-block btn-large" value="인증번호 확인" onClick="email_auth_check(this.form);" style="margin-bottom:10px;">
						   			
						   			<input class="form_field" placeholder="Address" name="addr" id="sample6_address" required />
						   			<input class="form_field" placeholder="Extra Address" name="ex_addr" id="sample6_extraAddress" required />
						   			
						   			<input type="button" value="취         소" class="btn btn-primary btn-block btn-large" onClick="history.go(-1);" >
						    	</div>
				    		</li>
				   		</ul>
					</form>
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
						<img src="${ pageContext.request.contextPath }/resources/img/logo_test.png">
					</p>
					
					<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
					<p class="team1">2조 Spring Project Movie</p>
					<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
				</div>
			</div>
			<!-- footer 끝 -->
		
		
		</div>
		
		<!-- <form>				
				<div id="main_box" align="center">
					<div align="center" class="title_div">
						<caption><h1> 회원 가입 < Membership join > </h1></caption>
					</div>
					
					
					<div align="center" id="container">
					
					
						<div align="center" class="id_family">
							<h3 class="join_title">
								<label for="id">아이디</label>
								<input type="text" name="id" id="id" maxlength="20" placeholder="아이디 입력" style="padding:5px;">
								<input type="button" name="check_id" value="아이디 중복확인" onclick="id_check(this.form);">
							</h3>
						</div>
						
						
						<div align="center" class="pw_family1">
							<h3 class="join_title">
								<label for="id">비밀번호</label>
								<input type="password" name="pwd" value="" maxlength="20" placeholder="비밀번호 입력" style="padding:5px;">
							</h3>
						</div>
						
						
						<div align="center" class="pw_family2">
							<h3 class="join_title">
								<label for="id">비밀번호 재 확인 입력</label>
								<input type="password" name="pwd2" value="" maxlength="20" placeholder="비밀번호 한 번 더 OK" style="padding:5px;">
							</h3>
						</div>
						
						
						<div align="center" class="name_family">
							<h3 class="join_title">
								<label for="id">이름 (name)</label>
								<input type="text" name="name" value="" maxlength="20" placeholder="내 이름은..." style="padding:5px;">
							</h3>
						</div>
										
						<div align="center" class="email_family">
							<h3 class="join_title">
								<label for="id">이메일주소 (E_mail)</label>
								<input type="text" name="email" id="email" maxlength="20" placeholder="ex)wow1234@naver.com" style="padding:5px;">
								<input type="button" value="인증 메일 보내기" onClick="email_auth(this.form);">
							</h3>
						</div>
						
						<div align="center" class="email_family">
							<h3 class="join_title">
								<label for="id">이메일 인증</label>
								<input type="text" name="auth_text" id="auth_text" maxlength="20" style="padding:5px;">
								<input type="button" value="확인" onClick="email_auth_check(this.form);">
							</h3>
						</div>
						
						
						<div align="center" class="phone_family">
							<h3 class="join_title">
								<label for="id">휴대폰번호 (mobile number)</label>
								<input type="text" name="tell" value="" maxlength="20" placeholder="ex)010-1234-9999" style="padding:5px;">
							</h3>
						</div>
						
						<div align="center" class="addr_family">
							<h3 class="join_title">
								<label for="id">주소 (Address)</label>
								<input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호">
								<input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"><br>
								
								<input type="text" name="addr" id="sample6_address" placeholder="주소"><br>
								<input type="text" name="d_addr" id="sample6_detailAddress" placeholder="상세주소">
								<input type="text" name="ex_addr" id="sample6_extraAddress" placeholder="참고항목">				
							</h3>
						</div>
						
					
					</div>
						
						
				
				<div class="btn_area" align="center">

					<button type="button" id="btnJoin" class="btn_join" onclick="signup(this.form);">
						<span>가입하기</span>
					</button>
					
					<button type="button" id="cancleJoin" class="btn_cancle" onclick="history.go(-1);">
						<span>뒤로가기</span>
					</button>
					
				</div>
			
		</form> -->
	</body>
</html>