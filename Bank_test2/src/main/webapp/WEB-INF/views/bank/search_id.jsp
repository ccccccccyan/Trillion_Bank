<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 찾기</title>
<script src="/bank/resources/js/httpRequest.js"></script>

<script>
	function send(f) {
		
	let user_tel = f.user_tel.value;
	
	let url = "search_id2.do";
	let param = "user_tel=" + user_tel;
	
	sendRequest(url, param, resultFn, "post"); 
	}
	
	function resultFn() {
	if (xhr.readyState == 4 && xhr.status == 200) {
		let data = xhr.responseText;
		let json = (new Function('return ' + data))();
	
		if (json[0].result == 'clear') {
			let user_id = json[0].User_id; // 사용자 ID 가져오기
			alert("ID : " + user_id);
		} else {
			alert("해당 번호와 일치하는 ID가 존재하지 않습니다.");
		}
	}
	}
</script>

</head>
<body>
	<h2>아이디 찾기</h2>
	<form name="f">
		<input name="user_tel" placeholder="전화번호를 입력하여주십시오"> <input
			type="button" value="ID 찾기" onclick="send(this.form)">
	</form>
</body>
</html>