<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>조직도</title>

<style>
.body {
	font-family: 'Arial', sans-serif;
	background-color: #f4f4f9;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.org-chart {
	display: flex;
	flex-direction: column;
	align-items: center;
}

.level {
	display: flex;
	justify-content: center;
	margin: 10px 0;
}

.person {
	background-color: #007bff;
	color: #fff;
	padding: 10px 20px;
	margin: 5px;
	border-radius: 5px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	cursor: pointer;
	transition: transform 0.2s, box-shadow 0.2s;
}

.person:hover {
	transform: translateY(-5px);
	box-shadow: 0 6px 12px rgba(0, 0, 0, 0.3);
}
</style>

</head>
<body>

	<div id="header">
		<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	</div>

	<div class="org-chart">
		<div class="level">
			<div class="person">CEO 김서영</div>
		</div>
		<div class="level">
			<div class="person">CTO 장민경</div>
			<div class="person">CFO 오종하</div>
			<div class="person">COO 김지환</div>
		</div>
		<div class="level">
			<div class="person">Engineering Manager</div>
			<div class="person">Finance Manager</div>
			<div class="person">Operations Manager</div>
		</div>
		<div class="level">
			<div class="person">Software Engineer</div>
			<div class="person">Accountant</div>
			<div class="person">Logistics Coordinator</div>
		</div>
	</div>
</body>
</html>