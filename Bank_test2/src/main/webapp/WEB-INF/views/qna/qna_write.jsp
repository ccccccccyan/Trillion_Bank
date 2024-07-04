<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>qna_write.jsp</title>
		
		<script>
			function send(f){
				f.submit();
			}
		</script>
		
		<style>
			table {
				border-collapse: collapse; /* 테두리 겹치기 */
			}
		</style>
		
	</head>
	
	<body>
		<form name="f" method="post" action="q_insert.do">
			<table border="1" width="700" align="center">
				<caption>:::질문하기:::</caption>
				
				<tr>
					<td>제목</td>
					<td><input name="subject" size="50"></td>
				</tr>
				
				<tr>
					<th>작성자</th>
					<td><input name="user_id" size="50"></td>
				</tr>
				
				<tr>
					<th>내용</th>
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