var date = new Date();

function loadDate(){
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var day=date.getDate();
	if((month+"").length < 2){
		month = "0" + month;
	}
	if((day+"").length < 2){
		day = "0" + day;
	}
	var getDate = year + month + day;
	return eval(getDate);
}

//3일 전 날짜 불러오기
function releaseDtStart(){
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var day=date.getDate();
	if(day < 4){
		day = day+25;
		if(month == 1){
			month = 12;
		} else{
			month = month-1;
		}
	} else{
		day = day - 3;
	}
	if((month+"").length < 2){
		month = "0" + month;
	}
	if((day+"").length < 2){
		day = "0" + day;
	}
	var getDate = year + month + day;
	return eval(getDate);
}
//한달 후 날짜 불러오기
function releaseDtEnd(){
	var year=date.getFullYear();
	var month=date.getMonth()+1;
	var day=date.getDate();
	if(month == 12){
		month = 1
	} else {
		month = month + 1;
	}
	if((month+"").length < 2){
		month = "0" + month;
	}
	if((day+"").length < 2){
		day = "0" + day;
	}
	var getDate = year + month + day;
	return eval(getDate);
}

function noFormDates( date ){
	var noFormY = date.substring(0,4);
	var noFormM = date.substring(5,7);
	var noFormD = date.substring(8,10);
	var noFormDate = noFormY+noFormM+noFormD;

	return eval(noFormDate);
}