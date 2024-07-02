<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
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

.signup-container {
	background-color: #444;
	padding: 30px;
	border-radius: 10px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	width: 320px;
	text-align: center;
}

.signup-container h2 {
	margin-bottom: 20px;
	font-size: 24px;
	color: #fff;
}

.signup-container input[type="text"], .signup-container input[type="password"],
	.signup-container input[type="button"] {
	width: 100%;
	padding: 12px;
	margin: 10px 0;
	border: 1px solid #555;
	border-radius: 5px;
	background-color: #555;
	color: #fff;
	box-sizing: border-box;
}

.signup-container input[type="button"] {
	background-color: #007bff;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.signup-container input[type="button"]:hover {
	background-color: #0056b3;
}

.signup-container .inline-button {
	width: calc(50% - 10px);
	display: inline-block;
}

.signup-container .inline-button+.inline-button {
	margin-left: 20px;
}
</style>

<script>
	function send(f) {
		let user_id = f.user_id.value;
		let user_pwd = f.user_pwd.value;
		let user_pwd_check = f.user_pwd_check.value;
		let user_tel = f.user_tel.value;

		if (user_pwd != user_pwd_check) {
			alert("비밀번호가 일치하지 않습니다.");
			return;
		} else if (user_pwd.length < 8 || user_pwd.length > 16) {
			alert("8~16자의 비밀번호를 입력하여주십시오.");
			return;
		}


		let url = "modify_ins_user.do";
		let param = "user_id=" + user_id + "&user_pwd=" + encodeURIComponent(user_pwd) + "&user_tel=" + user_tel;

		sendRequest(url, param, resultFn, "post");
	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				alert("수정완료");
				location.href = "account_list.do?user_id=${vo.user_id}";
			} else {
				alert("수정실패");
			}
		}
	}

	
	function check_tel(f) {
		let user_tel = f.user_tel.value;
		let user_id = f.user_id.value;

		let url = "modify_ins_tel.do";
		let param = "user_tel=" + user_tel + "&user_id=" + user_id;

		sendRequest(url, param, result_tel, "post");
	}

	function result_tel() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				alert("사용 가능한 전화번호입니다.");
			} else {
				alert("다른 계정에서 사용 중인 번호입니다.");
			}
		}
	}
</script>
</head>
<body>
	<div class="signup-container">
		<h2>개인 정보 수정</h2>
		<form name="f">
			<div class="id">
				이름:<input type="text" name="user_name" value="${vo.user_name}" disabled="disabled"><br>
				ID:<input type="text" name="user_id" value="${vo.user_id}" disabled="disabled"> <br>
				비밀번호:<input type="password" name="user_pwd" 
					placeholder="영어 + 숫자의 8~16자리" maxlength="16" required><br>
				비밀번호 확인:<input type="password" name="user_pwd_check" 
					placeholder="비밀번호 확인" maxlength="16" required><br>
				전화번호:<input type="text" name="user_tel"  required> <input
					type="button" value="중복확인" class="inline-button"
					onclick="check_tel(this.form)"><br> 
			</div>
			<input type="button" value="회원가입" onclick="send(this.form)">
		
		</form>
	</div>
	</body>
</html>