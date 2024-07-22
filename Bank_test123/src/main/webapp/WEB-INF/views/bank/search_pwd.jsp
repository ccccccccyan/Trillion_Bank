<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="/bank/resources/js/httpRequest.js"></script>


<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #333;
	color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.search {
	background-color: #444;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	width: 320px;

	text-align: center;
}

.search h2 {
	margin-top: 20px;
	margin-bottom: 30px;
	font-size: 34px;
	color: #fff;
}

.search input[type="text"]{
	width: 100%;
	padding: 14px;
	margin: 15px 0;
	border: 1px solid #555;
	border-radius: 5px;
	background-color: #555;
	color: #fff;
	box-sizing: border-box;
	text-align: center;
}

.search input[type="button"] {
	width: 100%;
	padding: 12px;
	margin: 15px 0;
	border: none;
	border-radius: 5px;
	background-color: #007bff;
	color: white;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.search input[type="button"]:hover {
	background-color: #0056b3;
}


.search input[type="text"]::placeholder{
    color: #ccc; /* 플레이스홀더의 글자색 설정 */
    opacity: 1; /* 투명도 설정 */
}

.logo {
	position: absolute;
	width: 400px;
	height: 65px;
	left: 37px;
	top: 37px;
	cursor: pointer;
}

.search input[type="text"].check{
	float :left;
	width: calc(100% - 70px);
}

.search input[type="button"].inline-button {
	margin-left:10px;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
	width: calc(30% - 40px);
}
</style>


<script>

	let sixnumber = 0;
	let isTelVerified = false; // 전화번호 인증 여부를 체크하는 변수
	let intervaled_user_self;
	function send(f) {
		 if (!isTelVerified) {
             alert("전화번호 인증을 완료해 주세요.");
             return;
         }
		
		let user_tel = f.user_tel.value;

		let url = "search_pwd2.do";
		let param = "user_tel=" + user_tel;

		sendRequest(url, param, resultFn, "post");
	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();
			let user_tel = json[0].user_tel;

			if (json[0].result == 'clear') {
				location.href = "change_pwd.do?user_tel=" + user_tel;
			} else {
				alert("가입되지 않은 전화번호입니다.");
			}
		}
	}

	document.addEventListener('DOMContentLoaded', function() {
		document.forms["f"].addEventListener('keydown', function(event) {
			if (event.key === 'Enter') {
				event.preventDefault();
				send(this);
			}
		});
	});
	
	function check_user_self(f) {
		param = "user_tel="+f.user_tel.value;
		url ="user_self_check.do";
	
		sendRequest(url, param, check_user_selfOK, "post");	
}	
	function check_user_selfOK() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
			
			//"[{'result':'yes'}]"
			let data = xhr.responseText;
			console.log(data);
			
			let json = ( new Function('return '+data) )();
			
			if( json[0].result == 'clear' ){
				sixnumber =json[0].sixNumber;
				console.log("sixnumber : "+sixnumber);
			}else{
				alert("진행 실패");
			}
			
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
				isTelVerified = true; // 인증 완료 상태로 설정
				
				clearInterval(intervaled_user_self);
				sixnumber = 0;
				
				isTelVerified = true; // 인증 완료 상태로 설정
	            document.querySelector('input[type="button"][value="비밀번호 변경"]').disabled = false;
	          
		}
	}
</script>

</head>
<body>
	<img src="/bank/resources/img/일조은행아이콘.png" class ="logo" onclick="location.href='login.do'">
	<div class="search">
		<h2>비밀번호 찾기</h2>
		<form name="f">
			<input type="text" name="user_tel" class="check" placeholder="전화번호 '-'을 제외한 11자리" maxlength="11" required>
			<input type="button" value="인증" id="tel_verify_btn" class="inline-button" onclick="check_user_self(this.form);"> <br> 
			<input type="text" name="user_number" id="check_user_number" class="check" placeholder="인증번호를 입력해주십시오." maxlength="6" required>
			<input type="button" value="확인" id="check_user_number_button" class="inline-button" onclick="check_user_sixnumber(this.form);"> <br> 
			<input type="button" value="비밀번호 변경" disabled="disabled" onclick="send(this.form)">
		</form>
	</div>
</body>
</html>