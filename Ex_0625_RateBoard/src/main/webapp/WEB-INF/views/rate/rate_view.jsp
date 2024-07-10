<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>rate_view.jsp</title>
	
		<style>
			body {
				background-color: #f4f4f4; /* 원하는 배경색 지정 */
			}
			
			table {
				border-collapse: collapse; /* 테두리 겹치기 */
				background-color: #fff; /* 원하는 배경색 지정 */
				box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* 그림자 설정 */
				table-layout: fixed; /* 테이블 레이아웃 고정 */
			}
			
			td {
				border: 1px solid #000; /* 테두리 설정 */
				padding: 8px; /* 패딩 설정 */
			}
			
			/* 첫 번째 td 너비 설정 */
			td:first-child {
				width: 100px;
			}
			
			/* 세로 줄 숨기기 */
			td:not(:last-child) {
				border-right: none; /* 마지막 열을 제외한 모든 td 요소의 우측 테두리 제거 */
			}
			
			/* 가로 줄만 보이게 설정 */
			tr:not(:first-child) td {
				border-top: 1px solid #000; /* 모든 행의 위쪽 테두리 추가 */
			}
			
			input[type="button"] {
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
			
			caption {
				padding-top: 20px; /* 상단 여백 설정 */
				margin-bottom: 25px; /* 아래 여백 설정 */
				font-size: 1.5em; /* 적절한 폰트 크기 */
				font-weight: bold; /* 굵은 글꼴 */
				color: #23212B;
			}
			
			/*view로 봤을 때 내용의 가로가 긴 경우에 칸이 늘어나거나 칸 바깥으로 빠져나오지 않도록 함.*/
			pre {
				white-space: pre-wrap; /* 공백과 줄바꿈을 유지하면서 줄바꿈 */
				word-wrap: break-word; /* 긴 단어 줄바꿈 */
				margin: 0; /* pre 태그의 기본 마진 제거 */
			}
			
			.color_same{
				background-color: #23212B; /*제목, 작성자, 내용 비번이 있는 행의 배경색 */
				color: #fff; /*제목, 작성자, 내용 비번의 글씨 색깔*/
			}
		
		</style>
	
		<script src="/rateBoard/resources/js/httpRequest.js"></script>
		
		<script>
		
			function del(form) {
				if(!confirm("이 게시글을 삭제하시겠습니까?")){
					return;
				}
				
				//상세보기에서 입력받은 비밀번호 c_pwd를 검색해서 value값 가지고 오면 됨.
				let c_pwd = form.c_pwd.value; //지우려고 입력받은 비밀번호
				let url = "del.do";
				let param = "r_board_idx=${vo.r_board_idx}" + "&pwd="
						+ encodeURIComponent(c_pwd);
				sendRequest(url, param, resultFn, "post");
			}
		
			function resultFn() {
				
				if (xhr.readyState == 4 && xhr.status == 200) {
					let data = xhr.responseText;
					let json = (new Function('return ' + data))();
		
					if (json[0].result == 'no') {
						alert("비밀번호 불일치");
					} else if (json[0].result == 'fail') {
						alert("삭제 실패");
						return;
					} else {
						alert("삭제 성공");
						location.href = "list.do"; //게시글 삭제 후 게시판 list로 이동
					}
				}
				
			}
		
			function modify(form) {
				
				let pwd = form.c_pwd.value;
				let url = "check_password.do";
				let param = "r_board_idx=${vo.r_board_idx}" + "&pwd="
						+ encodeURIComponent(pwd);
				
				sendRequest(url, param, checkPwdFn, "post");
				
			}
		
			function checkPwdFn() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					let data = xhr.responseText;
					console.log(data);
					let json = (new Function('return ' + data))();
		
					if (json[0].result == 'clear') {
						location.href = "board_modify.do?r_board_idx=${vo.r_board_idx}";
					} else {
						alert("비밀번호가 일치하지 않음");
					}
				}
			}
		
			//=====================================
			
			//현재 보고 있는 댓글의 페이지 번호를 저장할 변수
			let comm_page = 1;
		
			//페이지가 실행되면 존재하는 comment를 보여준다.
			window.onload = function() {
				comment_list(1);
			}
		
			//댓글 삭제를 위한 메서드
			function del_comment(form) {
				let c_pwd = form.c_pwd.value; //댓글을 쓸때 입력받은 비밀번호
				let comm_pwd = form.comm_pwd.value; //원본 비밀번호
				let c_board_idx = form.c_board_idx.value; //삭제할 댓글 번호
		
				if (c_pwd == '') {
					alert("비밀번호는 필수입니다.");
					return;
				}
		
				if (c_pwd != comm_pwd) {
					alert("비밀번호 불일치!");
					return;
				}
		
				if (!confirm("정말로 이 댓글을 삭제하실 건가요?")) {
					return;
				}
		
				//삭제를 위해 Ajax 요청
				let url = "comment_del.do";
				let param = "c_board_idx=" + c_board_idx;
				sendRequest(url, param, comm_delFn, "post"); //잘지웠으면 yes, 아니면 no
			}
		
			function comm_delFn() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					let data = xhr.responseText;
					let json = (new Function('return ' + data))();
		
					if (json[0].result == 'yes') {
						alert("댓글 삭제 성공");
						location.reload(); //댓글 삭제 후 페이지 새로고침
						//comment_list(comm_page);
					} else {
						alert("댓글 삭제 실패...");
					}
				}
			}
		
			function send(form) {
				if (!form.name.value || !form.content.value || !form.comm_pwd.value) {
					alert("모든 필드를 입력해주세요.");
					return;
				}
		
				let url = "comment_insert.do";
				let param = "r_board_idx=${vo.r_board_idx}&name=" + form.name.value
						+ "&content=" + form.content.value + "&comm_pwd="
						+ form.comm_pwd.value; //Ajax로 요청
				sendRequest(url, param, commFn, "post");
						
				//form 태그에 포함되어 있는 모든 입력 상자의 값을 초기화
				//댓글 작성한 뒤에 글이 남아있지 않도록 해주는 장치
				form.reset();
			}
		
			function commFn() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					let data = xhr.responseText;
					let json = (new Function('return ' + data))();
		
					if (json[0].result == 'yes') {
						comment_list(comm_page);
					} else {
						alert("등록 실패...");
					}
				}
			}
		
			/*코멘트 작성 완료 후, 해당 게시글에 대한 코멘트만 추려내서 가져온 결과*/
			function comm_list_fn() {
				if (xhr.readyState == 4 && xhr.status == 200) {
					let data = xhr.responseText;
					document.getElementById("comment_disp").innerHTML = data;
				}
			}
		
			function comment_list(comm_page) {
				let r_board_idx = ${vo.r_board_idx};
				
				let url = "comment_list.do";
				let param = "r_board_idx=${vo.r_board_idx}&page=" + comm_page;
				sendRequest(url, param, comm_list_fn, "post");
			}
		</script>
	
		
	
	</head>
	
	<body>
		<form>
			<input type="hidden" name="r_board_idx" value="${vo.r_board_idx}">
			
			<table border="1" width="700" align="center">
			
				<caption>환율게시판 게시글 상세보기</caption>
				
				<tr>
					<td class="color_same">제목</td>
					<td>${vo.subject}</td>
				</tr>
				
				<tr>
					<td class="color_same">작성자</td>
					<td>${vo.name}</td>
				</tr>
				
				<tr>
					<td class="color_same">내용</td>
					<td><pre>${vo.content}</pre></td>
				</tr>
				
				<!-- 비밀번호 확인용입니다! (나중에 지울 것!) -->
				<tr>
					<td class="color_same">비밀번호</td>
					<td>${vo.pwd}</td>
				</tr>
				<!-- 비밀번호 확인용입니다! (나중에 지울 것!) -->
				
				<tr>
					<td class="color_same">비번 입력</td>
					<td><input type="password" name="c_pwd" maxlength="4"></td>
				</tr>
				
				<tr>
					<td colspan="2" align="right"><input type="button" value="목록으로"
						onclick="history.go(-1);"> <input type="button" value="수정"
						onclick="modify(this.form);"> <input type="button"
						value="삭제" onclick="del(this.form);"></td>
				</tr>
				
			</table>
			
		</form>
		
		<hr width="700" align="center">
		
		<div>
			<form>
				<table border="1" align="center" width="700">
					<tr>
						<th class="color_same">작성자</th>
						<td><input name="name"></td>
					</tr>
					<tr>
						<th class="color_same">댓글을 달 내용</th>
						<td><textarea name="content" rows="5" cols="44"
								style="resize: none;"></textarea></td>
					</tr>
					<tr>
						<th class="color_same">비밀번호</th>
						<td><input type="password" name="comm_pwd"> <input
							type="button" value="등록" onclick="send(this.form);"></td>
					</tr>
				</table>
			</form>
			
		</div>
		
		<div id="comment_disp" style="width: 700px; margin: 0 auto;"></div>
		
	</body>
</html>
