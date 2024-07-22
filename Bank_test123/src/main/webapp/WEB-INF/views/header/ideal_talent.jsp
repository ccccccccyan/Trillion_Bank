<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>인재상</title>
		
		<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.0.7/css/boxicons.min.css">
		
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
			
			.content-container {
				display: flex;
				flex-direction: column;
				align-items: center;
				width: 80%;
				margin-top: 40px;
				padding: 20px;
				box-sizing: border-box;
			}
			
			.title {
				font-size: 2.5em;
				font-weight: bold;
				color: #333;
				margin-bottom: 20px;
			}
			
			.intro-text {
				font-size: 1.2em;
				color: #666;
				text-align: center;
				margin-bottom: 40px;
			}
			
			.card-container {
				display: flex;
				flex-wrap: wrap;
				justify-content: center;
			}
			
			.card {
				width: 250px;
				height: 350px;
				background: #fff;
				margin: 20px;
				border-radius: 20px;
				box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
				transition: transform 0.2s, box-shadow 0.2s;
				display: flex;
				flex-direction: column;
				align-items: center;
				padding: 20px;
				box-sizing: border-box;
			}
			
			.card:hover {
				transform: translateY(-5px);
				box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
			}
			
			.card i {
				font-size: 3em;
				margin-bottom: 20px;
				color: #6799FF;
			}
			
			.card-title {
				font-size: 1.5em;
				font-weight: bold;
				color: #333;
				margin-bottom: 30px;
			}
			
			.card-description {
				font-size: 1em;
				color: #666;
				text-align: center;
			}
			
		</style>
		
	</head>
	
	<body>
	
	<div id="header">
		<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	</div>
	
	<div class="content-container">
		<div class="title">일조은행 인재상</div>
		
		<div class="intro-text">일조은행은 다음과 같은 인재를 찾고 있습니다. 우리의 미래를 함께 만들어갈 열정적이고 유능한 인재를 환영합니다.</div>
		
		<div class="card-container">
			<div class="card">
				<i class='bx bx-brain'></i>
				<div class="card-title">창의적인 사고</div>
				<div class="card-description">새로운 아이디어와 혁신을 추구하며, 창의적인 해결책을 제시하는 인재</div>
			</div>
			<div class="card">
				<i class='bx bx-group'></i>
				<div class="card-title">팀워크</div>
				<div class="card-description">협력과 소통을 통해 팀의 목표를 달성하고, 상호 존중하는 인재</div>
			</div>
			<div class="card">
				<i class='bx bx-line-chart'></i>
				<div class="card-title">성장 지향</div>
				<div class="card-description">자기 개발과 성장을 위해 노력하며, 목표를 향해 꾸준히 나아가는 인재</div>
			</div>
			<div class="card">
				<i class='bx bx-trophy'></i>
				<div class="card-title">책임감</div>
				<div class="card-description">자신의 역할에 대해 책임을 지고, 신뢰를 기반으로 성과를 이루는 인재</div>
			</div>
			<div class="card">
				<i class='bx bx-heart'></i>
				<div class="card-title">고객 중심</div>
				<div class="card-description">고객의 니즈를 이해하고, 최상의 서비스를 제공하며 고객 만족을 최우선으로 하는 인재</div>
			</div>
		</div>
	</div>
	
	</body>
</html>