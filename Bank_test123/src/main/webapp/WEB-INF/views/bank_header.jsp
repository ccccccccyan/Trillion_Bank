<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>header</title>

<script src="/bank/resources/js/bank_header_js.js"></script>
<link rel="stylesheet" type="text/css"
	href="/bank/resources/css/bank_header_css.css">

<!-- Ajax사용을 위한 js파일 -->
<script src="/bank/resources/js/httpRequest.js"></script>

</head>

<body>
	<div id="bank_headcontainer">

		<div id="setting_category">
			<div id="close_category" onclick="close_settings();">
				<img src="/bank/resources/img/창끄기.png">
			</div>

			<div id="set_category">

				<c:if test="${ empty user_id }">
					<div>
						<a href="login.do">로그인</a>
					</div>
					<div>
						<a href="signup.do">회원가입</a>
					</div>
				</c:if>

				<c:if test="${ not empty user_id }">
					<div onclick="user_info_check('${user_id}');">개인정보 수정</div>
					<div>
						<a href="logout.do">로그아웃</a>
					</div>
				</c:if>
			</div>

		</div>

		<div id="header_container">

			<div id="header_icon" onclick="location.href='account_list.do'">
				<img src="/bank/resources/img/일조은행아이콘.png">
			</div>

			<div id="body">
				<ul>
					<li>
						<div class="mainMenu" onclick="sideMenu_open('sideMenu1');">환율</div>
						<ul id="sideMenu1">
							<li class="sideMenu"><a href="rate_inquiry.do">환율 조회</a></li>
							<li class="sideMenu"><a href="r_list.do">환율 게시판</a></li>
						</ul>
					</li>

					<li>
						<div class="mainMenu" onclick="sideMenu_open('sideMenu2');">은행
							안내</div>
						<ul id="sideMenu2">
							<li class="sideMenu"><a href="ceo_greeting.do">CEO인사말</a></li>
							<li class="sideMenu"><a href="vision.do">비전</a></li>
							<li class="sideMenu"><a href="organization_chart.do">조직도</a></li>
							<li class="sideMenu"><a href="guide.do">영업점 안내</a></li>
						</ul>
					</li>

					<li>
						<div class="mainMenu" onclick="sideMenu_open('sideMenu3');">연혁</div>
						<ul id="sideMenu3">
							<li class="sideMenu"><a href="schedule_all.do">전체 일정</a></li>
							<li class="sideMenu"><a href="schedule_ojh.do">오종하 CEO</a></li>
							<li class="sideMenu"><a href="schedule_ksy.do">김서영 임원</a></li>
							<li class="sideMenu"><a href="schedule_kjh.do">김지환 임원</a></li>
							<li class="sideMenu"><a href="schedule_mkj.do">장민경 임원</a></li>
						</ul>
					</li>

					<li>
						<div class="mainMenu" onclick="sideMenu_open('sideMenu4');">자료실</div>
						<ul id="sideMenu4">
							<li class="sideMenu"><a href="recruitment_information.do">채용정보</a></li>
							<li class="sideMenu"><a href="ideal_talent.do">인재상</a></li>
							<li class="sideMenu"><a href="pr_center.do">홍보센터</a></li>
							<li class="sideMenu"><a href="n_list.do">공지사항</a></li>
							<li class="sideMenu"><a href="q_list.do">Q&A</a></li>
						</ul>
					</li>
				</ul>

			</div>

			<div id="settings" onclick="open_settings('${user_id}');">
				<img src="/bank/resources/img/설정1.png">
			</div>
		</div>
	</div>
</body>
</html>