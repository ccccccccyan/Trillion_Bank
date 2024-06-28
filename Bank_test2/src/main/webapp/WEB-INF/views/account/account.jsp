<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	
	<!-- Ajax사용을 위한 js파일 -->
	<script src="/bank/resources/js/httpRequest.js"></script>
		
	
	<!-- swiper 설정 -->	
	<script src="/bank/resources/js/swiper-bundle.min.js"></script>
	<link rel="stylesheet" href="/bank/resources/css/swiper-bundle.min.css">

	<script src="/bank/resources/js/account_js.js"></script>
	<link rel="stylesheet" type="text/css" href="/bank/resources/css/account_css.css">

	<script src="/bank/resources/js/bank_header_js.js"></script>
	<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
	
	<script>
	document.addEventListener("DOMContentLoaded", function() {
	    // Swiper 라이브러리가 로드된 후에 실행되어야 하는 코드
	    var swiper = new Swiper(".mySwiper", {
	        slidesPerView: 3,
            centeredSlides: false, // 중앙 정렬 해제
	        spaceBetween: 30,
	        pagination: {
	            el: ".swiper-pagination",
	            type: "fraction",
	        },
	        navigation: {
	            nextEl: ".swiper-button-next",
	            prevEl: ".swiper-button-prev",
	        },
	    });
	})
	
	// 그래프 ---------------------------------------------------
	  document.addEventListener("DOMContentLoaded", function() {
	        fetch("cart_view.do")
	            .then(response => {
	            	
	            	console.log(response);
	            	
	                if (!response.ok) {
	                    throw new Error('Network response was not ok');
	                }
	                return response.json();
	            })
	            .then(data => {
	            
	                let ttb = [];
	                let rate_date = [];
	                
	                let flattenedData = data[0].flat(); // 다차원 배열을 1차원 배열로 변환
	                // 콘솔에 데이터 로그 찍기
	                flattenedData.forEach(rateVO => {
	                    console.log('Rate Index:', rateVO.rate_idx);
	                    console.log('TTB:', rateVO.ttb);
	                    console.log('TTS:', rateVO.tts);
	                    console.log('Currency Name:', rateVO.cur_nm);
	                    console.log('Rate Date:', rateVO.rate_date);
	               
	                   
	                    ttb.push(rateVO.ttb);
	                    rate_date.push(rateVO.rate_date);
	                });
					
	                console.log("=====================");
	                console.log(flattenedData);
	                
	                // 차트 그리기 함수 호출
	                show_chart(ttb, rate_date);
	            })
	            .catch(error => {
	                console.error('There was a problem with the fetch operation:', error);
	            });
	
	 }); 
	function show_chart(ttb, rate_date) {
	    // 캔버스 요소 가져오기
	    var ctx = document.getElementById('myChart').getContext('2d');
		console.log("------------------");
		  // ttb 배열의 데이터를 숫자로 변환하는 과정
	    let ttb_numeric = ttb.map(value => parseFloat(value.replace(',', ''))); // ',' 제거 후 숫자로 변환
		
		
		console.log(ttb);
	    // 차트 생성
	    var myChart = new Chart(ctx, {
	        type: 'line', // 차트 유형 (bar, line, pie, 등)
	        data: {
	            labels: rate_date,
	            datasets: [{
	                label: 'TTB',
	                data: ttb_numeric,
	                borderColor:[
	                    'rgba(49, 140, 114, 1)'
	                ] ,
	                borderWidth: 1
	            }]
	        },
	        options: {
	            scales: {
	                y: {
	                    beginAtZero: false,
	                    min: 1000,  // y축 최소값 설정
	                    max: 1600,  // y축 최대값 설정
	                    ticks: {
	                        stepSize: 200 // 눈금 간격 설정
	                    }
	                }
	            }
	        }
	    });
	}
	
	
	</script>

	  
	</head>



	<body>
		<div id="container">

			
			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
		
			<div class="account_box ">
				<h2 class="seeMyaccount">내 계좌 보기</h2>
				<div id="account_container" class="mySwiper">
					<div id="account_slide" class="swiper-wrapper">
							<c:forEach var="vo" items="${account_list}">
								<div class="bankbook_body swiper-slide">
									<div class="nowmoney_info">
									${vo.now_money }
									</div>
									<div class="account_number_info">
									${vo.account_number}
									</div>
									<div class="bankname_info">
									${vo.bank_name }
									</div>
									
									<div class="bankbook_front"></div>
									<div class="bankbook_line"></div>
									<div class="bankbook_page1"></div>
									<div class="bankbook_page2"></div>
									<div class="bankbook_end"></div>
								</div>
							</c:forEach>
							<div class="account swiper-slide">
								<a><img src="/bank/resources/img/카드 추가.png" onclick="account_insert_form('${user_id}');"> </a>
							</div>
					</div>

					<div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				    <div class="swiper-pagination"></div>
				</div>
			</div>
			
			
			<div id="board_body">
				<div class="seeqna board_body_content">
					<h2>Q&A</h2>
					<table border="1">
						<c:forEach var="vo" items="${qna_list}">
						<tr>
							<td>${vo.subject}</td>
						</tr>
						</c:forEach>
					</table>
				</div>

				<div class="seenotice board_body_content">
					<h2>공지사항</h2>
					<table border="1">
						<c:forEach var="vo" items="${notice_list}">
						<tr>
							<td>${vo.subject}</td>
						</tr>
						</c:forEach>

					</table>
				</div>
			</div>
			
			<div id="rate_body">
				<div class="fagor">
					<h2>﻿그래프 (아니면 FAQ)</h2>
						<canvas id="myChart"></canvas>
				</div>

				<div class="seeboard">
					<h2>환율 게시판</h2>
					<table border="1">
						<c:forEach var="vo" items="${board_list}">
						<tr>
							<td>${vo.subject} ( ${vo.comm_cnt} )</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			
			
			<div id="footer">
			a
			</div>			
		</div>
	</body>
</html>