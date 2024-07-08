<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>notice_write.jsp</title>
		
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
		<form name="f" method="post" action="insert.do">
			<table border="1" width="700" align="center">
				<caption>::: 공지사항 새 글 작성 :::</caption>
				
				<tr>
					<th>제목</th>
					<td><input name="subject" size="50"></td>
				</tr>
				
				<tr>
					<th>작성자</th>
					<td><input name="name" size="50"></td>
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