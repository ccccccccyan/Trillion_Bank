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
	margin-bottom: 20px;
	font-size: 24px;
	color: #fff;
}

.search input[type="text"] {
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
	 	let user_id = json[0].user_id;	
		
		if (json[0].result == 'clear') {
			 location.href = "change_pwd.do?user_id=" + user_id;
		} else {
			alert("존재하지 않는 아이디입니다.");
		}
	}
	}
</script>

</head>
<body>
<div class ="search">
	<h2>비밀번호 찾기</h2>
	<form name="f">
		<input type= "text" name="user_id" placeholder="ID를 입력하여주십시오"> <input
			type="button" value="ID 확인" onclick="send(this.form)">
	</form>
</div>
</body>
</html>