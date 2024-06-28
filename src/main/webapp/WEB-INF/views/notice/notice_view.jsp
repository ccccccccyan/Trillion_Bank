<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>notice_view.jsp</title>
		
		<script>
			
			function del(f) {
		        if (!confirm("공지를 삭제하시겠습니까?")) {
		            return;
		        }
		        
		        // 폼 액션을 직접 설정하는 대신 폼을 통해 submit하도록 변경
		        f.action = "del.do";
		        f.method = "post"; // 필요시
		        f.submit();
		    }
			
		</script>
		
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
			
			pre {
				white-space: pre-wrap; /* 공백과 줄바꿈을 유지하면서 줄바꿈 */
				word-wrap: break-word; /* 긴 단어 줄바꿈 */
				margin: 0; /* pre 태그의 기본 마진 제거 */
			}
		</style>
		
	</head>
	
	<body>
		<form>
		
			<input type="hidden" name="r_notice_idx" value="${vo.r_notice_idx}">
			<!-- gpt가 추천한 코드 / 삭제 요청 시 r_notice_idx가 누락되지 않고 정상적으로 전달 -->
			
			<table border="1" width="700" align="center">
				<caption>공지사항 게시글 상세보기</caption>
				
				<tr>
					<td>제목</td>
					<td>${ vo.subject }</td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td>${ vo.name }</td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td><pre>${ vo.content }</pre></td>
				</tr>
				
				
				<tr>
					<td colspan="2" align="right">
						<input type="button" value="목록으로" onclick="history.go(-1);">
							   
						<input type="button" value="수정" onclick="location.href='board_modify.do?r_notice_idx=${ vo.r_notice_idx }'">
               
						<input type="button" value="삭제" onclick="del(this.form);">
						
					</td>
				</tr>
				
			</table>
			
		</form>
	</body>
</html>