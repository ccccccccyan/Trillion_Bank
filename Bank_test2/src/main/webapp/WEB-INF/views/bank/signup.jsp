<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 폼</title>
<script src="/bank/resources/js/httpRequest.js"></script>
<script>
	function send(f) {
		let user_name = f.user_name.value;
		let user_id = f.user_id.value;
		let user_pwd = f.user_pwd.value;
		let user_pwd_check = f.user_pwd_check.value;
		let user_tel = f.user_tel.value;
		let user_addr = f.user_addr.value;
		/* let manager = manager = "N"; */

		if (user_pwd != user_pwd_check) {
			alert("비밀번호가 일치하지 않습니다.");
			return;
		}else if(user_pwd.length < 8 || user_pwd.length > 16){
			alert("8~16자의 비밀번호를 입력하여주십시오.")
		}
		
		if(user_id.length < 4 || user_pwd.length > 12){
			alert("4~12자의 아이디를 입력하여주십시오.")
		}

		let url = "signup_ins.do";
		let param = "user_name=" + user_name + "&user_id=" + user_id  
				+ "&user_pwd=" + encodeURIComponent(user_pwd) + "&user_tel="
				+ user_tel + "&user_addr=" + user_addr /* + "&manager=" + manager */;

		sendRequest(url, param, resultFn, "post"); 

		//return false; // 폼 제출 방지		

	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				let user_id = json[0].User_id; // 사용자 ID 가져오기
				let user_name = json[0].User_name; // 사용자 ID 가져오기
				let user_pwd = json[0].User_pwd; // 사용자 ID 가져오기
				let user_tel = json[0].User_tel; // 사용자 ID 가져오기
				let user_addr = json[0].User_addr; // 사용자 ID 가져오기
				/* let manager= json[0].manager; // 사용자 ID 가져오기 */
				location.href = "signup_final.do?user_id="
						+ user_id + "&user_name=" + user_name + "&user_pwd="
						+ encodeURIComponent(user_pwd) + "&user_tel="
						+ user_tel + "&user_addr=" + user_addr /* +"&manager=" + manager */;
			} else {
				alert("가입실패");
			}
		}
	}
	
	function check_id(f) {
		let user_id = f.user_id.value;
		
		let url = "signup_ins_id.do";
		let param = "user_id=" + user_id ;

		sendRequest(url, param, result_id, "post");
	}
	
	function result_id() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				alert("사용가능한 ID입니다.")				
			} else {
				alert("이미 존재하는 ID입니다.");
			}
		}
	}
	
	function check_tel(f) {
		let user_tel = f.user_tel.value;
		
		let url = "signup_ins_tel.do";
		let param = "user_tel=" + user_tel ;

		sendRequest(url, param, result_tel, "post");
	}
	
	function result_tel() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				alert("가입가능한 전화번호입니다.")				
			} else {
				alert("해당 전화번호는 회원가입이 완료된 번호입니다.");
			}
		}
	}
</script>
</head>
<body>
	<div class="login-container">
		<h2>회원 가입</h2>
		<form name="f">
			<div class="id">
				이름:<input name="user_name" required><br>
				ID:<input name="user_id" placeholder="영어 + 숫자의 4~12자리" required maxlength="12">
				   <input type="button" value="중복확인" onclick="check_id(this.form)"><br> 
				비밀번호:<input type="password" name="user_pwd" placeholder="영어 + 숫자의 8~16자리" maxlength="16" required ><br> 
				비밀번호 확인:<input type="password" name="user_pwd_check" placeholder="비밀번호 확인" maxlength="16" required><br>
				전화번호:<input name="user_tel" required>
					  <input type="button" value="중복확인" onclick="check_tel(this.form)"><br> 
				주소:<input name="user_addr" required><br>
			</div>
			<!-- <input type="hidden" name="manager"> -->
			 <input type="button" value="회원가입" onclick="send(this.form)">
		</form>
	</div>
</body>
</html>
