<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	
		<!-- Ajax사용을 위한 js파일 -->
		<script src="/bank/resources/js/httpRequest.js"></script>
		
	
	<style>
		.chart_container{width: 500px;
						height: 500px;
						border: 1px solid;}
	
	</style>
	
	<script>
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
	                    beginAtZero: true
	                }
	            }
	        }
	    });
	}
	
</script>
	
	</head>
	
	<body>
	<div class="chart_container">
	<canvas id="myChart" width="600" height="400"></canvas>
	</div>
	</body>
</html>