<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- header 용 script와 css -->
<script src="/bank/resources/js/bank_header_js.js"></script>

<!-- chart.js 설정 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>

<script>
		 // 그래프 ---------------------------------------------------
		let cur_unit_select;
		
		// 전역 변수로 myChart 정의
		let myChart;  
		
		// json 데이터 가공 함수
		document.addEventListener("DOMContentLoaded", function() {
				// fetch는 ajax처럼 비동기 행위며 json 형태의 데이터를 받아올 때 주로 사용한다.
				// api 경로 연결처럼 해당 mapping 주소에 연결해서 데이터를 받아오는거랑 비슷한 느낌
				// 즉, chart_view.do 에서 반환하는 데이터를 가져온다.
				let period = document.getElementById("period_select").value;
				let cur_unit_selected = document.getElementById("cur_unit_selected").value;
				call_fetch(period, cur_unit_selected);
		     
		 }); 
		
		function call_fetch(period, cur_unit_select) {
			  
	        fetch("list.do?period=" + period + "&cur_unit_select="+cur_unit_select) 
	        	// 가져온 데이터를 json 객체로 반환
	            .then(response => {
	            	console.log(response);
	                if (!response.ok) { // ==> xhr.readyState == 4 && xhr.status == 200
	                    throw new Error('Network response was not ok');
	                }
	                return response.json();
	            })
	            // json 객체로 반환한 데이터를 각 리스트에 담는다.
	            .then(data => {
	            	console.log(data);
		        	
		        	// cur_unit과 max, min은 바로 뽑아낼 수 있다.
	                let cur_unit = []; 
	                let max = [];
	                let min = [];

					// ttb, tts, rate_date은 rateVO_data에 각 리스트 하나하나에 들어있는 데이터기 때문에 내부에서 forEach를 사용해 한번 더 뽑아줘야 한다.
	                let ttb_list = [];
	                let tts_list = [];
	                let rate_date_list = [];
	               
	                // data.forEach( data_info => ) 이건 for문과 비슷하다. data를 for문을 돌리는데, 해당 data명을 data_info로 명명해주는 것과 비슷하다.
	                // for(String data+info : data) 같은 느낌
	                data.forEach(day_map_list =>{
		                let rate_date = [];
		                let ttb = [];
		                let tts = [];
						
	            	    cur_unit.push(day_map_list.cur_unit);
		                max.push(parseFloat(day_map_list.max_data));
		            	min.push(parseFloat(day_map_list.min_data));
	            	   
	            	   	day_map_list.rateVO_data.forEach( rateVO=> {
		            		ttb.push(parseFloat(rateVO.ttb.replace(',', ''))); // 쉼표 제거 후 숫자로 변환
	                        tts.push(parseFloat(rateVO.tts.replace(',', ''))); // 쉼표 제거 후 숫자로 변환
		                   	rate_date.push(rateVO.rate_date);
	            	    });
	            	   
	            	   ttb_list.push(ttb); 
	                   tts_list.push(tts);
	                   rate_date_list.push(rate_date)
	               });
	                
	               // 차트 그리기 함수 호출
	               show_chart(cur_unit[0], rate_date_list[0], ttb_list[0], tts_list[0], max[0], min[0]);
	               // 특정 시간마다 차트 업데이트 해주는 함수 호출
	               
	               if(cur_unit.length > 1){
		               updataChartData(cur_unit, rate_date_list, ttb_list, tts_list, max, min);
	               }
	            })
	            // 에러 발생 시 호출
	            .catch(error => {
	                console.error('There was a problem with the fetch operation:', error);
	            });
		}
		
		
		// 그래프 그리는 함수
		function show_chart(cur_unit, rate_date, ttb, tts, max , min) {
		    // 캔버스 요소 가져오기
		    var ctx = document.getElementById('myChart').getContext('2d');
						
		    // 차트 객체가 있을 경우
		    if (!myChart) {
		    // 차트 생성
		    myChart = new Chart(ctx, {
		        type: 'line', // 차트 유형 (bar, line, pie, 등)
		        data: {
		            labels: rate_date, // 가로(행) 데이터
		            datasets: [{
		                label: 'ttb', 
		                data: ttb, // 세로(열) 데이터
		                pointRadius: 1.5, // 각 데이터 포인트의 동그라미 반지름 설정
		                backgroundColor: 'rgba(49, 140, 114, 0.3)',
		                borderColor:'rgba(49, 140, 114, 1)',
		                fill: true, // 아래 영역을 채우기 활성화
		                borderWidth: 2
		            },{
		                label: 'tts',
		                data: tts, // 세로(열) 데이터
		                pointRadius: 1.5, // 각 데이터 포인트의 동그라미 반지름 설정
		                backgroundColor: 'rgba(219, 214, 53, 0.3)',
		                borderColor:'rgba(219, 214, 53, 1)',
		                fill: true, // 아래 영역을 채우기 활성화
		                borderWidth: 2
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
		                    beginAtZero: false, // 세로 간격을 0부터 시작하지 않는다.
		                    min: min,  // y축 최소값 설정
		                    max: max  // y축 최대값 설정
		                }
		                
		            },
		            plugins: {
		                title: {
		                    display: true, // 제목 표시 여부
		                    text: cur_unit  // cur_unit 명
		                } 
		            }
		        }
		    });
		
			}else { // 차트 객체가 있는 경우, 데이터 업데이트
		        myChart.data.labels = rate_date;
		        myChart.data.datasets[0].data = ttb;
		        myChart.data.datasets[1].data = tts;
		        myChart.options.scales.y.min = min;
		        myChart.options.scales.y.max = max;
		        myChart.options.plugins.title.text = cur_unit;
		        myChart.update();
			}
		}
		
		// 함수 호출 객체 선언
		let intervaled;
		// 데이터 변화에 따른 index 선언
		let cur_unit_index = 1;
		
		// 그래프 업데이트 함수
		function updataChartData(cur_unit, rate_date_list, ttb_list, tts_list, max, min) {
			intervaled = setInterval(function() {
				// 보여지는 그래프 데이터가 마지막 index 데이터가 될 경우 index을 0으로 만들어서 무한으로 돌도록 한다.
				if( cur_unit_index == cur_unit.length){
					cur_unit_index = 0;
				}
				
			   // 다음 데이터를 그래프에 업데이트 해준다.
		       show_chart(cur_unit[cur_unit_index], rate_date_list[cur_unit_index], ttb_list[cur_unit_index], tts_list[cur_unit_index], max[cur_unit_index], min[cur_unit_index]);
				cur_unit_index++;
			}, 4000);
		}   
		 
		function rate_search(rate_search_data) {
			document.getElementById("period_select").value = rate_search_data;
			let cur_unit_selected = document.getElementById("cur_unit_selected").value;
			console.log("아아아아아ㅏㅇ악");
			console.log(cur_unit_selected);
			clearInterval(intervaled); // setInterval 작업 멈추기
			
			call_fetch(rate_search_data, cur_unit_selected);
			
		}
		
		window.onload = function () {
			let cur_unit_selected = document.getElementById("cur_unit_selected");
			let cur_unit = ["CHF", "CNH", "DKK", "EUR", "GBP", "HKD", "IDR(100)", "JPY(100)", "KWD", "MYR", "NOK",
								"NZD", "SAR", "SEK", "SGD", "THB", "USD" ];
			
			// 색상 선택 div에 해당 색상과 클릭시 color_choic() 함수에 보내질 색상 데이터를 동적으로 기입한다.
			for(let i = 0; i < cur_unit.length; i++){
				let cur_unit_mini = document.createElement("option");
				cur_unit_mini.className = "cur_unit_mini";
				cur_unit_mini.value = cur_unit[i];
				cur_unit_mini.innerHTML = cur_unit[i];
				cur_unit_selected.appendChild(cur_unit_mini);
			}//for------------
		}
		
		
		function cur_unit_selected() {
			clearInterval(intervaled); // setInterval 작업 멈추기
			let cur_unit_selected = document.getElementById("cur_unit_selected").value;
			let period = document.getElementById("period_select").value;
			let cur_unit = [ "CHF", "CNH", "DKK", "EUR", "GBP", "HKD", "IDR(100)", "JPY(100)", "KWD", "MYR", "NOK",
								"NZD", "SAR", "SEK", "SGD", "THB", "USD", "all" ];
			cur_unit_select = cur_unit_selected;
			
			for(let i = 0; i < cur_unit.length; i++){
				if(cur_unit[i] == cur_unit_selected){
					call_fetch(period, cur_unit_select);
					break;
				}
			}
			
		}
		
	</script>

	<style>
		#rate_search_period{
							width: 800px;
							height: 40px;
							display: flex;
							margin: 30px auto;
							}
		#rate_search_period div{
								width: 60px;
								height: 20px;
								margin-left: 30px;
								font-size: 15px;
								text-align: center;
								font-weight: bold;
								padding: 5px;
								border-radius: 10px;
								}						
		#rate_search_period div:hover{background:#dde0ed;
										}
										
		#rate_search_period div:active {background:#dde0ed;
									}								
		.rate_box{vertical-align: middle;
				margin-left: 100px;}
		
		#rate_body{display: flex; 
			margin: 30px auto;
			width: 1500px;
		}
	</style>
</head>

<body>
	<div id="header">
		<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	</div>


	환율조회
	<div id="rate_body">
		<div id="rate_calculate" style="width: 400px; height: 600px; border: 1px solid;">
			<!-- <select id="cur_unit_selected" onchange="cur_unit_selected();">
					<option value="all">전체</option>
			</select> -->
			<input type ="text" name ="goMoney">
			<br>
			<!-- <select id="cur_unit_selected" onchange="cur_unit_selected();">
					<option value="all">전체</option>
			</select> -->
			<input type ="text" name ="leaveMoney">
		</div>
		
		<div class="rate_box">
			<div id="rate_search_period" >
				<div onclick="rate_search('1개월')">1개월</div>
				<div onclick="rate_search('3개월')">3개월</div>
				<div onclick="rate_search('6개월')">6개월</div>
				<div onclick="rate_search('1년')">1년</div>
			
				<select id="cur_unit_selected" onchange="cur_unit_selected();">
					<option value="all">전체</option>
				</select>
			</div>
			
			
			<div id="chart_div" style="width: 1000px; height: 600px; margin: 30px auto;" >
				<canvas id="myChart"></canvas>
			</div>
			
			<input type="hidden" id="period_select" value="1개월">
		
		</div>

	</div>
</body>
</html>