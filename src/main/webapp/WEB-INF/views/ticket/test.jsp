<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>예매</title>

<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/select.js"></script>
<style type="text/css">
*{margin: 0; padding: 0;}
.st{width:90px;

    background-color: #F4F1E5;

    border: none;

    color:#4E4D49;
	굴림;
    padding: 15px 0;

    text-align: center;

    text-decoration: none;

    display: inline-block;

    font-size: 10px;
	
	font-weight:normal;
	
    margin: 4px;

    cursor: pointer;

}

 input:hover {
    background-color:#393836;
    color:#F4F1E5;
    
}
body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat;
           
       }

/* //div스크롤바 꾸미기  */
div::-webkit-scrollbar {
    width: 8px;
  }
  div::-webkit-scrollbar-thumb {
    background-color: #2f3542;
    border-radius: 8px;
    background-clip: padding-box;
    border: 2px solid transparent;
  }
  div::-webkit-scrollbar-track {
    background-color: grey;
    border-radius: 8px;
    box-shadow: inset 0px 0px 5px white;
  }



/* footer */

#footer{ width:100%; height:300px; position:absolute; margin-top:900px;}
#footer .f_logo{ width:150px; height:150px; position:absolute; margin-top:-3px; }
#footer .f_logo > img{ width:150px; height:150px; }

#footer .f_txt{ width:50%; height:150px; position:relative; margin:25px auto; }
#footer address{ width:100%; height:30px; position:absolute; margin:30px auto; text-align:center; color:white; }
#footer .team1{ width:100%; height:30px; position:absolute; margin:60px auto; text-align:center; color:white; }
#footer .team2{ width:100%; height:30px; position:absolute; margin:90px auto; text-align:center; color:white; }
</style>
<script type="text/javascript">
window.onload=function(){
	load_list();

 };
 function select() {
	
	 
	if( ${empty param.m_name} ){
		
		return;
	}else{
	document.getElementById("${param.m_name}").click();
	document.getElementById("${param.m_name}").focus();
	} 
	return;
 }
</script>
</head>
<body>

 <jsp:include page="../header.jsp"/>
 


<div  style="width:100% ;height:600px  ;margin:300px auto ;overflow: hidden;position: absolute;" align="center">

<!--영화 출력  -->
	
	<P style="width:80%; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px;">영화 상영관 선택</P>
	<div style="width:1200px; margin:50px auto; ">
	
		<div style="float:left;margin: 4px;">
			<div><p style="width:100%; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px;">영화</p></div>
			<div class="movie_select" id="movie_select" style="overflow:scroll;overflow-x:hidden; width:190px; height:200px;background-color:#F4F1E5;border-radius: 8px;">
			
			</div>
		</div>
	

		
		<div style="margin: 4px;float:left;">
			<div ><p style="width:100%; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px;">극장</p></div>
			<div>
				
			<div id="city_select" style="overflow:scroll;overflow-x:hidden; width:190px; height:200px;float:left;background-color:#F4F1E5;border-radius: 8px;">
			</div>
			
			<div id="district_select" style="overflow:scroll; overflow-x:hidden;width:190px; height:200px;float:left;background-color:#F4F1E5 ; border-radius: 8px;">
			
			</div>
			</div>
		</div>
	


<!--날짜 출력  -->
		
		<div style="margin: 4px;float:left;">
			<div ><p style="width:100%; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px;">날짜 및 시간</p></div>
			<div>
				<div id="date_select" style="overflow:scroll; overflow-x:hidden;width:190px; height:200px;float:left;background-color:#F4F1E5; border-radius: 8px;">
				
				</div>

<!--상영시간 출력  -->
				<div id="time_select" style="overflow:scroll;overflow-x:hidden; width:190px; height:200px;float:left;background-color:#F4F1E5 ;border-radius: 8px;">
				
				</div>
			</div>
		</div>

<!-- 예매 정보 한번에 보기 -->
<div style="margin: 4px;float:left;border-radius: 8px;">
<div style=" margin-bottom:10px"><p style="width:100%;height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px;">예매 정보</p></div>
<form  action="ticketform.do" method="get">

	<table style="background-color:transparent" >
	<tr>
		<td><input name="m_name" id="m_name" readonly style="border:none;background-color:transparent;color:white;font-size: 15px"></td>
	</tr>
	<tr>
		<td><input name="city" id="city" readonly style="border:none;background-color:transparent;color:white;font-size: 15px"></td>
	</tr>
	<tr>
		<td><input name="district" id="district" readonly style="border:none;background-color:transparent;color:white;font-size: 15px"></td>
	</tr>
	<tr>
		<td><input name="time" id="time" readonly style="border:none;background-color:transparent;color:white;font-size:15px"></td>
	</tr>
	
	</table>
	<input type="hidden" name="date_s" id="date" readonly style="border:none">
	<div>
	<input type="button" value="좌석 선택하기" onclick="send(this.form);" style="float:left ;width:65%; height:12%; display:block;  margin-top:12px; background:rgb(3, 123, 148, 0.8); text-align:center; border-radius:20px;"> 
	</div>
	
	
</form>
</div>
</div>
</div>
<!-- footer -->
		<div id="footer" style="margin-top:800px;">
			
			<div class="f_txt">
				<p class="f_logo"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></p>
				<address>서울특별시 마포구 서강로 136 아이비티워 2층,3층</address>
				<p class="team1">2조 Spring Project Movie</p>
				<p class="team2">민형, 성수, 우성, 선영, 원경, 유진</p>
			</div>
		</div>
		<!-- footer 끝 -->

</body>
</html>