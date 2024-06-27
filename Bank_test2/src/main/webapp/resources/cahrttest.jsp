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
	/*  document.addEventListener("DOMContentLoaded", function() {
	        fetch('/cart_view.do')
	            .then(response => {
	                if (!response.ok) {
	                    throw new Error('Network response was not ok');
	                }
	                return response.json();
	            })
	            .then(data => {
	                show_chart(data); 
	            })
	            .catch(error => {
	                console.error('There was a problem with the fetch operation:', error);
	            });
	
	 }); */
	function show_chart(data) {
	    // 캔버스 요소 가져오기
	    var ctx = document.getElementById('myChart').getContext('2d');

	    // 차트 생성
	    var myChart = new Chart(ctx, {
	        type: 'line', // 차트 유형 (bar, line, pie, 등)
	        data: {
	            labels: data.map(item => item.date),
	            datasets: [{
	                label: '# of Votes',
	                data: data.map(item => item.TTB),
	                borderColor:[
	                    'rgba(49, 140, 114, 1)'
	                ],
	                borderWidth: 3
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
	<canvas id="myChart" width="400" height="400"></canvas>
	</div>
	</body>
</html>