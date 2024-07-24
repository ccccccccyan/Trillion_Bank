<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>김지환 임원 연혁</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.0.7/css/boxicons.min.css">
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f9;
    margin: 0;
    padding: 0;
}

.container {
    width: 80%;
    margin: 40px auto;
    background-color: #fff;
    padding: 20px;
    box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

h1 {
    text-align: left;
    margin-left: 10px;
    color: #353535;
    font-size: 40px;
}

h2.custom {
    text-align: left;
    margin-left: 10px;
    color: #353535;
    margin-top: -20px;
    margin-bottom: 40px;
    font-size: 30px;
}

.timeline {
    position: relative;
    margin: 0;
    padding: 0;
    list-style: none;
}

.timeline::before {
    content: '';
    position: absolute;
    left: 23px; /* 위치 조정 */
    top: 0;
    bottom: 0;
    width: 4px;
    background: #ddd;
}

.timeline-item {
    position: relative;
    width: 100%;
    padding: 10px 40px;
    box-sizing: border-box;
    text-align: left; 
    margin-bottom: 40px;
    padding-left: 60px; 
}

.timeline-item::before {
    content: '';
    position: absolute;
    top: 20px;
    left: 20px; 
    width: 12px; 
    height: 12px; 
    background: #353535;
    border-radius: 50%;
    box-shadow: 0 0 0 4px #fff;
}

.timeline-item h3 {
    margin: 0 0 10px;
    font-size: 1.5em;
    color: #353535;
}

.timeline-item p {
    margin: 0;
    color: #555;
    margin-bottom:30px;
    font-weight: bold;
}

i{
	color:#353535;
}
</style>
</head>
<body>
    <div id="header">
        <jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
    </div>
    <div class="container">
    	<h1>인턴</h1>
        <h2 class="custom">김지환</h2>
        <br>
        <h2 class="custom">일조은행원이 되기까지</h2>
        <ul class="timeline">
            <li class="timeline-item">
                <h3>2024</h3>
                <p>ㆍ07월 - 일조은행 배곧점 회원수 1500만 달성</p>
            </li>
            <li class="timeline-item">
                <h3>2022</h3>
                <p>ㆍ12월 - 일조은행 모바일 앱 출시에 큰 공헌</p>
                <p>ㆍ04월 - 일조은행 배곧점 회원수 300만명 달성</p>
            </li>
            <li class="timeline-item">
                <h3>2020</h3>
                <p>ㆍ11월 - 전역</p>
                <p>ㆍ02월 - 일조은행 배곧 지점장 임명 </p>
            </li>
            <li class="timeline-item">
                <h3>2019</h3>
                <p>ㆍ04월 - 입대</p>
            </li>
            <li class="timeline-item">
                <h3>2018</h3>
                <p>ㆍ02월 - 인천대학교 입학</p>
            </li>
            <li class="timeline-item">
                <h3>2015</h3>
                <p>ㆍ02월 - 신송고등학교 입학</p>
            </li>
            <li class="timeline-item">
                <h3>2012</h3>
                <p>ㆍ02월 - 해양중학교 입학</p>
            </li>
            <li class="timeline-item">
                <h3>2006</h3>
                <p>ㆍ02월 - 청석초등학교 입학</p>
                <p></p>
            </li>
            <li class="timeline-item">
                <h3>1999</h3>
                <p>ㆍ12월 - 탄생</p>
            </li>
        </ul>
    </div>
</body>
</html>
