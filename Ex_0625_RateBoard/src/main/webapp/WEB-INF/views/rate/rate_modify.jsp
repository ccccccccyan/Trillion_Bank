<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>rate_modify.jsp</title>
		
		<script src="/rateBoard/resources/js/httpRequest.js"></script>
		
		<script>
			function send(f){
				
				if(!f.subject.value || !f.content.value || !f.pwd.value) {
					alert("모든 필드를 입력해주세요.");
					return;
				}
				
				let url = "rate_update.do";
				let param = "r_board_idx=" + f.r_board_idx.value +
							"&subject=" + f.subject.value +
							"&name=" + f.name.value +
							"&content=" + f.content.value +
							"&pwd=" + f.pwd.value;
				
				sendRequest(url, param, resultFn, "post");
				
			}
			
			function resultFn(){
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					let data = xhr.responseText;
					//let json = (new Function('return '+data))();
					
					if( data == 'fail' ){
						alert("수정 실패");
						return;
					}else{
						alert("수정 성공입니다아아ㅏ아아아아ㅏㅏ");
						location.href="list.do";
					}
				}
			}
			
		</script>
		
	</head>
	
	<body>
		<form>
			<input type="hidden" name="r_board_idx" value="${ vo.r_board_idx }">
			<input type="hidden" name="name" value="${ vo.name }"><!-- 이게 왜 필요한지는 모르겠는데 gpt가 추천함. -->
			
			<table border="1" align="center">
				<caption>:::게시글 수정하기:::</caption>
				
				<tr>
					<th>제목</th>
					<td><input name="subject" value="${vo.subject}"></td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<pre><textarea name="content" rows="5" cols="50" style="resize: none;">${ vo.content }</textarea></pre>
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td>
						<input type="password" name="pwd">
					</td>
				</tr>
				
				<tr>
					<td colspan="2" align="center">
						<input type="button" value="수정하기"
							   onclick="send(this.form);">
						
						<input type="button" value="목록보기"
							   onclick="history.go(-1);">
					</td>
				</tr>
				
			</table>
			
		</form>
	</body>
</html>