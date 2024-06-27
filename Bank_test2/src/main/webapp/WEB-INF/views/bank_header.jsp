<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>header</title>
		
		<script src="/bank/resources/js/bank_header_js.js"></script>
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
		
	</head>
	
	<body>
		<div id="bank_headcontainer">
	
			<div id="setting_category">
				<div id="close_category" onclick="close_settings();"><img src="/bank/resources/img/창끄기.png"> </div>

				<div id="set_category">
					<div>개인정보 수정</div>
					<div>로그아웃</div>
					<div>회원탈퇴</div>
				</div>
				
			</div>
			
			<div id="header_container">
			
			
				<div id="header_icon" onclick="location.href='account_list.do'"> Trillion Bank</div>
	
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