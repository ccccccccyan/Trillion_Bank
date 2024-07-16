<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>qna_reply.jsp</title>
		
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
			function send(f){
				//유효성 체크 했다고 침
				
				f.submit(); //정보 4개 가지고 insert.do에게 감.
				
			}
		</script>
		
	</head>
	
	<body>
		<form name="f" method="post" action="q_reply.do">
			
		<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
			
			<input type="hidden" name="q_board_idx" value="${ param.q_board_idx }">
			<input type="hidden" name="page" value="${ param.page }">
			
			<table border="1" width="700" align="center">
				<caption>Q&A 답변 작성</caption>
				
				<tr>
					<td class="color_same">제목</td>
					<td><input name="subject" size="50"></td>
				</tr>
				
				<tr>
					<td class="color_same">작성자</td>
					<td><input name="user_id" size="50" placeholder="관리자의 아이디를 적어주십시오."></td>
				</tr>
				
				<tr>
					<td class="color_same">내용</td>
					<td>
						<textarea rows="10" cols="80"
								  style="resize: none;"
								  name="content"></textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="right">
						<input type="button" value="등록" onclick="send(this.form);">
						<input type="button" value="취소" onclick="history.go(-1);">
					</td>
				</tr>
				
			</table>
			
		</form>
	</body>
</html>