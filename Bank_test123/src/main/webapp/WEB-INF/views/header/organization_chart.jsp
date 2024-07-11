<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>조직도</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.0.7/css/boxicons.min.css">
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f4f9;
	display: flex;
	flex-direction: column;
	align-items: center;
	margin: 0;
	padding: 0;
}

#header {
	width: 100%;
	z-index: 3;
}

.org-chart-container {
	display: flex;
	justify-content: center;
	align-items: center;
	width: 100%;
	margin-top: 20px;
	padding: 20px;
	box-sizing: border-box;
}

.org-chart {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.level {
	display: flex;
	justify-content: center;
	margin: 20px 0;
}

.person-container {
	display: flex;
	flex-direction: column;
	align-items: center;
	text-align: center;
	position: relative; /* 추가: 포지션 설정 */
	z-index: 1; /* person 요소 위로 올리기 */
}

.person_box {
	width: 150px;
	height: 360px;
	color: #fff;
	padding: 20px 60px;
	margin: 15px 30px;
	background: linear-gradient(to bottom, #6799FF 30%, #fff 0%);
	border-radius: 60px;
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
	cursor: pointer;
	transition: transform 0.2s, box-shadow 0.2s;
	font-size: 1.25em;
	position: relative; /* 추가: 포지션 설정 */
}

.person_box#jyh {
	width: 150px;
	height: 50px;
	background: #6799FF;
	border-radius: 60px;
}

.person {
	color: #fff;
	padding: 15px 0px;
	font-size: 20px;
	font-weight: bold;
}

.person#jyh_text {
	color: #fff;
	padding: 5px 0px;
	font-size: 23px;
}

.person#jyh_text2 {
	color: #fff;
	margin-top: -13px;
	padding: 5px 0px;
	font-size: 20px;
}

.person_box:hover {
	transform: translateY(-5px);
	box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
}

.city {
	width: 100%;
	height: 40px;
	background-color: #EAEAEA;
	padding: 13px 20px;
	margin-left: -20px;
	border-radius: 30px;
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 수직 중앙 정렬 */
	justify-content: center; /* 수평 중앙 정렬 */
	font-size: 20px;
	color: #333;
	margin-top: 10px;
	font-weight: bold;
}

.city_h {
	width: 100%;
	height: 40px;
	background-color: #6799FF;
	padding: 13px 20px;
	margin-left: -20px;
	border-radius: 30px;
	display: flex; /* Flexbox 사용 */
	align-items: center; /* 수직 중앙 정렬 */
	justify-content: center; /* 수평 중앙 정렬 */
	font-size: 20px;
	color: #fff;
	margin-top: 10px;
	font-weight: bold;
}

.y-line {
	border-left: 3px solid #23212b;
	height: 40px;
	margin: -35px 0 0 0;
}

.y-line2 {
	border-left: 3px solid #23212b;
	height: 50px;
	margin: -43px 0 -15px 0;
}

.x-line {
	width: 75%;
	border-top: 3px solid #23212b;
	margin-top: -3px;
	margin-bottom: 20px;
}

/* 아이콘 스타일 */
i {
	font-size: 1em; /* 아이콘 크기 설정 */
	margin-bottom: -23px;
	z-index: 2; /* person 요소 위로 올리기 */
}

i#white {
	padding-top: -15px;
	z-index: 2;
	font-size: 0.8em; /* person 요소 위로 올리기 */
}

i#user {
	padding-top: -15px;
	margin-left: -5px;
	font-size: 8em; /* 아이콘 크기 설정 */
	z-index: 2;
	color: black;
}
i#user_gold {
	padding-top: -15px;
	margin-left: -5px;
	font-size: 8em; /* 아이콘 크기 설정 */
	z-index: 2;
	color: #E5D85C;
}
i#crown{
	position: absolute; /* 추가: 포지션 설정 */
	top: 10px; /* 왕관 아이콘의 위치를 조정 */
	right: 30px; /* 왕관 아이콘의 위치를 조정 */
	font-size: 2.5em; /* 아이콘 크기 설정 */
	z-index: 2;
	color: #E5D85C;
}
</style>

</head>
<body>

	<div id="header">
		<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	</div>
	<div class="org-chart-container">
		<div class="org-chart">
			<div class="level">
				<div class="person-container">
					<div class="person_box" id="jyh">
						<div class="person" id="jyh_text2">일조은행 본사</div>
						<div class="person" id="jyh_text">창업주 정용훈</div>
					</div>
				</div>
			</div>
			<div class='y-line'></div>
			<hr class='x-line'></hr>
			<div class="level">
				<div class="person-container">
					<div class='y-line2'></div>
					<i class='bx bxs-circle'></i>
					<div class="person_box" onclick="location.href='chart_ojh.do'">
						<i class='bx bxs-circle' id="white"></i>
						<i class='bx bx-crown' id="crown"></i>
						<div class="person" id="ojh">
							<br>일조은행 강남점
						</div>
						<i class='bx bxs-user' id="user_gold"></i>
						<div class="city_h">CEO 오종하</div>
						<!-- <div class="city">CEO 오종하</div>
						<div class="city">CEO 오종하</div> -->
					</div>
				</div>
				<div class="person-container">
					<div class='y-line2'></div>
					<i class='bx bxs-circle'></i>
					<div class="person_box" onclick="location.href='chart_ksy.do'">
						<i class='bx bxs-circle' id="white"></i>
						<div class="person" id="ksy">
							<br>일조은행 역삼점
						</div>
						<i class='bx bxs-user' id="user"></i>
						<div class="city_h">전무이사 김서영</div>
						<!-- <div class="city">전무이사 김서영</div>
						<div class="city">전무이사 김서영</div> -->
					</div>
				</div>
				<div class="person-container">
					<div class='y-line2'></div>
					<i class='bx bxs-circle'></i>
					<div class="person_box" onclick="location.href='chart_mkj.do'">
						<i class='bx bxs-circle' id="white"></i>
						<div class="person" id="jmk" >
							<br>일조은행 인천점
						</div>
						<i class='bx bxs-user' id="user"></i>
						<div class="city_h">상무이사 장민경</div>
						<!-- <div class="city">상무이사 장민경</div>
						<div class="city">상무이사 장민경</div> -->
					</div>
				</div>
				<div class="person-container">
					<div class='y-line2'></div>
					<i class='bx bxs-circle'></i>
					<div class="person_box" onclick="location.href='chart_kjh.do'">
						<i class='bx bxs-circle' id="white"></i>
						<div class="person" id="kjh" >
							<br>일조은행 배곧점
						</div>
						<i class='bx bxs-user' id="user"></i>
						<div class="city_h">인턴 김지환</div>
						<!-- <div class="city">인턴 김지환</div>
						<div class="city">인턴 김지환</div> -->
					</div>
				 </div>
			</div>
		</div>
	</div>
</body>
</html>
