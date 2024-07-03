<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ID 찾기</title>
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

.search input[type="text"]::placeholder{
    color: #ccc; /* 플레이스홀더의 글자색 설정 */
    opacity: 1; /* 투명도 설정 */
}
</style>

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
				location.href = "login.do";
			} else {
				alert("해당 번호와 일치하는 ID가 존재하지 않습니다.");
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
	<div class="search">
		<h2>아이디 찾기</h2>
		<form name="f">
			<input type="text" name="user_tel" placeholder="전화번호를 입력하여주십시오">
			<input type="button" value="ID 찾기" onclick="send(this.form)">
		</form>
	</div>
</body>
</html>
