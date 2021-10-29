
function load_list(){
	// 조회할 날짜를 계산

	var dt = new Date();
	//하루전 날짜 
	dt.setTime(new Date().getTime() - (1 * 24 * 60 * 60 * 1000));
	
    var m = dt.getMonth() + 1;
	if (m < 10) {
		var month = "0" + m;
	} else {
		var month = m + "";
	}

	var d = dt.getDate();
	var day='';
	if(d<10){
		var day = "0" + d;
	}else {
		var day = d + "";
	}

	

	var y = dt.getFullYear();
	var year = y + ""; 

	var result = year + month + day;
	
    //192.168.1.101:9090/vs/list.do
    var url ='http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json';
    //하루전 박스오피스순으로 출력(10위 까지만)
    var param = 'key=a7c6bfb2e16d4d1ae14730f90bc6726a&targetDt='+result+'&itemPerPage=10';
    sendRequest( url, param, resultFn, "GET" );
    
 }
 
 function resultFn(){
    if( xhr.readyState == 4 && xhr.status == 200 ){
       var data = xhr.responseText;
       var json=eval("[" + data + "]");
     	
       //id가 movie_select인 태그를 가져온다
       var movie_select =document.getElementById("movie_select")
       
      for(var i=0 ; i<json[0].boxOfficeResult.dailyBoxOfficeList.length ; i++){
    	 
    	  var div = document.createElement("div");
    	  var input = document.createElement("input");
    	  input.type="button";
    	  input.classList = "st";
    	  input.style.width="170px";
    	  input.id=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;
    	  input.value=json[0].boxOfficeResult.dailyBoxOfficeList[i].movieNm;//영화 이름
    	  input.onclick=function(e){
    		  movie(e.target.value, e.target);
    	  }
		  div.appendChild(input);
		  movie_select.appendChild(div);
      }
       select();
       
    }  
    
 }
 
 //--------------------------------------------------------
 
 //--------------------------------------------------------

