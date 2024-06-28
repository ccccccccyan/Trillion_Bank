<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
	<h2>비밀번호 변경</h2>
	<form name="f">	
		 <input type="hidden" name="user_id" value="${user_id}">
		<input type = "password" name="user_pwd" placeholder="변경할 비밀번호를 입력하여주십시오"><br>
		<input type = "password" name="user_pwd_check" placeholder="비밀번호 확인"><br>
		<input type="button" value="비밀번호 변경" onclick="send(this.form)">
	</form>
</body>
</html>