<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>header</title>
		
		<script src="/bank/resources/js/bank_header_js.js"></script>
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
		
		<!-- Ajax사용을 위한 js파일 -->
		<script src="/bank/resources/js/httpRequest.js"></script>
		
		<script>
			function user_remove_check(user_id) {
				if(confirm(user_id+"님의 정보가 영구적으로 제거됩니다. 정말 탈퇴하시겠습니까?")){
					let url = "user_remove.do";
					let param = "user_id="+user_id;
					
					sendRequest(url, param, user_removeFn, "post");
					
				}else{
					alert("회원 탈퇴가 중지되었습니다.");
				}
			}
			
			function user_removeFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					
					console.log(data);
					let json = (new Function('return ' + data))();
					
					if(json[0].result == 'clear'){
						alert("회원 정보가 성공적으로 제거되었습니다.");
						location.href="account_list.do";
					}else{
						alert("회원 정보 제거에 실패하였습니다.");
					}
					
				}
			}
			
			function user_info_check(user_id) {
					let user_pwd = prompt("비밀번호를 입력하세요");
					    
					if (user_pwd !== null) { // 사용자가 입력을 취소하지 않은 경우
					
					
					let url = "user_infocheck.do";
					let param = "user_id="+user_id + "&user_pwd="+user_pwd;
					
					sendRequest(url, param, user_infoFn, "post");
					}
			}
			
			function user_infoFn() {
				if(xhr.readyState == 4 && xhr.status == 200){
					let data = xhr.responseText;
					
					console.log(data);
					let json = (new Function('return ' + data))();
					
					if(json[0].pwd == prompt("비밀번호를 입력하세요")){
						location.href="user_info_modify.do";
					}else{
						alert("비밀번호 불일치.");
					}
					
				}
			}
		
		</script>
		
	</head>
	
	<body>
		<div id="bank_headcontainer">
	
			<div id="setting_category">
				<div id="close_category" onclick="close_settings();"><img src="/bank/resources/img/창끄기.png"> </div>

				<div id="set_category">
				
					<c:if test="${ empty user_id }">
						<div> <a href="login.do">로그인</a></div>
						<div> <a href="signup.do">회원가입</a></div>
					</c:if>
				
					<c:if test="${not empty user_id }">
						<div onclick="user_info_check('${user_id}');">개인정보 수정</div>
						<div> <a href="logout.do">로그아웃</a></div>
						<div onclick="user_remove_check('${user_id}');">회원탈퇴</div>
					</c:if>
				</div>
				
			</div>
			
			<div id="header_container">
			
			
				<div id="header_icon" onclick="location.href='account_list.do'"><img src="/bank/resources/img/일조은행아이콘.png">  </div>
	
				<div id="body">
					<ul>
						<li>
							<div class="mainMenu" onclick="sideMenu_open('sideMenu1');">환율</div>
								<ul id="sideMenu1">
									<li class="sideMenu"><a href="#">환율 조회</a></li>
									<li class="sideMenu"><a href="#">환율 게시판</a></li>
								</ul>
						</li>
						
						<li>
							<div class="mainMenu" onclick="sideMenu_open('sideMenu2');">은행 안내</div>
								<ul id="sideMenu2">
									<li class="sideMenu"><a href="#">CEO인사말</a></li>
									<li class="sideMenu"><a href="#">비전</a></li>
									<li class="sideMenu"><a href="#">조직도</a></li>
									<li class="sideMenu"><a href="#">영업점 안내</a></li>
								</ul>
						</li>
						
						<li>
							<div class="mainMenu" onclick="sideMenu_open('sideMenu3');">연혁</div>
								<ul id="sideMenu3">
									<li class="sideMenu"><a href="#">전체 일정</a></li>
									<li class="sideMenu"><a href="#">김서영 CEO</a></li>
									<li class="sideMenu"><a href="#">김지환 임원</a></li>
									<li class="sideMenu"><a href="#">오종하 임원</a></li>
									<li class="sideMenu"><a href="#">장민경 임원</a></li>
								</ul>
						</li>
						
						<li>
							<div class="mainMenu" onclick="sideMenu_open('sideMenu4');">자료실</div>
								<ul id="sideMenu4">
									<li class="sideMenu"><a href="#">채용정보</a></li>
									<li class="sideMenu"><a href="#">인재상</a></li>
									<li class="sideMenu"><a href="#">홍보센터</a></li>
									<li class="sideMenu"><a href="#">공지사항</a></li>
									<li class="sideMenu"><a href="#">Q&A</a></li>
								</ul>
						</li>
					</ul>
				
				</div>
						
			<div id="settings" onclick="open_settings('${user_id}');"> <img src="/bank/resources/img/설정1.png"> </div> 
			</div>
		</div>
	</body>
</html>