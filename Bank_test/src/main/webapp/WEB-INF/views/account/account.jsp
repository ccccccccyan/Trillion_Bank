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
	<link rel="stylesheet"
  		href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
	<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

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
		
		// 전역 변수로 myChart 정의
		let myChart;  
		
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
		            	console.log("들어옴");
		            	console.log(data);
		                let cur_unit = [];
		                let max = [];
		                let min = [];
	
		                let ttb_list = [];
		                let tts_list = [];
		                let rate_date_list = [];
		                
		//                let flattenedData = data[0].flat(); // 다차원 배열을 1차원 배열로 변환
		               data.forEach((day_map_list, index) =>{
			                let rate_date = [];
			                let ttb = [];
			                let tts = [];
	
		            	   cur_unit.push(day_map_list.cur_unit);
			            	console.log(day_map_list.cur_unit);
			            	console.log(day_map_list.max_data);
			            	console.log(parseFloat(day_map_list.max_data));
		            	   
			            	max.push(parseFloat(day_map_list.max_data));
			            	min.push(parseFloat(day_map_list.min_data));
		            	   
		            	   day_map_list.rateVO_data.forEach( rateVO=> {
		            		   ttb.push(parseFloat(rateVO.ttb.replace(',', ''))); // 쉼표 제거 후 숫자로 변환
		                       tts.push(parseFloat(rateVO.tts.replace(',', ''))); // 쉼표 제거 후 숫자로 변환
		                   	   rate_date.push(rateVO.rate_date);
		            	   });
		            	   
		            	   ttb_list.push(ttb); // 2차원 배열의 각 행 초기화
		                   tts_list.push(tts);
		                   rate_date_list.push(rate_date)
		               });
		                
		                // 차트 그리기 함수 호출
		               show_chart(cur_unit[0], rate_date_list[0], ttb_list[0], tts_list[0], max[0], min[0]);
		               updataChartData(cur_unit, rate_date_list, ttb_list, tts_list, max, min);
		               
		            })
		            .catch(error => {
		                console.error('There was a problem with the fetch operation:', error);
		            });
		 }); 
		
		
		function show_chart(cur_unit, rate_date, ttb, tts, max , min) {
		    // 캔버스 요소 가져오기
		    var ctx = document.getElementById('myChart').getContext('2d');
			console.log("------------------");
			  // ttb 배열의 데이터를 숫자로 변환하는 과정
	//	    let ttb_numeric = ttb.map(value => parseFloat(value.replace(',', ''))); // ',' 제거 후 숫자로 변환
			
			console.log("cur_unit : "+cur_unit);
			console.log("rate_date : "+rate_date);
			console.log("ttb : "+ttb);
			console.log("tts : "+tts);
			console.log("max : "+max);
			console.log("min : "+min);
			
		    // 차트 생성
		    if (!myChart) {
		    myChart = new Chart(ctx, {
		        type: 'line', // 차트 유형 (bar, line, pie, 등)
		        data: {
		            labels: rate_date,
		            datasets: [{
		                label: 'ttb',
		                data: ttb,
		                borderColor:'rgba(49, 140, 114, 1)',
		                borderWidth: 1
		            },{
		                label: 'tts',
		                data: tts,
		                borderColor:'rgba(219, 214, 53, 1)',
		                borderWidth: 1
		            }
		            ]
		        },
		        options: {
		        	responsive: true, // 차트 크기가 자동으로 조절되도록 설정
		    		maintainAspectRatio: true, // 차트의 가로 세로 비율을 유지하지 않음
		            // 차트 애니메이션 효과를 설정
		            animation: {
		                duration: 500, // 애니메이션 지속 시간을 설정
		                easing: 'easeOutQuad' // 애니메이션의 변화 속도 설정
		            },
		            scales: {
		                y: {
		                    beginAtZero: false,
		                    min: min,  // y축 최소값 설정
		                    max: max  // y축 최대값 설정
		                }
		            },
		            plugins: {
		                title: {
		                    display: true,
		                    text: cur_unit
		                } 
		            }
		        }
		    });
		
			}else {// 차트 객체가 있는 경우, 데이터 업데이트
		        myChart.data.labels = rate_date;
		        myChart.data.datasets[0].data = ttb;
		        myChart.data.datasets[1].data = tts;
		        myChart.options.scales.y.min = min;
		        myChart.options.scales.y.max = max;
		        myChart.options.plugins.title.text = cur_unit;
		        myChart.update();
			}
		}
		
		let intervaled;
		let cur_unit_index = 1;
		
		function updataChartData(cur_unit, rate_date_list, ttb_list, tts_list, max, min) {
			intervaled = setInterval(function() {
				if( cur_unit_index == cur_unit.length){
					cur_unit_index = 0;
				}
				console.log("이건 : "+cur_unit_index);
				console.log("이건 2 : "+cur_unit.length );
				
		       show_chart(cur_unit[cur_unit_index], rate_date_list[cur_unit_index], ttb_list[cur_unit_index], tts_list[cur_unit_index], max[cur_unit_index], min[cur_unit_index]);
				cur_unit_index++;
			}, 4000);
		}  
	 
		function send(accountnumber, user_id) {
			location.href = "account_info.do?account_number="+accountnumber + "&user_id="+user_id;
		}
		
		window.onload = function () {
			let account_box = document.getElementById("account_box");
			
			let user_id = "${user_id}"; 
			if(user_id == 'null' || user_id ==''){
				account_box.style.display ="none";
			}else{
				account_box.style.display ="block";
			}
		}
	
	</script>

	  
	</head>



	<body>
		<div id="container">

			
			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
			
				<h2 class="seeMyid">
					<c:if test="${ empty user_id }">
						비회원입니다.
					</c:if>
				
					<c:if test="${not empty user_id }">
						${user_id} 님
					</c:if>
				
				</h2>
		
			<div class="account_box" id="account_box">
				
				<h2 class="seeMyaccount">내 계좌 보기</h2>
				<div id="account_container" class="mySwiper">
					<div id="account_slide" class="swiper-wrapper" >
							<c:forEach var="vo" items="${account_list}" >
								<div class="bankbook_body swiper-slide" onclick="send('${vo.account_number}', '${user_id}');">
									<div class="nowmoney_info">
									${vo.now_money }
									</div>
									<div class="account_number_info">
									${vo.account_number}
									</div>
									<div class="bankname_info">
									${vo.bank_name }
									</div>
									
									<div class="bankbook_front" style="background: ${vo.account_color}"></div>
									<div class="bankbook_line"></div>
									<div class="bankbook_page1"></div>
									<div class="bankbook_page2"></div>
									<div class="bankbook_end" style="background: ${vo.account_color}"></div>
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