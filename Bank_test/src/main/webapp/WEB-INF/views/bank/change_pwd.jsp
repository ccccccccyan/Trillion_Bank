<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">


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
	margin-bottom: 20px;
	font-size: 24px;
	color: #fff;
}

.search input[type="text"],
.search input[type="password"] {
	width: 250px;
	padding: 12px;
	margin: 10px;
	border: 1px solid #555;
	border-radius: 5px;
	background-color: #555;
	color: #fff;
	box-sizing: border-box;
	text-align: center;
}

.search input[type="button"] {
	padding: 12px;
	margin: 10px;
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
</style>

<title>비밀번호 변경</title>
	<script>
		function send(f) {
			let user_id = f.user_id.value;
			let user_pwd = f.user_pwd.value;
			let user_pwd_check = f.user_pwd_check.value;
			
			if (user_pwd != user_pwd_check) {
				alert("비밀번호가 일치하지 않습니다.");
				alert(user_id);
				return;
			}else {
				location.href = "change_pwd_final.do?user_id=" + user_id + "&user_pwd=" + user_pwd;
			}
			
			
		}
	</script>

</head>
<body>
<div class="search">
	<h2>비밀번호 변경</h2>
	<form name="f">	
		 <input type="hidden" name="user_id" value="${user_id}">
		<input type = "password" name="user_pwd" placeholder="변경할 비밀번호를 입력하여주십시오"><br>
		<input type = "password" name="user_pwd_check" placeholder="비밀번호 확인"><br>
		<input type="button" value="비밀번호 변경" onclick="send(this.form)">
	</form>
	</div>
</body>
</html>