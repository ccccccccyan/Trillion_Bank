<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>개인 정보 수정</title>
		
		<style type="text/css">
			#user_check_box{width: 100%;
							height: 100%;
							background: #a6a6a2;
							opacity: 0.6;
							position: absolute;
							z-index: 900;
							top: -120px;
							}
			#user_check_form{width: 500px;
							height: 300px;
							background-color: #fff;
		    	        	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    	        	padding: 20px;
							opacity: 1;
							position: absolute;
							z-index: 950;
							border-radius: 30px;
							left: 600px;
							top: 200px;
							}				
			#check_user_name{width: 350px;
							height: 20px;
							margin: 10px;
							font-size: 16px;}	
														
			#check_user_tel{width: 350px;
							height: 20px;
							margin: 10px;
							font-size: 16px;}
							
			#check_user_number{width: 350px;
							height: 20px;
							margin: 10px;
							font-size: 16px;}												
		</style>
		
		<script>
			let user_check_timer_min = 2;
			let user_check_timer_sec = 30;
		
			function check_user_self(f) {
				let search_user_id = document.getElementById("search_user_id").innerHTML; 
				console.log("search_user_id : " + search_user_id);
				param = "user_tel="+f.user_tel.value + "&search_user_id="+search_user_id;
				url ="user_tel_check.do";
				
				sendRequest(url, param, function() {
					check_user_tel_ok( f );
		           }, "post");
			}
			
			function check_user_tel_ok(f) {
				if( xhr.readyState == 4 && xhr.status == 200 ){
				let data = xhr.responseText;
				console.log(data);
				

				let json = ( new Function('return '+data) )();
				
				if( json[0].result == 'clear' ){
					
					param = "user_tel="+f.user_tel.value;
					url ="user_self_check.do";
				
					sendRequest(url, param, check_user_selfOK, "post");
				}else{
					alert("전화번호 불일치");
				}
				}
			}	
			let sixnumber = 0;
			let intervaled_user_self;
			function check_user_selfOK() {
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					//"[{'result':'yes'}]"
					let data = xhr.responseText;
					console.log(data);
					
					let json = ( new Function('return '+data) )();
					
					if( json[0].result == 'clear' ){
						
						sixnumber =json[0].sixNumber;
						console.log("sixnumber : "+sixnumber);
						intervaled_user_self = setInterval(function() {
							// 보여지는 그래프 데이터가 마지막 index 데이터가 될 경우 index을 0으로 만들어서 무한으로 돌도록 한다.
							change_user_check_timer();
						}, 1000);
					}else{
						alert("진행 실패");
					}
					
				}
			}
			
			function change_user_check_timer() {
					
				user_check_timer_sec--;
				
				document.getElementById("user_check_timer_msg").style.color = "red";
				document.getElementById("user_check_timer_msg").innerHTML = user_check_timer_min + " : " + user_check_timer_sec;
				if(user_check_timer_sec == 0){
					user_check_timer_min--;
					if(user_check_timer_min < 0){
						document.getElementById("user_check_timer_msg").style.color = "red";
						document.getElementById("user_check_timer_msg").innerHTML = "인증번호의 유효기간이 지났습니다.";
						clearInterval(intervaled_user_self);
						sixnumber = 0;
						user_check_timer_min = 2;
						user_check_timer_sec = 30;
						return;
					}
					user_check_timer_sec = 59;
				}
			}
			
			function check_user_sixnumber(f) {
				if(sixnumber == 0){
					alert("인증번호를 발송해주십시오");
					return;
				}else if(f.user_number.value != sixnumber){
					alert("인증번호를 불일치");
					return;

				}else if(f.user_number.value == sixnumber){
						alert("인증완료.");
						document.getElementById("user_self_check_box").style.display = "none";
						document.getElementById("user_check_background").style.display = "none";
						
						document.getElementById("user_check_timer_msg").innerHTML = "";
						clearInterval(intervaled_user_self);
						sixnumber = 0;
						
						user_check_timer_min = 2;
						user_check_timer_sec = 30;
						
						f.reset();
				}
			}
			
			function check_user_number_length(f) {
				if(f.user_number.value.length == 6){
					f.check_user_number_button.disabled = false;
				}else{
					f.check_user_number_button.disabled = true;
				}
			}
			
			function again_user_tel(f) {
				document.getElementById("user_check_timer_msg").innerHTML = "";
				clearInterval(intervaled_user_self);
				sixnumber = 0;
				user_check_timer_min = 2;
				user_check_timer_sec = 30;
				f.check_user_number_button.disabled = true;
			}
		</script>
		
	</head>
	<body>
		<div id="user_check_box"></div>
		
			<form id="user_check_form">
				<h3>본인인증 진행중...</h3>
				<label for="check_user_tel">전화번호 : </label> <br>
				<input name="user_tel" id="check_user_tel" oninput="again_user_tel(this.form);"> <br>
				<span>계정에 등록되어 있는 전화번호를 입력하여 주십시오</span> <br>
				<input type="button" value="인증하기" onclick="check_user_self(this.form);">
				<br>
				
				<label for="check_user_number">인증번호 : </label> <br>
				<input name="user_number" id="check_user_number" oninput="check_user_number_length(this.form);" placeholder="숫자 6자리"> <br>
				<span>발송받은 인증번호를 입력하여 주십시오</span> <br>
				<input type="button" value="재전송" onclick="check_user_self(this.form);">
				<input type="button" id="check_user_number_button" value="인증번호 확인" disabled="disabled" onclick="check_user_sixnumber(this.form);">
				<span id="user_check_timer_msg">인증번호 시간 안내</span>
				
				<br>
				<input type="button" value="취소" onclick="close_user_self(this.form);">
				
			</form>
	</body>
</html>