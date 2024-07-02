<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>qna_list.jsp</title>
		
		<style>
			body {
            	font-family: Arial, sans-serif;
            	background-color: #fff;
            	color: #333;
        	}
        	table {
            	width: 80%;
            	border-collapse: collapse;
            	margin: 20px auto;
            	border: 2px solid #555;
            	background-color: #f2f2f2; /* 테이블 배경색 */
        	}
        	th, td {
            	border: 1px solid #ddd;
            	padding: 10px;
            	text-align: center;
        	}
        	caption {
            	font-size: 1.5em;
            	margin: 10px;
        	}
       	 	select, input[type="text"], input[type="button"] {
            	padding: 8px;
           		font-size: 14px;
           		border-radius: 5px;
           		border: 1px solid #ccc;
        	}
        	input[type="button"] {
           		cursor: pointer;
           		background-color: #007bff;
           		color: #fff;
           		border: none;
         		padding: 10px 20px;
        	}
      	  	input[type="button"]:hover {
           		background-color: #0056b3;
        	}
		
		</style>
		
		<script>
			window.onload=function(){
				let search = document.getElementById("search");
				let search_array = ['all', 'subject', 'user_id', 'content', 'user_id_subject_content']; //배열에 카테고리를 넣음.
				
				for( let i = 0; i < search_array.length; i++ ){
					if( '${param.search}' == search_array[i] ){
						search[i].selected = true; //강제로 옵션 중에서 나랑 일치하는 친구 선택.
						
						let search_text = document.getElementById("search_text"); //검색어가 들어가있는 입력상자
						search_text.value = '${param.search_text}';
					}
				}
			}//window.onload=function()
		
			function searchFunction(){
				//조회 카테고리
				let search = document.getElementById("search").value;
				
				//검색어
				let search_text = document.getElementById("search_text").value;
				
				if( search != 'all' && search_text == '' ){ //카테고리는 선택되었는데 내용이 없으면
					alert("검색할 내용을 입력하세요");
					return;
				}
				
				location.href="list.do?search="+search+
							  "&search_text="+encodeURIComponent(search_text)+
							  "&page=1"; //3개의 파라미터를 list.do에게 전달함.
				
			}//search()
		</script>
		
	</head>
	
	<body>
		<table border="1" width="700" align="center">
			<caption>:::Q&A 게시판:::</caption>
			
			<tr>
				<td align="center">번호</td>
				<td align="center">제목</td>
				<td align="center">작성자</td>
			</tr>
			
			<c:forEach var="vo" items="${ list }">
				
				<tr>
					<td class="type_q_board_idx" align="center">${ vo.q_board_idx }</td><!-- qna 게시판 일련번호 -->
					<c:forEach begin="1" end="${ vo.depth }">&nbsp; <!-- 띄어쓰기 --></c:forEach>
					
					<td class="type_subject">
					<!-- 댓글 기호(ㄴ) 표시 (관리자가 답변시 ㄴ) -->
					<c:if test="${ vo.depth ne 0 }">ㄴ</c:if>
						<a href="view.do?q_board_idx=${ vo.q_board_idx }">${ vo.subject }</a>
					</td><!-- qna 게시판 제목(질문하는 제목) -->
					
					<td class="type_user_id">${ vo.user_id }</td><!-- 작성자(질문자) 아이디 -->
					
					
				</tr>
				
			</c:forEach>
			
			<tr>
				<td colspan="3" align="center">
					
					<select id="search">
						<option value="all">전체보기</option>
						<option value="subject">제목</option>
						<option value="user_id">작성자</option>
						<option value="content">내용</option>
						<option value="user_id_subject_content">이름+제목+내용</option>
					</select>
					
					<input id="search_text">
					<input type="button" value="검색" onclick="searchFunction();">
				</td>
			</tr>
			
			<tr>
				<td colspan="3" align="center">
					${ pageMenu }
				</td>
			</tr>
			
			<tr>
				<td colspan="3" align="right">
					<input type="button" value="등록"
					onclick="location.href='qna_write.do'">
				</td>
			</tr>
			
		</table>
	</body>
</html>