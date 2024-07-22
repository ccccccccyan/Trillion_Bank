<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>환율 게시글 작성</title>
		
		<style>
			table {
				border-collapse: collapse; /* 테두리 겹치기 */
				background-color: #fff; /* 원하는 배경색 지정 */
				box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* 그림자 설정 */
			}
			
			td {
				border: 0px solid #000; /* 테두리 설정 */
				padding: 8px; /* 패딩 설정 */
			}
			
			body {
				background-color: #f4f4f4; /* 원하는 배경색 지정 */
			}
			
			/* 세로 줄 숨기기 */
			td:not(:last-child) {
				border-right: none; /* 마지막 열을 제외한 모든 td 요소의 우측 테두리 제거 */
			}
			
			/* 가로 줄만 보이게 설정 */
			tr:not(:first-child) td {
				border-top: 1px solid #000; /* 모든 행의 위쪽 테두리 추가 */
			}
			
			input[type="button"]{
				background-color: #23212B; /*배경색*/
				color: #fff; /* 글자색 */
				border: none; /* 테두리 없음 */
				padding: 5px 10px; /* 내부 여백 설정 */
				cursor: pointer; /* 마우스를 올리면 포인터 모양 */
				font-size: 13px; /* 글자 크기 */
				font-weight: bold; /* 글자 굵기 */
			}
			
			input[type="button"]:hover {
				background-color: rgb(140, 150, 151); /* 마우스를 올렸을 때 배경색 변경 */
			}
			
			caption{
				padding-top: 20px; /* 상단 여백 설정 */
				 margin-bottom: 25px; /* 아래 여백 설정 */
				 font-size: 1.5em; /* 적절한 폰트 크기 */
				 font-weight: bold; /* 굵은 글꼴 */
				 color: #23212B;
			}
			
			.color_same{
				background-color: #23212B; /*제목, 작성자, 내용 비번이 있는 행의 배경색 */
				color: #fff; /*제목, 작성자, 내용 비번의 글씨 색깔*/
			}
			
		</style>
		
		<script>
			
			let check_remittance = "no";
			
			function pwdSend(f){
				let rate_pwd = f.pwd.value;
				let rate_pwd_warn_msg = document.getElementById("rate_pwd_warn_msg");
				let onlynumberpwd = /^[0-9]{4}$/;
				let register_btn = document.getElementById("register_btn");
				
				// 비밀번호 유효성 체크
				if (!onlynumberpwd.test(rate_pwd)) {
					rate_pwd_warn_msg.innerHTML = "게시글 작성시 비밀번호는 숫자 4자리입니다.";
					rate_pwd_warn_msg.style.color = "red";
					register_btn.disabled = true;
					check_remittance = "no";
					return;
				}
				
				rate_pwd_warn_msg.innerHTML = "";
				register_btn.disabled = false;
				check_remittance = "yes";
				
			}
		
			function send(f){
				
				if(!f.subject.value || !f.name.value || !f.content.value || !f.pwd.value) {
					alert("모든 필드를 입력해주세요.");
					return;
				}
				
				pwdSend(f); //비밀번호 유효성 검사
				
				if(check_remittance == "yes"){
					f.submit();
				}else{
					alert("비밀번호를 확인하세요.");
				}
				
			}
			
		</script>
		
	</head>
	
	<body>
		<form name="f" method="post" action="r_insert.do">
		
		<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
		
			<table border="1" width="700" align="center">
				<caption>환율게시판 새 글 작성</caption>
				
				<tr>
					<th class="color_same">제목</th>
					<td><input name="subject" size="50"></td>
				</tr>
				
				<tr>
					<th class="color_same">작성자</th>
					<td><input name="name" size="50"></td>
				</tr>
				
				<tr>
					<th class="color_same">내용</th>
					<td>
						<textarea rows="10" cols="80" 
								  style="resize: none;"
								  name="content"></textarea>
					</td>
				</tr>
				
				<tr>
					<th class="color_same">비밀번호</th>
					<td>
						<input type="password" name="pwd" size="50"
							   oninput="pwdSend(this.form);" maxlength="4">
						<br>
						<span id="rate_pwd_warn_msg"></span>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="button" id="register_btn" value="등록" onclick="send(this.form);">
						<input type="button" value="취소" onclick="history.go(-1);">
					</td>
				</tr>
			</table>
		</form>
	</body>
</html>