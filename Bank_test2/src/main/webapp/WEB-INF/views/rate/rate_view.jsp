<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>rate_view.jsp</title>
		
		<script src="/rateBoard/resources/js/httpRequest.js"></script>
		
		<script>
			
			//현재 게시글 삭제
			function del(f) {
		        if (!confirm("글을 삭제하시겠습니까?")) {
		            return;
		        }
		        
		      //상세보기에서 입력받은 비밀번호 c_pwd를 검색해서 value값 가지고 오면 됨.
				let c_pwd = document.getElementById("c_pwd").value; //지우려고 입력받은 비밀번호
				
				if( c_pwd != '${ vo.pwd }' ){ //지우려고 입력받은 비밀번호와 글을 추가할 떄 입력한 비밀번호가 같아?
					alert("비밀번호 불일치");
					return;
				}
				
				let url = "r_del.do";
				let param = "r_board_idx=${vo.r_board_idx}";
				sendRequest(url, param, resultFn, "post"); //resultFn 콜백 메서드
		        
//				위는 board에서 가져온 것, 아래는 원래 있던 것.
		        // 폼 액션을 직접 설정하는 대신 폼을 통해 submit하도록 변경
//		        f.action = "del.do";
//		        f.method = "post"; // 필요시
//		        f.submit();
		    }
			
			function resultFn(){
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					console.log("dkdkdkdkk");
					
					//"[{'result':'yes'}]"
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if( json[0].result == 'yes' ){
						alert("삭제성공");
						location.href="list.do?page=${param.page}";
					}else{
						alert("삭제실패");
					}
				}
			}//resultFn()
			
			
			//현재 글 수정
			function modify(){
				
				//비밀번호가 일치하면 넘어가도록 함. (비밀번호 틀리면 못넘어가게 함.)
				let c_pwd = document.getElementById("c_pwd").value;
				
				if( c_pwd != '${vo.pwd}' ){
					alert("비밀번호가 다름");
					return;
				}
				
				location.href="r_board_modify.do?r_board_idx=${vo.r_board_idx}";
			}
			
			//-------------------------
			
			//현재 보고 있는 댓글의 페이지 번호를 저장할 변수
			let comm_page = 1;
		
			//페이지가 실행되면 존재하는 comment를 보여준다.
			window.onload = function(){
				comment_list(1);
			}//window.onload = function()
			
			//댓글 삭제를 위한 메서드
			function del_comment(f){
				//alert(f.c_board_idx.value);
				let c_pwd = f.c_pwd.value; //댓글을 쓸때 입력받은 비밀번호
				let comm_pwd = f.comm_pwd.value; //원본 비밀번호
				let c_board_idx = f.c_board_idx.value; //삭제할 댓글 번호
				if( c_pwd == '' ){
					alert("비밀번호는 필수입니다.");
					return;
				}
				
				if( c_pwd != comm_pwd ){
					alert("비밀번호 불일치!");
					return;
				}
				
				if( !confirm("정말로 이 댓글을 삭제할거심?") ){
					return;
				}
				
				//삭제를 위해 Ajax요청
				let url = "r_comment_del.do";
				let param = "c_board_idx=" + c_board_idx;
				sendRequest(url, param, comm_delFn, "post"); //잘지웠으면 yes, 아니면 no
				
			}//del_comment(f)
			
			function comm_delFn(){ //이 위에서 여기로 옴.
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					let data = xhr.responseText;
					let json = ( new Function ('return '+data) )();
					
					if( json[0].result == 'yes' ){
						comment_list(comm_page); //여기를 다시 호출하면 됨.
					}else{
						alert("삭제 실패했심");
					}
					
				}
			}//comm_delFn()
			
			
			
			//==============================
			/* comment 등록 메서드 */
			function send(f){
				//유효성체크 했다고 침
				
				let url = "r_comment_insert.do";
				let param = "r_board_idx=${vo.r_board_idx}&name="+f.name.value+
							 "&content="+f.content.value+
							 "&comm_pwd="+f.comm_pwd.value; //이렇게 ajax로 요청
				
				sendRequest(url, param, commFn, "post");
							 
				//form태그에 포함되어 있는 모든 입력상자의 값을 초기화
				//댓글 작성한 뒤에 글이 남아있지 않도록 해주는 장치
				f.reset();
				
			}//send(f)
			
			function commFn(){
				if( xhr.readyState == 4 & xhr.status == 200 ){
					
					let data = xhr.responseText;
					let json = ( new Function('return '+data) )();
					
					if( json[0].result == 'yes' ){
						
						comment_list(comm_page);
						
					}else{
						alert("등록 실패");
					}
					
				}
			}//commFn()
			
			/*코멘트 작성 완료 후, 해당 게시글에 대한 코멘트만 추려내서 가져온 결과*/
			function comm_list_fn(){
				
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					let data = xhr.responseText;
					
					document.getElementById("comment_disp").innerHTML = data;
				}
			}//comm_list_fn()
			
			//-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
			function comment_list(comm_page){
				
				let r_board_idx = ${vo.r_board_idx};
				
				let url = "r_comment_list.do";
				let param = "r_board_idx=${vo.r_board_idx}&page="+comm_page;
				sendRequest(url, param, comm_list_fn, "post");
				
			}//comment_list()
			
			
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
			
			/*view로 봤을 때 내용의 가로가 긴 경우에 칸이 늘어나거나 칸 바깥으로 빠져나오지 않도록 함.*/
			pre {
				white-space: pre-wrap; /* 공백과 줄바꿈을 유지하면서 줄바꿈 */
				word-wrap: break-word; /* 긴 단어 줄바꿈 */
				margin: 0; /* pre 태그의 기본 마진 제거 */
			}
		</style>
		
	</head>
	
	<body>
		<form>
		
			<input type="hidden" name="r_board_idx" value="${vo.r_board_idx}">
			<!-- gpt가 추천한 코드 / 삭제 요청 시 r_board_idx가 누락되지 않고 정상적으로 전달 -->
			
			<table border="1" width="700" align="center">
				<caption>환율게시판 게시글 상세보기</caption>
				
				<tr>
					<td>제목</td>
					<td>${ vo.subject }</td>
				</tr>
				
				<tr>
					<td>작성자</td>
					<td>${ vo.name }</td>
				</tr>
				
				<tr>
					<td>작성자 id</td>
					<td>${ vo.user_id }</td>
				</tr>
				
				<tr>
					<td>내용</td>
					<td><pre>${ vo.content }</pre></td>
				</tr>
				
				<tr>
					<td>비밀번호</td>
					<td>${ vo.pwd }</td>
				</tr>
				
				<tr>
					<td>비번 입력</td>
					<td><input type="password" id="c_pwd"></td>
				</tr>
				
				<tr>
					<td colspan="2" align="right">
						<input type="button" value="목록으로" onclick="history.go(-1);">
							   
						<input type="button" value="수정" onclick="modify();">
               
						<input type="button" value="삭제" onclick="del(this.form);">
						
					</td>
				</tr>
				
			</table>
			
		</form>
		
		<hr width="700" align="center">
		
		<div>
		<form>
			<table border="1" align="center" width="700">
				<tr>
					<th>작성자</th><!-- 사용자의 id를 넣을 것인가?? 사용자의 이름?? -->
					<td><input name="name"></td>
				</tr>
				
				<tr>
					<th>댓글을 달 내용</th>
					<td>
						<textarea name="content" rows="5" cols="46" style="resize: none;"></textarea>
					</td>
				</tr>
				
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="comm_pwd">
						<input type="button" value="등록" onclick="send(this.form);">
					</td>
				</tr>
			</table>
		</form>
		</div>
		
		<div id="comment_disp" width="700"></div>
		
	</body>
</html>

