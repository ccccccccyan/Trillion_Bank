<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
<script src="/bank/resources/js/httpRequest.js"></script>
<link href='https://unpkg.com/boxicons@2.1.1/css/boxicons.min.css'
	rel='stylesheet'>
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

.login-container {
	background-color: #444;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	width: 320px;
	height: 400px;
	text-align: center;
	position: relative;
}

.login-container h2 {
	margin-top: 20px;
	margin-bottom: 40px;
	font-size: 34px;
	color: #fff;
}

.login-container .input-wrapper {
	position: relative;
	width: 100%;
}

.login-container .input-wrapper input[type="text"], .login-container .input-wrapper input[type="password"]
	{
	width: 100%;
	padding: 12px;
	padding-right: 40px; /* 아이콘 공간 확보 */
	margin: 10px 0;
	border: 1px solid #555;
	border-radius: 5px;
	background-color: #555;
	color: #fff;
	box-sizing: border-box;
}

.login-container .input-wrapper i {
	position: absolute;
	right: 10px;
	top: 50%;
	transform: translateY(-50%);
	color: #ccc; /* 아이콘 색상 변경 */
	font-size: 24px; /* 아이콘 크기 조정 */
	pointer-events: none; /* 아이콘 클릭 불가능하게 설정 */
}

.login-container input[type="button"] {
	width: 100%;
	padding: 12px;
	margin: 10px 0;
	border: none;
	border-radius: 5px;
	background-color: #007bff;
	color: white;
	font-size: 16px;
	cursor: pointer;
	transition: background-color 0.3s;
}

.login-container input[type="button"]:hover {
	background-color: #0056b3;
}

.login-container a {
	display: block;
	margin: 10px 0;
	color: #007bff;
	text-decoration: none;
}

.login-container a:hover {
	text-decoration: underline;
}

.login-container a.signup {
	margin-top: -18px; /* 기존 링크의 상단 여백 제거 */
	margin-right: 2px;
	float: right; /* 오른쪽으로 배치 */
}

.login-container label {
	display: block;
	text-align: left;
	color: #007bff;
}

.login-container input[type="checkbox"] {
	float: left;
	margin-top: 1.5px;
	margin-right: 5px; /* 체크박스 오른쪽 여백 조정 */
	transform: translateY(2px); /* 텍스트 정렬을 위한 조정 */
}

.login-container input[type="text"]::placeholder, .login-container input[type="password"]::placeholder
	{
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
</style>

<script>
	//쿠키 설정 함수
	function setCookie(name, value, days) {
		let expires = "";
		if (days) {
			let date = new Date();
			date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
			expires = "; expires=" + date.toUTCString();
		}
		document.cookie = name + "=" + (value || "") + expires + "; path=/";
	}

	// 쿠키 가져오기 함수
	function getCookie(name) {
		let nameEQ = name + "=";
		let ca = document.cookie.split(';');
		for (let i = 0; i < ca.length; i++) {
			let c = ca[i];
			while (c.charAt(0) == ' ')
				c = c.substring(1, c.length);
			if (c.indexOf(nameEQ) == 0)
				return c.substring(nameEQ.length, c.length);
		}
		return null;
	}

	function send(f) {
		let user_id = f.user_id.value;
		let user_pwd = f.user_pwd.value;
		let rememberMe = f.remember_me.checked;

		if (user_id == '' || user_pwd == '') {
			alert("올바른 정보를 입력해주십시오.")
		}

		// Remember Me 체크박스 상태에 따라 쿠키 설정
		if (rememberMe) {
			setCookie("user_id", user_id, 7); // 7일 동안 유효한 쿠키
			setCookie("user_pwd", user_pwd, 7); // 7일 동안 유효한 쿠키
		} else {
			setCookie("user_id", "", -1); // 쿠키 삭제
			setCookie("user_pwd", "", -1); // 쿠키 삭제
		}

		let url = "login_check.do";
		let param = "user_id=" + user_id + "&user_pwd="
				+ encodeURIComponent(user_pwd);
		sendRequest(url, param, resultFn, "post");
	}

	// 로그인 페이지 로드 시 쿠키 확인 함수
	window.onload = function() {
		let user_id = getCookie("user_id");
		let user_pwd = getCookie("user_pwd");
		if (user_id && user_pwd) {
			document.forms["f"].user_id.value = user_id;
			document.forms["f"].user_pwd.value = user_pwd;
			document.forms["f"].remember_me.checked = true;
		}
	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();
			let user_id = json[0].User_id;
			if (json[0].result == 'no') {
				alert("ID와 비밀번호를 다시 확인하여 주십시오.");
				return;
			} else if (json[0].result == 'freeze') {
				alert("이 계정은 현재 동결상태이므로 서비스 이용을 원하시면 가까운 지점이나 본사를 방문하여주십시오.")
				return;
			} else {
				location.href = "account_list.do?user_id=" + user_id;
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
</script>

</head>
<body>
	<img src="/bank/resources/img/일조은행아이콘.png" alt="Trillion Bank Logo" onclick="location.href='account_list.do'"
		class="logo">
	<div class="login-container">
		<h2>로그인</h2>
		<form name="f">
			<div class="input-wrapper">
				<i class='bx bxs-user'></i> <input type="text" name="user_id"
					maxlength="12" placeholder="ID">
			</div>
			<div class="input-wrapper">
				<i class='bx bxs-lock-alt'></i> <input type="password"
					name="user_pwd" placeholder="PASSWORD" maxlength="16">
			</div>
			<label> <input type="checkbox" name="remember_me">저장하기
			</label> <a href="signup.do" class="signup">회원 가입</a> <input type="button"
				value="LOG IN" onclick="send(this.form)" /> <a href="search_id.do">아이디 찾기
				</a> <a href="search_pwd.do">비밀번호 찾기</a>
		</form>
	</div>
</body>
</html>
