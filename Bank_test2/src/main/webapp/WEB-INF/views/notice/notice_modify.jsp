<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>notice_modify.jsp</title>
		
		<script>
			function send(f){
				f.action = "n_modify_fin.do";
				f.submit();
			}
		</script>
		
		<style>
			table {
				border-collapse: collapse; /* 테두리 겹치기 */
				width: 700px;
			}
		</style>
		
	</head>
	
	<body>
		<form>
			<input type="hidden" value="${ vo.r_notice_idx }" name="r_notice_idx">
			
			<table border="1" align="center">
			<caption>::: 공지사항 수정하기 :::</caption>
			
				<tr>
					<td style="width:150px">제목</td>
					<td><input name="subject" size="50" value="${ vo.subject }"></td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td><input name="name" value="${ vo.name }"></td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td><textarea name="content"
								  rows="25" cols="80"
								  style="resize: none;">${ vo.content }</textarea>
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="수정하기" onclick="send(this.form);">
						<input type="button" value="취소" onclick="history.go(-1);">
					</td>
				</tr>
		
			</table>
			
		</form>
	</body>
</html>