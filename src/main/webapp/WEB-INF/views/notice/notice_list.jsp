<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>notice_list.jsp</title>
		
		<style>
			table {
				border-collapse: collapse; /* 테두리 겹치기 */
			}
			
			td {
				border: 1px solid #000; /* 테두리 설정 */
				padding: 8px; /* 패딩 설정 */
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
				
				location.href="list.do?search="+search+
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
				<caption>공지사항 게시판</caption>
				
					<tr>
						<td align="center" width="10%">번호</td>
						<td align="center" width="20%">작성자</td>
						<td align="center">제목</td>
					</tr>
					
				<c:forEach var="vo" items="${ list }">
					
					<tr>
						<td class="type_r_notice_idx" align="center">${ vo.r_notice_idx }</td><!-- 공지사항 일련번호 -->
						<td class="type_name">${ vo.name }</td><!-- 작성자 이름 -->
						<td class="type_subject">
							<a href="view.do?r_notice_idx=${ vo.r_notice_idx }">
							${ vo.subject }
							</a>
						</td><!-- 공지사항 제목 -->
					</tr>
					
				</c:forEach>
				
				<tr>
					<td colspan="3" align="center">
						${ pageMenu }
					</td>
				</tr>
				
				<tr>
				<td colspan="3" align="center">
					
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
				
				<tr>
					<td colspan="3" align="right">
						<input type="button" value="등록"
						onclick="location.href='notice_write.do'">
					</td>
				</tr>
				
			</table>
			
		</form>
	</body>
</html>

