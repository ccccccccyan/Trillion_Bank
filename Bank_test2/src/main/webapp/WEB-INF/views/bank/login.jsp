<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<script src="/bank/resources/js/httpRequest.js"></script>

<script>
	function send(f) {
		let user_id = f.user_id.value;
		let user_pwd = f.user_pwd.value;

		let url = "login_check.do";
		let param = "user_id=" + user_id + "&user_pwd="
				+ encodeURIComponent(user_pwd);
		sendRequest(url, param, resultFn, "post");
	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();
			let user_id = json[0].User_id;
			if (json[0].result == 'no') {
				alert("회원정보 불일치");
				return;
			} else {
				location.href = "main.do?user_id=" + user_id;
			}
		}

	}
</script>

</head>
<body>
	<div class="login-container">
		<h2>로그인</h2>
		<form name="f">
			<div class="id">
				id:<input name="user_id"><br> pwd :<input
					type="password" name="user_pwd"><br>
			</div>
			<input type="button" value="로그인" onclick="send(this.form)" /> <input
				type="button" value="회원가입" onclick="location.href='signup.do'" />
		</form>
	</div>
</body>
</html>