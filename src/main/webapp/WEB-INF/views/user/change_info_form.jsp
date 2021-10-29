<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	response.setHeader("cache-control","no-store");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보 변경</title>
	
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/user.css">
	
	
	<style>
		body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat; 
       }
		.find_id_pwd_form {align:center; padding-top:40px;}
		.find_id_pwd_form ul > li {list-style:none;}
		.find_id_pwd_form h3 {width:300px; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px; margin-bottom:20px;}
		.li1{float:left; width:300px; height:auto; margin-left:33%;}
		.li2{float:left; width:300px; height:auto; margin-left:4%;}
		.find_id_pwd_form{overflow:hidden;}
		
		#footer{ width:100%; height:200px; margin-top:930px;}
	</style>
	
	<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>

	<script>
		// 회원정보 변경 함수
		function change_info(f) {
			
			var id = f.id.value;
			var name = f.name.value;
			var l_idx = f.l_idx.value.trim();
			var postcode = f.postcode.value;
			var addr = f.addr.value;
			var d_addr = f.d_addr.value;
			var ex_addr = f.ex_addr.value;
			var tell = f.tell.value.trim();
			var email = f.email.value.trim();
			
			
			// 유효성 체크			
			if(tell == ''){
				alert("연락처를 입력해 주세요.");
				return;
			}
			
			if(email == ''){
				alert("이메일을 입력해 주세요.");
				return;
			}
			
			var url = "change_user_info.do";
			var param = "l_idx="+l_idx+"&id="+id+"&name="+name+"&tell="+tell+"&email="+email+"&postcode="+postcode+"&addr="+addr+"&d_addr="+d_addr+"&ex_addr="+ex_addr;
			sendRequest(url, param, resultFn, "get");
			
			/* f.method = "post";
			f.action = "change_user_info.do";
			f.submit(); */
						
		}
		
		function resultFn() {
			if(xhr.readyState == 4 && xhr.status == 200){
				var data = xhr.responseText;
				var json =  eval("[" + data + "]");
				
				/* alert(data);
				alert(json); */
				if(json == ''){
					alert("회원 정보 수정 실패!");
					return;
				}else{
					alert("회원 정보가 성공적으로 변경되었습니다.");
				}
				return location.href="mypage.do?l_idx="+json[0].l_idx;	
				
			}
		}
		
		
		// 비밀번호 변경 함수
		function change_pwd(f) {
			
			var l_idx = f.l_idx.value.trim();
			var old_pwd = f.old_pwd.value.trim();
			var pwd = f.pwd.value.trim();
			var new_pwd_cfm = f.new_pwd_cfm.value.trim();
					
			// 비밀번호 변경	
			if(old_pwd != "${sessionScope.user.pwd}"){
				alert("현재 비밀번호가 일치하지 않습니다.");
				return;
			} 
			
			if(pwd == '' || new_pwd_cfm == ''){
				alert("새로운 비밀번호를 입력해 주세요");
				return;
			}
			
			//비밀번호 정규식
			var pw_pat = /^.*(?=^.{8,15}$)(?=.*\d)(?=.*[a-zA-Z])(?=.*[!@#$%^&+=]).*$/;			
			if( !pw_pat.test(pwd)) {
				alert("비밀번호는 숫자와 문자 특수문자 포함 형태의 8~15자리 이내로 입력해 주세요.");
				return;
			}
			
			if(old_pwd == "${sessionScope.user.pwd}"){
				if(pwd != new_pwd_cfm){
					alert("새로운 비밀번호가 일치하지 않습니다. 다시 확인해 주세요.");
					return;
				}else{
					
					f.method = "post";
					f.action = "change_pwd.do";
					f.submit();
				}
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
		
		
		// 현재 비밀번호 입력 여부 확인
		function input_check(f){
			
			var old_pwd = f.old_pwd.value.trim();
			var pwd = document.getElementById("pwd");
			var new_pwd_cfm = document.getElementById("new_pwd_cfm");
			
			if(!old_pwd == ''){
				pwd.disabled = false;
				new_pwd_cfm.disabled = false;
			}else{
				pwd.disabled = true;
				new_pwd_cfm.disabled = true;
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
			
			<div class="find_id_pwd_form">
				<ul>
					<li class="li1">				
						<h3>회원정보 변경</h3>
					   	<form>
					   		<input type="hidden" name="l_idx" value="${ sessionScope.user.l_idx }">
					   	
					   		<div class="input_wrapper">
					   			<input class="form_field" name="id" id="id" value="${ sessionScope.user.id }" readonly />
					   			<input class="form_field" name="name" id="name" value="${ sessionScope.user.name }" readonly />
					   			<input class="form_field" placeholder="Telephone" name="tell" id="tell" value="${ sessionScope.user.tell }" required />
					   			<input class="form_field" placeholder="Email" name="email" id="email" value="${ sessionScope.user.email }" required />
					   			
					   			<!-- <h3 style="margin-top:10px;">주    소</h3> -->
					   			<input class="form_field" placeholder="Post_Code" name="postcode" id="sample6_postcode" value="${ sessionScope.user.postcode }" required onclick="sample6_execDaumPostcode()"/>
					   			<input class="form_field" placeholder="Address" name="addr" id="sample6_address" value="${ sessionScope.user.addr }" required />
					   			<input class="form_field" placeholder="Detail Address" name="d_addr" id="sample6_detailAddress" value="${ sessionScope.user.d_addr }" required />
					   			<input class="form_field" placeholder="Extra Address" name="ex_addr" id="sample6_extraAddress" value="${ sessionScope.user.ex_addr }" required />
					   			
					   			<input type="button" value="회원정보 변경" class="btn btn-primary btn-block btn-large" onClick="change_info(this.form);">
								<input type="button" value="취소" class="btn btn-primary btn-block btn-large" onClick="history.go(-1);" style="margin-top:10px;">
					    		
					    	</div>
					    </form>
			    	</li>
			    	
			    	<li class="li2">				
						<h3>비밀번호 변경</h3>
					   	<form>
					   		<input type="hidden" name="l_idx" value="${ sessionScope.user.l_idx }">
					   		
					   		<div class="input_wrapper">
					   			<input type="password" class="form_field" placeholder="Current Password" name="old_pwd" id="old_pwd" onkeyup="input_check(this.form);" required />
					   			<input type="password" class="form_field" placeholder="New Password" name="pwd" id="pwd" disabled />
						   		<input type="password" class="form_field" placeholder="New Password_Confirm" name="new_pwd_cfm" id="new_pwd_cfm" disabled />
					   			<input type="button" value="비밀번호 변경" class="btn btn-primary btn-block btn-large" onClick="change_pwd(this.form);">
								<input type="button" value="취소" class="btn btn-primary btn-block btn-large" onClick="history.go(-1);" style="margin-top:10px;">
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
						<img src="${ pageContext.request.contextPath }/resources/img/logo_test.png">
					</p>
					
					<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
					<p class="team1">2조 Spring Project Movie</p>
					<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
				</div>
			</div>
		<!-- footer 끝 -->

	</div>
	
	<%-- <h3 align="center">회원 정보 변경</h3>

	<form>
		<input type="hidden" name="l_idx" value="${ sessionScope.user.l_idx }">
				
		<table align="center" width="400">

			<tr>
				<td align="center">아이디 :</td>
				<td><input name="id" value="${ sessionScope.user.id }" readonly></td>
			</tr>

			<tr>
				<td align="center">이름 :</td>
				<td><input name="name" value="${ sessionScope.user.name }" readonly></td>
			</tr>

			<tr>
				<td colspan="2"><br></td>
			</tr>

			<tr>
				<td align="center">주소 :</td>
				<td><input type="text" name="addr" value="${ sessionScope.user.addr }"></td>
				<td><input type="text" name="postcode" id="sample6_postcode" placeholder="우편번호" value="${ sessionScope.user.postcode }"></td>
				<td><input type="button" onclick="sample6_execDaumPostcode()" value="우편번호 찾기"></td>
				
				<td><input type="text" name="addr" id="sample6_address" placeholder="주소" value="${ sessionScope.user.addr }"></td>
				<td><input type="text" name="d_addr" id="sample6_detailAddress" placeholder="상세주소" value="${ sessionScope.user.d_addr }"></td>
				<td><input type="text" name="ex_addr" id="sample6_extraAddress" placeholder="참고항목" value="${ sessionScope.user.ex_addr }"></td>
			</tr>
			
			<tr>
				<td colspan="2"><br></td>
			</tr>
			
			<tr>
				<td align="center">연락처 :</td>
				<td><input type="text" name="tell" value="${ sessionScope.user.tell }"></td>
			</tr>
			
			<tr>
				<td colspan="2"><br></td>
			</tr>
			
			<tr>
				<td align="center">이메일 :</td>
				<td><input type="text" name="email" value="${ sessionScope.user.email }"></td>
			</tr>
			
			<tr>
				<td colspan="2"><br></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="회원 정보 수정" onClick="change_info(this.form);">
				</td>
			</tr>
			

		</table>

	</form>
	
	
	<form>
		<input type="hidden" name="l_idx" value="${ sessionScope.user.l_idx }">
				
		<table align="center" width="400">

			<tr>
				<td colspan="2" align="center"><strong>비밀번호 변경</strong></td>
			</tr>

			<tr>
				<td align="center">현재 비밀번호 :</td>
				<td><input type="password" name="old_pwd" onkeyup="input_check(this.form);"></td>
			</tr>
	
			<tr>
				<td align="center">새로운 비밀번호 :</td>
				<td><input type="password" id="pwd" name="pwd" disabled></td>
			</tr>
	
			<tr>
				<td align="center">새로운 비밀번호 확인 :</td>
				<td><input type="password" id="new_pwd_cfm" name="new_pwd_cfm" disabled></td>
			</tr>
			
			<tr>
				<td colspan="2"><br></td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="비밀번호 변경" onClick="change_pwd(this.form);">
				</td>
			</tr>
			
			<tr>
				<td colspan="2" align="center">
					<input type="button" value="취소" onClick="history.go(-1)">
				</td>
			</tr>
			

		</table>

	</form> --%>
	

</body>

</html>