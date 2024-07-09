<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>qna_reply.jsp</title>
		
		<script>
			function send(f){
				//유효성 체크 했다고 침
				
				f.submit(); //정보 4개 가지고 insert.do에게 감.
				
			}
		</script>
		
	</head>
	
	<body>
		<form name="f" method="post" action="q_reply.do">
			
			<input type="hidden" name="q_board_idx" value="${ param.q_board_idx }">
			<input type="hidden" name="page" value="${ param.page }">
			
			<table border="1" width="700" align="center">
				<caption>:::Q&A 답변 작성:::</caption>
				
				<tr>
					<td>제목</td>
					<td><input name="subject" size="50"></td>
				</tr>
				
				<tr>
					<th>작성자</th>
					<td><input name="user_id" size="50"></td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td>
						<textarea rows="10" cols="80"
								  style="resize: none;"
								  name="content"></textarea>
					</td>
				</tr>
				
				<tr>
					<td>
						<input type="button" value="등록" onclick="send(this.form);">
						<input type="button" value="취소" onclick="history.go(-1);">
					</td>
				</tr>
				
			</table>
			
		</form>
	</body>
</html>