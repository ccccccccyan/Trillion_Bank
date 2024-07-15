<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>rate_list.jsp</title>
		
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
			
			.header_color_same{
				background-color: #23212B; /* 번호, 제목, 작성자가 있는 행의 배경색 */
				color: #fff; /*번호, 제목, 작성자의 글씨 색깔*/
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
			
		</style>
		
		<script>
		window.onload=function(){
			let search = document.getElementById("search");
			let search_array = ['all', 'subject', 'name', 'content', 'name_subject_content']; //배열에 카테고리를 넣음.
			
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
			
			location.href="r_list.do?search="+search+
						  "&search_text="+encodeURIComponent(search_text)+
						  "&page=1"; //3개의 파라미터를 list.do에게 전달함.
			
		}//search()
		</script>
		
	</head>
	
	<body>
		<form>
		
		<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
		
			<table border="1" width="700" align="center">
				<caption>환율 게시판</caption>
				
					<tr class="header_color_same">
						<td align="center" width="10%">번호</td>
						<td align="center" width="20%">작성자</td>
						<td align="center">제목</td>
						<td align="center">작성일</td>
					</tr>
					
				<c:forEach var="vo" items="${ list }">
					
					<tr>
						<td class="type_r_board_idx" align="center">${ vo.r_board_idx }</td><!-- 환율 게시판 일련번호 -->
						<td class="type_name" align="center">${ vo.name }</td><!-- 작성자 이름 -->
						<td class="type_subject" align="center">
							<a href="r_view.do?r_board_idx=${ vo.r_board_idx }">${ vo.subject }</a>
						</td><!-- 환율 게시판 제목 -->
						<td class="type_regdate" align="center">${ vo.regdate }</td>
					</tr>
					
				</c:forEach>
				
				<tr>
					<td colspan="4" align="center">${ pageMenu }</td>
				</tr>
				
				<tr>
				<td colspan="4" align="center">
					
					<select id="search">
						<option value="all">전체보기</option>
						<option value="subject">제목</option>
						<option value="name">작성자</option>
						<option value="content">내용</option>
						<option value="name_subject_content">이름+제목+내용</option>
					</select>
					
					<input id="search_text">
					<input type="button" value="검색" onclick="searchFunction();">
				</td>
			</tr>
				
			<c:if test="${ not empty user_id }">
				<tr>
					<td colspan="4" align="right">
						<input type="button" value="등록"
						onclick="location.href='rate_write.do'">
					</td>
				</tr>
			</c:if>
			
			</table>
			
		</form>
	</body>
</html>