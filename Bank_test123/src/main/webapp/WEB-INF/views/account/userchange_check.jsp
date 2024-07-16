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
			let user_check_timer = 20;
		
			function check_user_self(f) {
				param = "user_tel="+f.user_tel.value;
				url ="user_self_check.do";
				
				sendRequest(url, param, check_user_selfOK, "post");
			}
			
			function check_user_selfOK(  ) {
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					//"[{'result':'yes'}]"
					let data = xhr.responseText;
					console.log(data);
					
					let json = ( new Function('return '+data) )();
					
					if( json[0].result == 'clear' ){
						setInterval("change_user_check_timer()", 1000);
					
					
					}else{
						alert("진행 실패");
					}
					
				}
			}
			
			function change_user_check_timer() {
				document.getElementById("user_check_timer_msg").style.color = "red";
				document.getElementById("user_check_timer_msg").innerHTML = user_check_timer;
				user_check_timer--;
			}
			
		</script>
		
	</head>
	<body>
		<div id="user_check_box"></div>
		
			<form id="user_check_form">
				<h3>사용자 정보 수정을 위해 본인인증이 필요합니다.</h3>
				<label for="check_user_name">성함 : </label>
				<input name="user_name" id="check_user_name" placeholder="계정에 등록되어 있는 성함을 입력하여 주십시오"> <br>
				<label for="check_user_tel">전화번호 : </label>
				<input name="user_tel" id="check_user_tel" placeholder="계정에 등록되어 있는 전화번호를 입력하여 주십시오">
				
				<input type="button" value="인증하기" onclick="check_user_self(this.form);">
				<br>
				
				<label for="check_user_number">인증번호 : </label>
				<input name="user_number" id="check_user_number" placeholder="발송받은 인증번호를 입력하여 주십시오">
				<input type="button" value="재전송" onclick="check_user_self(this.form);">
				<span id="user_check_timer_msg">인증번호 시간 안내</span>
				
				<br>
				<input type="button" value="취소" onclick="close_user_self(this.form);">
				
			</form>
	</body>
</html>