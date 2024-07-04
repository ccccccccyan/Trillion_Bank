<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>qna_view.jsp</title>
		
		<style>
			table {
				table-layout: fixed; /* 테이블 레이아웃을 고정 */
				border-collapse: collapse; /* 테두리 겹치기 */
			}
			td {
				border: 1px solid #000; /* 테두리 설정 */
				padding: 8px; /* 패딩 설정 */
			}
		
			td:first-child {
				width: 100px; /* 첫 번째 컬럼의 고정 너비 설정 */
			}
			
			/*view로 봤을 때 내용의 가로가 긴 경우에 칸이 늘어나거나 칸 바깥으로 빠져나오지 않도록 함.*/
			pre {
				white-space: pre-wrap; /* 공백과 줄바꿈을 유지하면서 줄바꿈 */
				word-wrap: break-word; /* 긴 단어 줄바꿈 */
				margin: 0; /* pre 태그의 기본 마진 제거 */
			}
		</style>
		
		<!-- Ajax사용을 위한 js파일 -->
		<script src="/qnab/resources/js/httpRequest.js"></script>
		
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
		
			<input type="hidden" name="q_board_idx" value="${vo.q_board_idx}">
			<!-- gpt가 추천한 코드 / 삭제 요청 시 r_board_idx가 누락되지 않고 정상적으로 전달 -->
			
			<table border="1" width="700" align="center">
				<caption>질문 게시판 상세보기</caption>
				
				<tr>
					<td>제목</td>
					<td>${ vo.subject }</td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td>${ vo.user_id }</td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td>${ vo.content }</td>
				</tr>
				
				<tr>
					<td colspan="2">
						<!-- 목록으로 -->
						<input type="button" value="목록으로"
							   onclick="location.href='q_list.do?page=${param.page}&search=${param.search}&$search_text=${param.search_text}'"> <!-- 'history.go(-1); 해도 ㄱㅊ' -->
						
						<c:if test="${ vo.depth lt 1 }">
							<!-- 답변 -->
							<img src="/qnab/resources/img/btn_reply.gif" onclick="reply();"
								   style="cursor: pointer;">
						</c:if>
						
						<!-- 삭제 -->
						<img src="/qnab/resources/img/btn_delete.gif" onclick="del();"
							   style="cursor: pointer;">
						
					</td>
				</tr>
				
			</table>
		</form>
	</body>
</html>