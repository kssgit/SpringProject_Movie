<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@include file="check_login.jsp" %>

<%
	response.setHeader("cache-control","no-store");
	response.setHeader("expires","0");
	response.setHeader("pragma","no-cache");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="${pageContext.request.contextPath }/resources/js/httpRequest.js"></script>
<style type="text/css">
*{margin: 0 ;padding: 0}
body{
           background-image: url(${ pageContext.request.contextPath }/resources/img/footer_bg.png);
           background-repeat: repeat;
           
       }
/* footer */

#footer{ width:100%; height:300px; position:absolute; margin-top:900px;}
#footer .f_logo{ width:150px; height:150px; position:absolute; margin-top:-3px; }
#footer .f_logo > img{ width:150px; height:150px; }

#footer .f_txt{ width:50%; height:150px; position:relative; margin:25px auto; }
#footer address{ width:100%; height:30px; position:absolute; margin:30px auto; text-align:center; color:white; }
#footer .team1{ width:100%; height:30px; position:absolute; margin:60px auto; text-align:center; color:white; }
#footer .team2{ width:100%; height:30px; position:absolute; margin:90px auto; text-align:center; color:white; }


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
.modify {

    width:100px;

    background-color: rgb(119, 119, 119, 0.3);

    border: none;

    color:white;

    padding: 15px 0;

    text-align: center;

    text-decoration: none;

    display: inline-block;

    font-size: 15px;

    margin: 4px;

    cursor: pointer;
    border-radius:10px;

}
.modify :hover {
    font-size: 20px;
    font-weight: bold;
}


</style>

<script type="text/javascript">
window.onload=function(){
	ticketview();
}
	function ticketview() {
		var url="selectticket.do";
		var param="id="+'${ sessionScope.user.id }';
		sendRequest( url, param, resultFn, "GET" );
	}
	function resultFn() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
		    var data = xhr.responseText;
			var json=eval(data);
			var div =document.getElementById("ticket");
			for(var i = 0 ; i < json.length ; i++){
				var indiv = document.createElement("div");
		    	var p = document.createElement("p");
		    	p.style.float="left";
		    	
		    	p.innerHTML="????????????:"+json[i].t_idx+" / ?????? :"+json[i].m_name+" / ?????? : "+json[i].seat+"/ ????????? :"+json[i].city+" "+json[i].district+"/ ?????? :"+(json[i].time).substring(0,16)+"/ ????????????:"+json[i].pay_money+"???";
		    	//alert(p.innerHTML);
		    	indiv.appendChild(p);
				div.appendChild(indiv);
			}
			if(json.length==0){
				var indiv = document.createElement("div");
		    	var p = document.createElement("p"); 
		    	p.innerHTML="????????? ????????? ????????????..."
		    		indiv.appendChild(p);
				div.appendChild(indiv);
			}
			review();
		}
	}
	
	
	function review() {
		var url="selectreview.do";
		var param="id="+'${ sessionScope.user.id }';
		sendRequest( url, param, resultFn2, "GET" );
	}
	function resultFn2() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
		    var data = xhr.responseText;
			var json=eval(data);
		
			var div =document.getElementById("myReview");
			for(var i = 0 ; i < json.length ; i++){
				var indiv = document.createElement("div");
		    	var p = document.createElement("p");
		    	p.style.float="left";
		    	p.innerHTML="?????? ??????:"+json[i].m_name+" / ??? :"+json[i].content+" / ?????? : "+json[i].scope+"/????????? :"+json[i].regdate;
		    	//alert(p.innerHTML);
		    	indiv.appendChild(p);
				div.appendChild(indiv);
			}
			if(json.length==0){
				var indiv = document.createElement("div");
		    	var p = document.createElement("p");
		    	p.innerHTML="????????? ????????? ????????? ????????????..."
		    		indiv.appendChild(p);
				div.appendChild(indiv);
			}
		}
	}
	
</script>
</head>
<body>

  <jsp:include page="../header.jsp"/>
  <div style="width:100% ;height:600px  ;margin:300px auto ;overflow: hidden;position: absolute;" align="center">
 
	 <P style="width:80%; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px;">${ sessionScope.user.name }??? ???????????????</P>
	 <div>
	  <a href="change_info_form.do" class="modify">???????????? ??????</a>
	  <a href="confirm_pwd.do?l_idx=${param.l_idx}" class="modify">?????? ??????</a>
	 </div>
	
	 <P style="width:80%; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px;">?????? ?????? ??????</P>
 	
 	 <div id= "ticket" style="overflow:scroll;overflow-x:hidden; width:80%; height:100px;background-color:#F4F1E5;border-radius: 8px;">
 		
 	 </div>
 	
 	<P style="width:80%; height:50px; background:rgb(119, 119, 119, 0.3); color:white; border-radius:20px; text-align:center; font-size:20px; font-weight:bold; line-height:50px;">?????? ??????</P>
 	 <div id="myReview"  style="overflow:scroll;overflow-x:hidden; width:80%; height:100px;background-color:#F4F1E5;border-radius: 8px;">
 		
 	 </div>
 </div>
 
 
 
  <div id="footer">
			
			<div class="f_txt">
				<p class="f_logo"><img src="${ pageContext.request.contextPath }/resources/img/logo_test.png"></p>
				<address>??????????????? ????????? ????????? 136 ??????????????? 2???,3???</address>
				<p class="team1">2??? Spring Project Movie</p>
				<p class="team2">??????, ??????, ??????, ??????, ??????, ??????</p>
			</div>
		</div>
		<!-- footer ??? -->
		
		
 
</body>
</html>