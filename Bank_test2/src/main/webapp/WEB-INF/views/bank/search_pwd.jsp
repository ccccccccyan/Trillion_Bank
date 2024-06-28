<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 찾기</title>
<script src="/bank/resources/js/httpRequest.js"></script>

<script>
	function send(f) {
		
	let user_id = f.user_id.value;
	
	let url = "search_pwd2.do";
	let param = "user_id=" + user_id;
	
	sendRequest(url, param, resultFn, "post"); 
	}
	
	function resultFn() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		let data = xhr.responseText;
		let json = (new Function('return ' + data))();
		
		if (json[0].result == 'clear') {
			 let user_id = json[0].user_id;	
			 location.href = "change_pwd.do?user_id=" + user_id;
		} else {
			alert("존재하지 않는 아이디입니다.");
		}
	}
	}
</script>

</head>
<body>
	<h2>비밀번호 찾기</h2>
	<form name="f">
		<input name="user_id" placeholder="ID를 입력하여주십시오"> <input
			type="button" value="ID 확인" onclick="send(this.form)">
	</form>
</body>
</html>