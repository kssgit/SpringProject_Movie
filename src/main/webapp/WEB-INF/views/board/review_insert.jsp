<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
   	
	<style type="text/css">
	body{padding:0; margin:0;}
		.btn_cancle{
					background:url(${pageContext.request.contextPath}/resources/img/btn_cancle.png) no-repeat;
					background-size:75px 20px;}
		.btn_close{
					background:url(${pageContext.request.contextPath}/resources/img/btn_close.png) no-repeat;
					background-size:75px 20px;
					color:white;}
		.close{width:30px; height:30px;}
		
		.top{background-color:gray; padding:0; margin:0;}
		
		.text{text-shadow:1px 1px 0 #D8D8D8; padding:0;}
		
		.padding{padding:0;
	}
	
	#star_grade a{
		text-shadow:
	    -1px -1px 0 black,
	    1px -1px 0 black,
	    -1px 1px 0 black,
	    1px 1px 0 black; 
	    text-decoration: none;
	    font-size:2em;
	    color: white;
    }
    
    #star_grade a.on{
    	font-size:2em;
    	color: gray;
    }
    .review{text-shadow:0 0 7px #585858;}
    
	</style>

	<script src="//code.jquery.com/jquery-3.3.1.min.js"></script>
	<script type="text/javascript">
		
		function starCheck( scope ) {	
			var hidden = document.getElementById("hidden");
			hidden.value = scope;
		}//starCheck()
	
		function send(){
			var f = document.f;
			var content = f.content.value.trim();
			var star = f.hidden.value;
			/* var test = f.m_name.value.trim(); */
			if(star == ''){
				alert("별점을 매겨주세요");
				return;
			}
			if(content == ''){
				alert("관람평을 작성해주세요");
				return;
			}
			
			f.submit();
			
			opener.location.reload(true); //<-- 안될시 이거빼면 수동으로 새로고침 해주면 잘됨 !!원래창 업로드
			window.close(); //팝업창 닫기
		}//send()
		
		function cancle(){
			opener.location.reload(); //원래창 업로드
			window.close(); //팝업창 닫기
		}

	</script>

</head>
<body>

	<form action="insert.do" method="GET" name="f">
		<table width=100% align="center" class="top">
			<tr>
				<td width="520">
					<h1 align="ceneter" class="review">&nbsp&nbsp&nbsp관람평 작성하기 </h1> 
				</td>
				<td width="60"></td>
				<td><img src="${pageContext.request.contextPath}/resources/img/close.png" class="close"
					onclick="cancle();" align="center"></td>
			</tr>	
		</table>
		
		<table width=100% align="center">
			<tr><td><input type="hidden" id="hidden" name="scope"></td></tr>
			<tr><td><input type="hidden" id="id" value="${param.id}" name="id"></td></tr>
			<tr><td><input type="hidden" id="m_name" value="${param.m_name}" name="m_name"></td></tr>
			<tr><td><input type="hidden" id="type" value="${param.type}" name="type"></td></tr>
			<tr><td><input type="hidden" id="totalVar1" value="${param.totalVar1}" name="totalVar1"></td></tr>
			<tr><td><input type="hidden" id="totalVar2" value="${param.totalVar2}" name="totalVar2"></td></tr>

			
			<tr><td><p></p></td></tr>
			<tr><td><p></p></td></tr>
			<tr>
				<td align="center" class="text">평점을 남겨보세요! </td>
			</tr>
			
			<tr>
				<td align="center" class="padding">
					<p id="star_grade">
						<a href="#" id="scope" onclick="starCheck(1);">★</a>
						<a href="#" id="scope" onclick="starCheck(2);">★</a>
						<a href="#" id="scope" onclick="starCheck(3);">★</a>
						<a href="#" id="scope" onclick="starCheck(4);">★</a>
						<a href="#" id="scope" onclick="starCheck(5);">★</a>
					</p>
					<script>
					        $('#star_grade a').click(function(){
					            $(this).parent().children("a").removeClass("on");  
					            $(this).addClass("on").prevAll("a").addClass("on"); 
					          
					            return false;
					        });
					</script>
				</td>
			</tr>
			
			<tr><td><p></p></td></tr>
			<tr><td><p></p></td></tr>
			
			<tr class="two">
				<td width="520" colspan="2" align="center">
				<textarea name="content" id="content" rows="10" cols="70" align="center"
						placeholder=" 영화에 대한 후기를 남겨주세요."></textarea>
				</td>
			</tr>
			
			<tr><td><p></p></td></tr>
			<tr><td><p></p></td></tr>
			<tr><td><p></p></td></tr>
		</table>
		
		<table align="center" class="two">
			<tr>
				<td align="center" onclick="cancle();"><a class="btn_cancle">&nbsp&nbsp&nbsp&nbsp취소&nbsp&nbsp&nbsp&nbsp</a></td>
				<td align="center" onclick="send();"><a class="btn_close">&nbsp&nbsp&nbsp&nbsp등록&nbsp&nbsp&nbsp&nbsp</a></td>
			</tr>
		</table>
		
	</form>
</body>
</html>
