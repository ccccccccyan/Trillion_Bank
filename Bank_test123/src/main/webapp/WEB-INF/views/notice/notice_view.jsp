<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>notice_view.jsp</title>
		
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
				color: #23212B; /* 글자색 설정 */
			}
			
			.color_same{
				background-color: #23212B; /*제목, 작성자, 내용 비번이 있는 행의 배경색 */
				color: #fff; /*제목, 작성자, 내용 비번의 글씨 색깔*/
				width: 80px; /* 각 셀의 너비 고정 */
			}
			
			pre {
	            white-space: pre-wrap; /* 줄 바꿈 처리 */
	            word-wrap: break-word; /* 긴 단어 처리 */
	            margin: 0;
	            overflow: visible;
        	}
        	
        	.content-font {
		        font-family: inherit; /* 부모 요소의 폰트를 상속받음 */
		        white-space: pre-wrap; /* 줄바꿈과 공백을 유지 */
		        word-wrap: break-word; /* 긴 단어 줄바꿈 */
		        margin: 0; /* pre 태그의 기본 마진 제거 */
		    }
		    
		</style>
		
		<script>
			
			function del(f) {
		        if (!confirm("공지를 삭제하시겠습니까?")) {
		            return;
		        }
		        
		        // 폼 액션을 직접 설정하는 대신 폼을 통해 submit하도록 변경
		        f.action = "n_del.do";
		        f.method = "post"; // 필요시
		        f.submit();
		    }
			
		</script>
		
	</head>
	
	<body>
		<form>
		
		<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
		
			<input type="hidden" name="r_notice_idx" value="${vo.r_notice_idx}">
			<!-- gpt가 추천한 코드 / 삭제 요청 시 r_notice_idx가 누락되지 않고 정상적으로 전달 -->
			
			<table border="1" width="700" align="center">
				<caption>공지사항 게시글 상세보기</caption>
				
				<tr>
					<td class="color_same">제목</td>
					<td>${ vo.subject }</td>
				</tr>
				
				<tr>
					<td class="color_same">작성자</td>
					<td>${ vo.name }</td>
				</tr>
				
				<tr>
					<td class="color_same">내용</td>
					<td><pre class="content-font">${ vo.content }</pre></td>
				</tr>
				
				
				<tr>
					<td colspan="2" align="right">
						<input type="button" value="목록으로" onclick="location.href='n_list.do?page=${param.page}&search=${param.search}&$search_text=${param.search_text}'">
						
						<!-- 주석 해제해주세요~ -->
						<c:if test="${sessionScope.manager eq 'Y'}">
						
						<input type="button" value="수정" onclick="location.href='n_board_modify.do?r_notice_idx=${ vo.r_notice_idx }'">
						<input type="button" value="삭제" onclick="del(this.form);">
						
						</c:if>
						
					</td>
				</tr>
				
			</table>
			
		</form>
	</body>
</html>