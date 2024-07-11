<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>qna_view.jsp</title>
		
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
				word-break: break-word; /* 긴 영어를 줄바꿈하여 테이블 밖으로 벗어나지 않게 함. */
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
				overflow: scroll;
			}
			
			.color_same{
				background-color: #23212B; /*제목, 작성자, 내용 비번이 있는 행의 배경색 */
				color: #fff; /*제목, 작성자, 내용 비번의 글씨 색깔*/
			}
		
		</style>
		
		<!-- Ajax사용을 위한 js파일 -->
		<script src="/bank/resources/js/httpRequest.js"></script>
		
		<script>
		
			//Q 질문 게시글 삭제
			function del(){
				
				if( !confirm("질문을 삭제하시겠습니까?") ){
					return;
				}
				
				let url = "q_del.do";
				//let param = "q_board_idx=${vo.q_board_idx}";
				let param = "q_board_idx=" + document.querySelector("[name='q_board_idx']").value;
				//gpt가 추천한 코드
				
				sendRequest(url, param, resultFn, "post");
				
			}//del()
			
			function resultFn(){
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					//"[{'result':'yes'}]"
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if( json[0].result == 'yes' ){
						alert("삭제성공");
						location.href="q_list.do?page=${param.page}";
					}else{
						alert("삭제실패");
					}
					
				}
			}//resultFn()
			
			//답변 기능
			function reply(){
				location.href="q_reply_form.do?q_board_idx=${vo.q_board_idx}&page=${param.page}";
			}
			
		</script>
		
	</head>
	
	<body>
		<form name="f" method="post">
		
		<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
		
			<input type="hidden" name="q_board_idx" value="${vo.q_board_idx}">
			<!-- gpt가 추천한 코드 / 삭제 요청 시 r_board_idx가 누락되지 않고 정상적으로 전달 -->
			
			<table border="1" width="700" align="center">
				<caption>질문 게시판 상세보기</caption>
				
				<tr>
					<td class="color_same">제목</td>
					<td>${ vo.subject }</td>
				</tr>
				
				<tr>
					<td class="color_same">작성자</td>
					<td>${ vo.user_id }</td>
				</tr>
				
				<tr>
					<td class="color_same">내용</td>
					<td>${ vo.content }</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<!-- 목록으로 -->
						<input type="button" value="목록으로"
							   onclick="location.href='q_list.do?page=${param.page}&search=${param.search}&$search_text=${param.search_text}'"> <!-- 'history.go(-1); 해도 ㄱㅊ' -->
						
						<c:if test="${sessionScope.manager eq 'Y'}">
						
						<c:if test="${ vo.depth lt 1 }">
							<!-- 답변 -->
							<input type="button" value="답변" onclick="reply();">
						</c:if>
						
						<!-- 삭제 -->
						<input type="button" value="삭제" onclick="del();">
						</c:if>
						
					</td>
				</tr>
				
			</table>
		</form>
	</body>
</html>