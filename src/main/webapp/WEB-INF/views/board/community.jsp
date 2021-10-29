<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
	<link rel="stylesheet" href="${ pageContext.request.contextPath }/resources/css/community.css">
	<style type="text/css">
	   body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat;
       }
	</style>
	
	<script type="text/javascript" src="${ pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
	<script type="text/javascript">
		if (self.name != 'reload') {
	        self.name = 'reload';
	        self.location.reload(true);
	    }
	    else self.name = '';
	
		function dotcheck(id, m_name){
	         var id_u = document.getElementById("id").value.trim();
	         var user = document.getElementById("user_"+id+"m_name_" + m_name);
	         var user2 = document.getElementById("user2_"+id+"m_name2_"+m_name);
	         
	         if(id == id_u){
	            user.style.display = 'block';
	            return;
	         }
	         user2.style.display = 'block';
	    }
		
		//x누르면 닫게
	    function cancle(id, m_name){
	         var user = document.getElementById("user_"+id+"m_name_" + m_name);
	         var user2 = document.getElementById("user2_"+id+"m_name2_"+m_name);
	         
	         user.style.display="none";
	         user2.style.display="none";
	    }
		
	    //수정
	    function modify(m_name){
	         var id = document.getElementById("id").value.trim();

	         window.open("modify_form.do?id="+id+"&m_name="+m_name, "수정하기", "width=665px, height=660px, left=370px, top=50px");
	    }
	      
	      //리뷰 지우고 돌아오기
	      function del(m_name){
	         var id = document.getElementById("id").value.trim();
	         
	         if(!confirm("정말 삭제 하시겠습니까?")){
	            return;
	         }
	         
	         var url = "delete.do";
	         var param = "id=" + id + "&m_name=" + m_name;

	         sendRequest(url, param, resultFnReview2, "POST");   
	      }
	      
	      function resultFnReview2(){
	          if(xhr.readyState == 4 && xhr.status == 200){
	             var data = xhr.responseText;
	             
	             if(data == 'no'){
	                alert("삭제 실패");
	             }
	             alert("삭제 성공");
	             location.href = location.href;
	          }
	       }
	</script>
</head>
<body>
	<!-- header -->
	<jsp:include page="../header.jsp"/>
	<!-- header 끝 -->

	<input type="hidden" action="checkLogin.do" method="GET" name="id" id="id" value="${sessionScope.user.id }">
	
	<div class="container">
	<table class="table">
		
		<tr class="table_head">

			<th width="100" align="center">아이디</th>
	
			<th width="260" align="center" >영화</th>

			<th width="60" class="td_b" align="center">평점</th>

			<th width="600" class="td_b" align="center">관람평</th><!-- <pre>관람평</pre> -->

			<th width="76" class="td_b" align="center"></th>
			
			

		</tr>
		
		<c:forEach var="list" items="${list}">
		<tr>
			<td colspan="11" align="right">
			<div class="user" id="user_${list.id}m_name_${list.m_name}" align="right"
				style="position: absolute; left:860px;  background:url(${pageContext.request.contextPath}/resources/img/text.png); background-size:200px 100px;
	 			background-position:center; background-repeat: no-repeat; display:none;">
			<input width="15" height="15" type="image" name="button"
				class="close" src="${pageContext.request.contextPath}/resources/img/close.png"
				onclick="cancle('${list.id}','${list.m_name }');">
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>&nbsp&nbsp&nbsp&nbsp&nbsp
			<input type="button" value="수정" onclick="modify('${list.m_name}');">
			<input type="button" value="삭제" onclick="del('${list.m_name}');">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br><br>
			</div>

			<div name="no" class="user2" id="user2_${list.id}m_name2_${list.m_name}"
				style="background:url(${pageContext.request.contextPath}/resources/img/text.png); background-size:320px 110px;
               			background-position:center; background-repeat: no-repeat; font-size:12px; position: absolute; left:800px; text-align:center; display:none;">
				<br> &nbsp&nbsp&nbsp스포일러 및 욕설/비방하는
				<input width="15" height="15" type="image" name="button" class="close"
					src="${pageContext.request.contextPath}/resources/img/close.png"
					onclick="cancle('${list.id}','${list.m_name }');">&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br>
				&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp내용이 있습니까? &nbsp
				<a href="#">신고</a>&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<br><br>
			</div>
			</td>
		</tr>
			
		<tr class="table_box">
			
				
			<td width="100" align="center">${list.id }</td>
							
			<td width="260" align="center" id="m_name_+${list.m_name }">${list.m_name }</td>
	
			<td width="40" class="td_b" align="center">${list.scope }</td>

			<td width="600" overflow:hidden; class="td_b" align="center">${list.content }</td>
			<td width="76" class="td_b" align="center">
			<input width="15"
				height="15" type="image" name="button"
				src="${pageContext.request.contextPath}/resources/img/dot.png"
				onclick="dotcheck('${list.id}', '${list.m_name }');"><br>
			</td>
			
		</tr>
		<tr><td colspan="11" align="right">${list.regdate}</td></tr>		
		</c:forEach>
		<tr>
			<td colspan="11" align="center" height="70px;">${ pageMenu }</td>
		</tr>
	</table>
	</div>
	
	<!-- footer -->
	<div id="footer" style="margin-top:300px;">
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
</body>
</html>