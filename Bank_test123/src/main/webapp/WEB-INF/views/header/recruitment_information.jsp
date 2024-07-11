<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>일조 은행 채용공고</title>
<style>
body {
	font-family: Arial, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f4f4f4;
}

.container {
	width: 80%;
	margin: 40px auto;
	padding: 20px;
	background-color: #fff;
	box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
	border-radius: 10px;
}

h1, h2, h3 {
	color: #2c3e50;
	margin: 0;
}

h1 {
	text-align: center;
	margin-bottom: 30px;
	font-size: 2.5em;
}

h2 {
	border-bottom: 2px solid #2c3e50;
	padding-bottom: 10px;
	margin-bottom: 20px;
	font-size: 1.75em;
}

h3 {
	color: #2980b9;
}

.job-section {
	margin-bottom: 30px;
}

.job-section h3 {
	margin-bottom: 10px;
	font-size: 1.5em;
}

.job-section p {
	margin: 5px 0;
	line-height: 1.6;
}

table {
	width: 100%;
	border-collapse: collapse;
	margin-bottom: 30px;
}

table, th, td {
	border: 1px solid #ddd;
}

th, td {
	padding: 10px;
	text-align: left;
}

th {
	background-color: #f4f4f4;
}

.apply-method, .process, .benefits, .company-info, .contact {
	margin-bottom: 30px;
}

.contact p {
	margin: 5px 0;
}

a {
	color: #3498db;
	text-decoration: none;
}

a:hover {
	text-decoration: underline;
}

.ad-links {
	margin-top: 40px;
	text-align: center;
}

.ad-links a {
	display: inline-block;
	margin: 10px;
	background-color: #3498db;
	color: white;
	padding: 10px 20px;
	border-radius: 5px;
	transition: background-color 0.3s;
}

.ad-links a:hover {
	background-color: #2980b9;
}

.apply-method a {
	color: #3498db;
	text-decoration: underline;
	font-weight: bold;
}

p {
	color: #555;
}

strong {
	color: #2c3e50;
}
</style>
</head>
<body>
		<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
	<div class="container">
		<h1>일조 은행 채용공고</h1>
		<p style="font-size: 25px; font-weight: bold;">일조 = trillion = 1,000,000,000,000달러 = 부자 ,
			 여러분들의 지원에 우리는 부자가 됩니다. 껄껄</p>

		<h2>채용 포지션</h2>

		<table>
			<thead>
				<tr>
					<th>직무</th>
					<th>업무 내용</th>
					<th>자격 요건</th>
					<th>근무 지역</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>금융 컨설턴트</td>
					<td>개인 및 기업 고객의 금융 상담 및 자산 관리</td>
					<td>관련 경력 2년 이상, 금융 자격증 소지자 우대</td>
					<td>서울</td>
				</tr>
				<tr>
					<td>IT 개발자</td>
					<td>은행 시스템 개발 및 유지 보수</td>
					<td>컴퓨터 공학 전공자, Java, Python 능숙자</td>
					<td>서울</td>
				</tr>
				<tr>
					<td>마케팅 전문가</td>
					<td>마케팅 전략 수립 및 실행, 시장 조사</td>
					<td>관련 경력 3년 이상, 데이터 분석 능력</td>
					<td>서울</td>
				</tr>
			</tbody>
		</table>

		<h2>지원 방법</h2>

		<div class="apply-method">
			<p><strong>제출 서류:</strong> 이력서 및 자기소개서, 자격증 사본, 포트폴리오 (해당 시)</p>
			<p><strong>제출 방법:</strong> <br>이메일 접수: tb@hrd.com<br>우편 접수: 서울특별시 강남구 테헤란로 123, 일조 은행 인사팀</p>
		</div>

		<h2>채용 절차</h2>

		<div class="process">
			<p>1. 서류 전형</p>
			<p>2. 면접 전형</p>
			<p>3. 최종 합격 발표</p>
		</div>

		<h2>임직원 복리후생</h2>

		<div class="benefits">
		<table>
		<thead>
			<tr>
				<th>복리 항목</th>
				<th>세부사항</th>
			</tr>
		</thead>
		<tbody>
			<tr>
				<td>급여제도</td>
				<td>연봉제, 인센티브, 퇴직연금, 4대보험, 자녀수당 (자녀수 제한 없음)</td>
			</tr>
			<tr>
				<td>출산/육아</td>
				<td>산전 후 휴가, 육아휴직, 배우자 출산휴가</td>
			</tr>
			<tr>
				<td>의료/건강 지원</td>
				<td>본인 의료비 지원, 건강검진</td>
			</tr>
			<tr>
				<td>생활안정 지원</td>
				<td>주택 구입/전세 등 생활 안정자금 대출</td>
			</tr>
			<tr>
				<td>학자금 지원</td>
				<td>재직자 자녀에게 대학등록금 지원 (자녀수 제한 없음)</td>
			</tr>
			<tr>
				<td>시설 지원</td>
				<td>회사보유 휴양시설 회원권 (자체 연수원/캠핑장 보유)</td>
			</tr>
			<tr>
				<td>식사관련</td>
				<td>점심식사 제공</td>
			</tr>
			<tr>
				<td>휴가 지원</td>
				<td>연간 연차 280일</td>
			</tr>
			<tr>
				<td>자기계발 지원</td>
				<td>자격증 취득 비용 지원</td>
			</tr>
			<tr>
				<td>경조금 지원</td>
				<td>결혼, 자녀 출산, 본인 부모사망, 장기근속, 정년퇴임 등</td>
			</tr>
			<tr>
				<td>회사 행사</td>
				<td>귀찮게 안함</td>
			</tr>
			<tr>
				<td>출/퇴근 지원</td>
				<td>CEO가 직접 모시러가고 모셔다 줌, 11시 출근 14시 퇴근</td>
			</tr>
		</tbody>
		</table>
		</div>

		<h2>회사 소개</h2>

		<div class="company-info">
			<p>일조 은행은 혁신과 신뢰를 바탕으로 고객에게 최고의 금융 서비스를 제공하는 국내 최고의 금융 기관입니다. 다양한 분야에서 활약하고 있는 인재들과 함께 더 큰 미래를 만들어가고 있습니다.</p>
		</div>

		<h2>문의사항</h2>

		<div class="contact">
			<p><strong>전화:</strong> 02-1234-5678</p>
			<p><strong>이메일:</strong> TrillionBank@tb.com</p>
		</div>

	</div>
</body>
</html>
