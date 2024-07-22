<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>환율 게시글 수정</title>
		
		<script src="/bank/resources/js/httpRequest.js"></script>
		
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
			
			.color_same{
				background-color: #23212B; /*제목, 작성자, 내용 비번이 있는 행의 배경색 */
				color: #fff; /*제목, 작성자, 내용 비번의 글씨 색깔*/
			}
			
		</style>
		
		<script>
			function send(f){
				
				if(!f.subject.value || !f.content.value || !f.pwd.value) {
					alert("모든 필드를 입력해주세요.");
					return;
				}
				
				//상세보기에서 입력받은 비밀번호 c_pwd를 검색해서 value값 가지고 오면 됨.
				/* let c_pwd = document.getElementById("c_pwd").value; //지우려고 입력받은 비밀번호
				
				if( c_pwd != '${ vo.pwd }' ){ //지우려고 입력받은 비밀번호와 글을 추가할 떄 입력한 비밀번호가 같아?
					alert("비밀번호 불일치");
					return;
				} */
				
				let url = "rate_update.do";
				let param = "r_board_idx=" + f.r_board_idx.value +
							"&subject=" + f.subject.value +
							"&name=" + f.name.value +
							"&content=" + f.content.value +
							"&pwd=" + encodeURIComponent(f.pwd.value); // 비밀번호를 인코딩하여 전송
				
				sendRequest(url, param, resultFn, "post");
				
			}
			
			function resultFn(){
				if( xhr.readyState == 4 && xhr.status == 200 ){
					let data = xhr.responseText;
					let json = JSON.parse(data);
					
					if( json.result == 'fail' ){
						alert("수정 실패...");
					}else if(json.result == 'no'){
						alert("비밀번호 불일치");
					}else{
						alert("수정 성공입니다!");
						location.href="r_view.do?r_board_idx="+${ vo.r_board_idx };
					}
				}
			}
			
		</script>
		
	</head>
	
	<body>
		<form>
		
		<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
		
			<input type="hidden" name="r_board_idx" value="${ vo.r_board_idx }">
			<input type="hidden" name="name" value="${ vo.name }"><!-- 이게 왜 필요한지는 모르겠는데 gpt가 추천함. -->
			
			<table border="1" align="center">
				<caption>게시글 수정하기</caption>
				
				<tr>
					<th class="color_same">제목</th>
					<td><input name="subject" value="${vo.subject}"></td>
				</tr>
				
				<tr>
					<th class="color_same">내용</th>
					<td>
						<pre><textarea name="content" rows="5" cols="50" style="resize: none;">${ vo.content }</textarea></pre>
					</td>
				</tr>
				
				<tr>
					<th class="color_same">비밀번호</th>
					<td>
						<input type="password" name="pwd" style="width: 84%;" id="c_pwd"
							   placeholder="글을 작성할때 사용한 비밀번호를 입력해주십시오."
							   maxlength="4">
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