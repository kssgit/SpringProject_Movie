//좌석페이지 관련 js

//선택한 좌석수
	var count=0;
	var total=0;//총인원수
	var a=0;//어른 카운트
	var t=0;//청소년 카운트
	var c=0;//어린이 카운트
	
	var a_m=10000;//어른 요금
	var t_m=7000;//청소년 요금
	var c_m=4000;//어린이 요금
	var m_total=0;//총합 요금
	//어른 카운트 메서드
	
	var ai="a0";
	function count1(i) {
		//인원 선택시 실행 되는 메서드
		
		i=i*1;
		var input1 =document.getElementById(ai);
		ai="a"+i;
		
		var input2 =document.getElementById(ai);
		
		input1.style.backgroundColor="white";
		input1.style.color="black";
		
		input2.style.background="gray";
		input2.style.color="white";
		
		if(i==0){
			total-=a;
			m_total-=a*a_m;
			a=0;
			m_total+=a*a_m;
			
			
		}else if(i==1){
			total-=a;
			m_total-=a*a_m;
			a=1;
			total+=a;
			m_total+=a*a_m;
		}else if(i==2){
			total-=a;
			m_total-=a*a_m;
			a=2;
			total+=a;
			m_total+=a*a_m;
		}else{
			a = i;
			total+=i;
			
		}
			if(count>total){
				alert("좌석수를 줄이세요");
			}
			//console.log(total);
			
			document.getElementById("to").innerHTML=total;
			document.getElementById("m_t").innerHTML=coma(m_total);
			document.getElementById("total_m").value=coma(m_total);
			document.getElementById("ad").innerHTML=a;
	}
	
	//청소년 카운트 메서드
	var ti="t0";
	function count2(i) {
		//인원 선택시 실행 되는 메서드
		i=i*1;
		var input1 =document.getElementById(ti);
		ti="t"+i;
		
		var input2 =document.getElementById(ti);
		
		input1.style.backgroundColor="white";
		input1.style.color="black";
		
		input2.style.background="gray";
		input2.style.color="white";
		if(i==0){
			total-=t;
			m_total-=t*t_m;
			t=0;
			m_total+=t*t_m;
		}else if(i==1){
			total-=t;
			m_total-=t*t_m;
			t=1;
			total+=t;
			m_total+=t*t_m;
		}else if(i==2){
			total-=t;
			m_total-=t*t_m;
			t=2;
			total+=t;
			m_total+=t*t_m;
		}else{
			t = i;
			total+=i;
		}
		if(count>total){
			alert("좌석수를 줄이세요");
		}
			//console.log(total);
			document.getElementById("to").innerHTML=total;
			document.getElementById("m_t").innerHTML=coma(m_total);
			document.getElementById("total_m").value=coma(m_total);
			document.getElementById("te").innerHTML=t;
	}
	
	//어린이 카운트 메서드
	var ci="c0";
	function count3(i) {
		//인원 선택시 실행 되는 메서드
		i=i*1;
		var input1 =document.getElementById(ci);
		ci="c"+i;
		
		var input2 =document.getElementById(ci);
		
		input1.style.backgroundColor="white";
		input1.style.color="black";
		
		input2.style.background="gray";
		input2.style.color="white";
		if(i==0){
			total-=c;
			m_total-=c*c_m;
			c=0;
			
		}else if(i==1){
			total-=c;
			m_total-=c*c_m;
			c=1;
			total+=c;
			m_total+=c*c_m;
		}else if(i==2){
			total-=c;
			m_total-=c*c_m;
			c=2;
			total+=c;
			m_total+=c*c_m;
		}else{
			c = i;
			total+=i;
		}
		if(count>total){
			alert("좌석수를 줄이세요");
		}
			//console.log(total);
			document.getElementById("to").innerHTML=total;
			document.getElementById("m_t").innerHTML=coma(m_total);
			
			document.getElementById("total_m").value=coma(m_total);
			document.getElementById("ch").innerHTML=c;
	}

	
	
	
	//좌석 선택시 실행되는 메서드
   function seat( id ) {
	var div =document.getElementById("set");
	var p = document.createElement("input");
      	p.innerHTML=id;
      	p.id=id+"s";
      	p.value=id;
      	p.name="seat";
      	p.style.border="none";
      	p.style.width="35px";
      	p.style.color="white";
      	p.style.backgroundColor="transparent";
		p.readOnly="false";
      var input = document.getElementById(id);
      //console.log(input.value);
      if(input.style.background=="red"){
    	var inp=document.getElementById(id+"s");
    	input.style.background="white";
    	count-=1;
    	document.getElementById("seat_count").value=count;
    	div.removeChild(inp);
      }else if(count<total){
    	count+=1;
      	input.style.background="red";
      	console.log(count);
      	document.getElementById("seat_count").value=count;
      	div.appendChild(p);
 
      }
		
   }

   //금액 콤마 함수
   function coma(x) {
	   return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
	
}

   function send(f) {
	if(count!=total){
		alert("좌석수를 잘 맞추세요");
		return;
	}
	if(total==0){
		alert("인원을 선택하세요");
		return;
	}
	if(total > 0 && count == 0){
		alert("좌석을 선택하세요");
		return;
	}
	f.submit();
	
}





