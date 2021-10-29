var xhr = null;

function createRequest(){
		
//JavaScript를 이용하여 서버로 정보를 보내는 HTTP request를 만들기 위해서는 이런 기능을 제공하는 클래스 인스턴스가 필요하다. 

//이런 클래스는 InternetExplorer에서는 XMLHTTP라고 불리는 ActivX object를 말한다. 

//그러면 Mozzlia, Safari나 다른 브라우저에서도 Microsoft의 ActiveX 객체의 method와 property를 지원하기 위해 XMLHttpRequest클래스를 구현 하고 있다.

	if(xhr!=null)return;
	if(window.ActiveXObject)
		xhr = new ActiveXObject("Microsoft.XMLHTTP");
	else
		xhr = new XMLHttpRequest();
}


function sendRequest(url, param, callBack, method){
	createRequest();//HTTP request생성

	//전송타입 구분
	var httpMethod = 
	(method!='POST' && method!='post')?'GET':'POST';
	
	//파라미터 구분
	var httpParam = 
	(param==null || param == '')?null:param;
	
	//접근 url
	var httpURL = url;
	
	//요청 방식이 get방식이고, 전달할 파라미터 값이 있다면
	//url경로를 제작 해야 한다.(.../test.jsp?ch=123)
	if(httpMethod == 'GET' && httpParam != null)
		httpURL = httpURL+"?"+httpParam;
	
        //xhr.open( 요청방식, 접근url, 비동기(true면 비동기) ); 
	xhr.open(httpMethod, httpURL, true);

	//만약 "POST" type을 보내려 한다면, 요청(request)에 MINE type을 설정 해야 한다. 예를 들자면 send()를 호출 하기 전에 아래와 같은 형태로 send()로 보낼 쿼리를 이용해야 한다.
	xhr.setRequestHeader("Content-Type",
	  "application/x-www-form-urlencoded");

	//작업이 완료된 후 호출될 콜백메서드 지정
	xhr.onreadystatechange = callBack;
	
	xhr.send(httpMethod == 'POST'?httpParam:null);
}













