<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>qna_write.jsp</title>
		
		<script>
			function send(f){
				f.submit();
			}
			
			//여기 user_id 세션 설정해야 합니다!! ★중요
			//페이지 로딩시 실행되어 사용자 ID를 히든 필드에 설정하는 함수
			window.onload = function(){
				var userId = '<%= session.getAttribute("user_id") != null ? session.getAttribute("user_id") : "" %>';
				//세션에서 user_id 가져오기
				document.getElementById('user_id').value = userId;
				// 히든 필드에 user_id 설정
				 
			}
			
		</script>
		
		<style>
			table {
				border-collapse: collapse; /* 테두리 겹치기 */
				background-color: #fff; /* 원하는 배경색 지정 */
				box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1); /* 그림자 설정 */
				width: 700px; /* 테이블 너비 설정 */
				margin: 0 auto; /* 가운데 정렬 */
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
		
	</head>
	
	<body>
		<form name="f" method="post" action="q_insert.do">
		
		<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
		
		<!-- 작성자의 실명이 뜨게 함. '홍길동 님' 여기서 홍길동이 작성자로 자동으로 등록됨 -->
		<input type="hidden" id="user_id" name="user_id">
		
			<table border="1" width="700" align="center">
				<caption>:::질문하기:::</caption>
				
				<tr>
					<th class="color_same">제목</th>
					<td><input name="subject" size="50"></td>
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
					<td colspan="2" align="center">
						<input type="button" value="등록" onclick="send(this.form);">
						<input type="button" value="취소" onclick="history.go(-1);">
					</td>
				</tr>
				
			</table>
		</form>
	</body>
</html>