//영화 클릭시 실행되는 메서드
 var m_id='';
	function movie(movieNm, id) {
		//영화이름 저장
		//var movieNm = document.getElementById("movie_select").value;
		if(movieNm==''){
			document.getElementById("m_name").value='';
			document.getElementById("m_name").innerHTML='';
			alert("영화를 선택하세요");
			return;
		}
		document.getElementById("m_name").value=movieNm;
		document.getElementById("m_name").innerHTML=movieNm;
		
		
		//해당 영화 버튼 클릭시 색깔 바뀌게 
		if(m_id != ''){
		m_id.style.fontSize=10+'px';
		m_id.style.fontWeight="normal";
		}
		id.style.fontWeight="bold";
		id.style.fontSize=15+'px';
		m_id=id;
		
		//영화 재 선택시 아래항목 리셋		
		var district_select = document.getElementById("district_select");
		var time_select = document.getElementById("time_select");
		var date_select = document.getElementById("date_select");
		var city_select =document.getElementById("city_select");
		 if(city_select.childElementCount>0){
			 while ( city_select.hasChildNodes() ){ 
				 city_select.removeChild( city_select.firstChild ); 
				 }
		} 
		 if(district_select.childElementCount>0){
			 while ( district_select.hasChildNodes() ){ 
				 district_select.removeChild( district_select.firstChild ); 
				 }
		} 
		 if(date_select.childElementCount>0){
			 while ( date_select.hasChildNodes() ){ 
				 date_select.removeChild( date_select.firstChild ); 
				 }
		} 
		 if(time_select.childElementCount>0){
			 while ( time_select.hasChildNodes() ){ 
				 time_select.removeChild( time_select.firstChild ); 
				 }
		} 
		//영화 재선택시 ticket에 저장된 영화제목 이외의 항목 제거 
	    document.getElementById("city").value="";
	    document.getElementById("city").innerHTML="";
	    document.getElementById("district").value="";
	    document.getElementById("district").innerHTML="";
	    document.getElementById("date").value="";
	    document.getElementById("date").innerHTML="";
	    document.getElementById("time").value="";
	    document.getElementById("time").innerHTML="";
		
		//각 영화가 상영하는 지역을 DB에서 가져와 출력
		var url="citylist.do"
		var param="m_name="+movieNm;
		sendRequest( url, param, resultFn2, "GET" );
	}
	
	function resultFn2() {
		
		if( xhr.readyState == 4 && xhr.status == 200 ){
			var data = xhr.responseText;
			var json = eval(data);
			
			if(data=="[]"){
				alert("해당영화의 상영관이 없습니다.");
			}
			var city_select =document.getElementById("city_select")
			
			for(var i=0 ; i<json.length; i++){
				var div = document.createElement("div");
		    	var input = document.createElement("input");
		    	input.type="button";
		    	input.style.width="170px";
		    	input.classList = "st";
				input.innerHTML=json[i].city;
				input.value=json[i].city;
				input.onclick=function(e){
		    		city(e.target.value,e.target);
		   
		    	 }
				  div.appendChild(input);
				  city_select.appendChild(div);
			}
		}
	}
	
	//----------------------------------------------------------------------------
	var c_id='';
	//지역 선택시 실행되는 메서드
	function city(city, id) {
		
		var movieNm = document.getElementById("m_name").value;
		//var city= document.getElementById("city_select").value;
		if(city==''){
			document.getElementById("city").value=city;
			document.getElementById("city").innerHTML=city;	
			alert("지역을 선택하세요");
			return;
		}
		//해당 영화 버튼 클릭시 색깔 바뀌게 
		if(c_id != ''){
		c_id.style.fontSize=10+'px';
		c_id.style.fontWeight="normal";
		}
		id.style.fontWeight="bold";
		id.style.fontSize=15+'px';
		c_id=id;
		
		//ticket에 아래 내용 저장
		document.getElementById("city").value=city;
		document.getElementById("city").innerHTML=city;
		
		//지역 재 선택시 ticket에 저장된 항목 초기화
		document.getElementById("district").value="";
	    document.getElementById("district").innerHTML="";
	    document.getElementById("date").value="";
	    document.getElementById("date").innerHTML="";
	    document.getElementById("time").value="";
	    document.getElementById("time").innerHTML="";
	    
	    
	    var district_select = document.getElementById("district_select");
		var time_select = document.getElementById("time_select");
		var date_select = document.getElementById("date_select");
		
		 if(district_select.childElementCount>0){
			 while ( district_select.hasChildNodes() ){ 
				 district_select.removeChild( district_select.firstChild ); 
				 }
		} 
		 if(date_select.childElementCount>0){
			 while ( date_select.hasChildNodes() ){ 
				 date_select.removeChild( date_select.firstChild ); 
				 }
		} 
		 if(time_select.childElementCount>0){
			 while ( time_select.hasChildNodes() ){ 
				 time_select.removeChild( time_select.firstChild ); 
				 }
		}
		
		//각 영화가 상영하는 지역의 상영관을 DB에서 가져와 출력
		
		var url="districtlist.do"
	
		var param="m_name="+movieNm+"&city="+city;
		sendRequest( url, param, resultFn3, "GET" );
	}//city
	
	function resultFn3() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
			var data = xhr.responseText;
			var json = eval(data);
			
			var district_select = document.getElementById("district_select");
			
			for(var i=0 ; i<json.length;i++){
				var div = document.createElement("div");
		    	var input = document.createElement("input");
		    	input.type="button";
		    	input.style.width="170px";
		    	input.classList = "st";
		    	input.innerHTML=json[i].district;
		    	input.value=json[i].district;
				
				input.onclick=function(e){
					district(e.target.value, e.target);
					
		    	 }
				  div.appendChild(input);
				  district_select.appendChild(div);
			}
		}
	}//resultFn3
	
	//------------------------------------------------------------------------
	var d_id='';
	//상영구? 선택시 실행
	function district(district,id) {
		var movieNm = document.getElementById("m_name").value;
		var city= document.getElementById("city").value;
		
		
		//
		if(district==''){
			document.getElementById("district").value=district;
			document.getElementById("district").innerHTML=district;
			alert("지역을 선택하세요");
			return;
		}
		
		//해당 영화 버튼 클릭시 색깔 바뀌게 
		if(d_id != ''){
			d_id.style.fontSize=10+'px';
			d_id.style.fontWeight="normal";
		}
		id.style.fontWeight="bold";
		id.style.fontSize=15+'px';
		d_id=id;
		
		//ticket에 아래 항목 저장
		document.getElementById("district").value=district;
		document.getElementById("district").innerHTML=district;
		
		//상영관 재선택시 아래 항목 초기화
		var date_select = document.getElementById("date_select");
		var time_select = document.getElementById("time_select");
		
		 if(date_select.childElementCount>0){
			 while ( date_select.hasChildNodes() ){ 
				 date_select.removeChild( date_select.firstChild ); 
				 }
		} 
		 if(time_select.childElementCount>0){
			 while ( time_select.hasChildNodes() ){ 
				 time_select.removeChild( time_select.firstChild ); 
				 }
		}
		//
		document.getElementById("date").value="";
	    document.getElementById("date").innerHTML="";
	    document.getElementById("time").value="";
	    document.getElementById("time").innerHTML="";
		
		//
		var url="datelist.do"
		var param="m_name="+movieNm+"&city="+city+"&district="+district;
		sendRequest( url, param, resultFn4, "GET" );
	}//district
	
	
	function resultFn4() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
			var data = xhr.responseText;
			var json = eval(data);
			
			//[{"max_month":"06","max_date":"04","min_month":"05","min_date":"28" , 'date_o':'2' , 'day':'목요일'}]
			
			//상영시작과 끝의 날자 수
			var date_o = json[0].date_o *1;
			
			//요일
			var day = json[0].day;
			
			//스크립트 날짜 클래스 
			var dt = new Date();
			//상영시작 달
			var m = json[0].min_month*1;
			var month = m+'';
			//사영 시작 일
			var d =  json[0].min_date*1;
			
			
			//요일(int형)
			var day_int = dt.getDay()//0~6
			
			//요일(리스트)        0    1     2     3     4   5   6
			var arrayDayStr=['일요일' ,'월요일' , '화요일' , '수요일', '목요일','금요일','토요일'];
			//해당 요일의 day_int 값 구하기
			for(var i=0 ; i < arrayDayStr.length ; i++){
				if(arrayDayStr[i]==day){
					day_int=i;
				}
			}
			
			//현재 요일 출력
			
			//년
			var y = dt.getFullYear();
			var year=y+'';
			
			//날짜 선택 태그 가져오기
			var date_select = document.getElementById("date_select");
				
				//사영날짜부터 사영종료 날짜까지 option태그 추가
				for(var j=0 ; j <date_o+1 ;j++){
					var div = document.createElement("div");
			    	var input = document.createElement("input");
			    	input.type="button";
			    	input.style.width="170px";
			    	input.classList = "st";
					input.value=month+'월 '+ d + '일 ' + day ;
					
					//날짜를 date형식으로 변환
					if(month <10){
						var mt = "0"+month;
					}
					if(d <10){
						var da="0"+d;
					}else{
						var da = d+"";
					}
					input.name=mt+""+da+""+year;
					input.onclick=function(e){
						date(e.target.name , e.target);
						
			    	 }
					div.appendChild(input);
					date_select.appendChild(div);
					d++;
					if(month=='1' ||month=='3' ||month=='5'||month=='7'||month=='8'||month=='10'||month=='12'){
						if(d>31){
							d=1;
							month++;
							if(month>12){
								month=1;
							}
						}
					}else if(month=='2'){
						if(d>28){
							d=1;
							month++;
						}
					}else{
						if(d>30){
							d=1;
							month++;
						}
					}
	
					day_int++;
					
					if(day_int >6){
						day_int=0;
					}
					
					day=arrayDayStr[day_int];
					
				}//for
			
		
		}//if
	}//resultFn4()
	
	//------------------------------------------------------------------------------	
	var D_id='';
	//상영 날짜 클릭시 실행
	function date(date ,id) {
		var movieNm = document.getElementById("m_name").value;
		var city= document.getElementById("city").value;
		var district= document.getElementById("district").value;
		
		
		if(date==''){
			document.getElementById("date").value=date;
			document.getElementById("date").innerHTML=date;
			alert("상세지역을 선택하세요");
			return;
		}
		
		//해당 영화 버튼 클릭시 색깔 바뀌게 
		if(D_id != ''){
			D_id.style.fontSize=10+'px';
			D_id.style.fontWeight="normal";
		}
		id.style.fontWeight="bold";
		id.style.fontSize=15+'px';
		D_id=id;
		
		document.getElementById("date").value=date;
		document.getElementById("date").innerHTML=date;
		
		
		document.getElementById("time").value="";
	    document.getElementById("time").innerHTML="";
	    
	   
		var time_select = document.getElementById("time_select");
		
		 if(time_select.childElementCount>0){
			 while ( time_select.hasChildNodes() ){ 
				 time_select.removeChild( time_select.firstChild ); 
				 }
		}
	    
		var date_s=date+"";
		var url="timelist.do";
		var param="m_name="+movieNm+"&city="+city+"&district="+district+"&date_s="+date_s;
		//alert(movieNm);
		sendRequest(url,param,resultFn5 , "get"); 
	}//date
	
	function resultFn5() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
			var data = xhr.responseText;
			var json = eval(data);
			
			
			var time_select = document.getElementById("time_select");
			for(var i=0 ; i<json.length;i++){
				var div = document.createElement("div");
		    	var input = document.createElement("input");
		    	input.type="button";
		    	input.style.width="170px";
		    	input.classList = "st";
		    	input.value=json[i].time.substring(11,13)+"시"+ json[i].time.substring(14,16)+"분"+"("+json[i].seat_Total+"석)";
				
		    	input.name=json[i].time;
		    	input.onclick=function(e){
		    		
					time(e.target.name , e.target);
				
		    	 }
		    	div.appendChild(input);
				time_select.appendChild(div);
			}
		}
	} //resultFn5
	
	
	//------------------------------------------------------------------------
	var t_id='';
	//시간 선택시 실행되는 메서드
	function time(time, id) {
		
		if(time==''){
			document.getElementById("time").value=time;
			document.getElementById("time").innerHTML=time;
			alert("상영시간을 선택하세요");
			return;
		}
		//해당 영화 버튼 클릭시 색깔 바뀌게 
		if(t_id != ''){
			t_id.style.fontSize=10+'px';
			t_id.style.fontWeight="normal";
		}
		id.style.fontWeight="bold";
		id.style.fontSize=15+'px';
		t_id=id;
		
		document.getElementById("time").value=time;
		document.getElementById("time").innerHTML=time;
	}
	
	//-------------------------------------------------------------------------
	
	//좌석선택 페이지로 넘어가기
	function send( f ) {
		//유효성 검사
		var movieNm = document.getElementById("m_name").value;
		var city= document.getElementById("city").value;
		var district= document.getElementById("district").value;
		var date= document.getElementById("date").value
		var time = document.getElementById("time").value;
		if(movieNm==""){
			alert("영화를 선택하세요");
			return;
		}
		if(city==""){
			alert("상영관을 선택하세요");
			return;
		}
		if(district==""){
			alert("상영관을 선택하세요");
			return;
		}
		if(date==""){
			alert("날짜를 선택하세요");
			return;
		}
		if(time==""){
			alert("시간을 선택하세요");
			return;
		}
		
		f.submit();
		
		
	}





