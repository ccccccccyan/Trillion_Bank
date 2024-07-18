<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<!-- header 용 script와 css -->
<script src="/bank/resources/js/bank_header_js.js"></script>

<!-- Ajax사용을 위한 js파일 -->
<script src="/bank/resources/js/httpRequest.js"></script>
	

<!-- chart.js 설정 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>

<script>
		 // 그래프 ---------------------------------------------------
		let cur_nm_select;
		
		// 전역 변수로 myChart 정의
		let myChart;  
		
		// 할당 변수들
		let ttb_option = [];
		let tts_option = [];
		let ttb_select;
		let tts_select;
		let cur_unit_select = [];
		
		// json 데이터 가공 함수
		document.addEventListener("DOMContentLoaded", function() {
				// fetch는 ajax처럼 비동기 행위며 json 형태의 데이터를 받아올 때 주로 사용한다.
				// api 경로 연결처럼 해당 mapping 주소에 연결해서 데이터를 받아오는거랑 비슷한 느낌
				// 즉, chart_view.do 에서 반환하는 데이터를 가져온다.
				let period = document.getElementById("period_select").value;
				let cur_nm_selected = document.getElementById("cur_nm_selected").value;
				call_fetch(period, cur_nm_selected);
				
		 }); 
		
		function rate_ttb_tts_data() {
			cur_unit_select = [ "인도네시아 루피아", "일본 옌", "쿠웨이트 디나르", "말레이지아 링기트", "노르웨이 크로네", "뉴질랜드 달러", "사우디 리얄", "스웨덴 크로나", "싱가포르 달러",
				"태국 바트", "미국 달러", "아랍에미리트 디르함", "호주 달러", "바레인 디나르", "브루나이 달러", "캐나다 달러", "스위스 프랑", "위안화", "덴마아크 크로네", "유로", "영국 파운드", "홍콩 달러" , "한국 원"];
			
			console.log("로그");
			console.log(ttb_option + " / " + tts_option);
			
			let	cur_nm_selected = document.getElementById("cur_nm_selected");
			let rate_cal_select_before = document.getElementById("rate_cal_select_before");
			let rate_cal_select_after = document.getElementById("rate_cal_select_after");
			let exchange_money_type = document.getElementById("exchange_money_type");
			
			// 색상 선택 div에 해당 색상과 클릭시 color_choic() 함수에 보내질 색상 데이터를 동적으로 기입한다.
			for(let i = 0; i < cur_unit_select.length; i++){
				if(i != cur_unit_select.length-1){
					let cur_nm_mini = document.createElement("option");
					cur_nm_mini.value = cur_unit_select[i];
					cur_nm_mini.innerHTML = cur_unit_select[i];
					cur_nm_selected.appendChild(cur_nm_mini);
				}
				
				let rate_cal_before_mini = document.createElement("option");
				rate_cal_before_mini.value = tts_option[i]; // 보내실때
				rate_cal_before_mini.innerHTML = cur_unit_select[i];
				rate_cal_before_mini.className = "cur_unit_select"+i;
				rate_cal_select_before.appendChild(rate_cal_before_mini);
				
				let rate_cal_after_mini = document.createElement("option");
				rate_cal_after_mini.value = tts_option[i]; // 받으실때
				rate_cal_after_mini.innerHTML = cur_unit_select[i];
				rate_cal_after_mini.className = "cur_unit_select"+i;
				rate_cal_select_after.appendChild(rate_cal_after_mini);
				
				if(i != cur_unit_select.length -1){
					let exchange_money_type_mini = document.createElement("option");
					exchange_money_type_mini.value = tts_option[i]; // 받으실때
					exchange_money_type_mini.innerHTML = cur_unit_select[i];
					exchange_money_type.appendChild(exchange_money_type_mini);
				}
			}//for------------
		}
		
		
		function call_fetch(period, cur_nm_select) {
			  
	        fetch("list.do?period=" + period + "&cur_nm_select="+cur_nm_select) 
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
		        	
		        	// cur_nm과 max, min은 바로 뽑아낼 수 있다.
	                let cur_nm = []; 
	                let max = [];
	                let min = [];

					// ttb, tts, rate_date은 rateVO_data에 각 리스트 하나하나에 들어있는 데이터기 때문에 내부에서 forEach를 사용해 한번 더 뽑아줘야 한다.
	                let ttb_list = [];
	                let tts_list = [];
	                let rate_date_list = [];

	                // 환율 데이터 초기화
	                ttb_option = [];
	                tts_option = [];
	                
	                // data.forEach( data_info => ) 이건 for문과 비슷하다. data를 for문을 돌리는데, 해당 data명을 data_info로 명명해주는 것과 비슷하다.
	                // for(String data+info : data) 같은 느낌
	                data.forEach(day_map_list =>{
		                let rate_date = [];
		                let ttb = [];
		                let tts = [];
						
	            	    cur_nm.push(day_map_list.cur_nm);
		                max.push(parseFloat(day_map_list.max_data));
		            	min.push(parseFloat(day_map_list.min_data));
		            	
		                ttb_option.push(day_map_list.rateVO_data[day_map_list.rateVO_data.length -1].ttb.replace(',', ''));
		                tts_option.push(day_map_list.rateVO_data[day_map_list.rateVO_data.length -1].tts.replace(',', ''));
		            	
	            	   	day_map_list.rateVO_data.forEach( rateVO=> {
		            		ttb.push(parseFloat(rateVO.ttb.replace(',', ''))); // 쉼표 제거 후 숫자로 변환
	                        tts.push(parseFloat(rateVO.tts.replace(',', ''))); // 쉼표 제거 후 숫자로 변환
		                   	rate_date.push(rateVO.rate_date);
	            	   	});
	            	   
	            	   ttb_list.push(ttb); 
	                   tts_list.push(tts);
	                   rate_date_list.push(rate_date)
	               });
	               
	                ttb_option.push(0);
	                tts_option.push(0);
		            	
	                console.log(" 값 들어옴");
	                console.log(ttb_option + " / " + tts_option);
	                
	                
	               // 차트 그리기 함수 호출
	               show_chart(cur_nm[0], rate_date_list[0], ttb_list[0], tts_list[0], max[0], min[0]);
	               // 특정 시간마다 차트 업데이트 해주는 함수 호출
	               
	               if(cur_nm.length > 1){
		               rate_ttb_tts_data();
		               updataChartData(cur_nm, rate_date_list, ttb_list, tts_list, max, min);
	               }
	            })
	            // 에러 발생 시 호출
	            .catch(error => {
	                console.error('There was a problem with the fetch operation:', error);
	            });
		}
		
		
		// 그래프 그리는 함수
		function show_chart(cur_nm, rate_date, ttb, tts, max , min) {
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
		                label: 'ttb ( 받으실 때 )', 
		                data: ttb, // 세로(열) 데이터
		                pointRadius: 1.5, // 각 데이터 포인트의 동그라미 반지름 설정
		                backgroundColor: 'rgba(49, 140, 114, 0.3)',
		                borderColor:'rgba(49, 140, 114, 1)',
		                fill: true, // 아래 영역을 채우기 활성화
		                borderWidth: 2
		            },{
		                label: 'tts ( 보내실 때 )',
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
		                    text: cur_nm  // cur_nm 명
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
		        myChart.options.plugins.title.text = cur_nm;
		        myChart.update();
			}
		}
		
		// 함수 호출 객체 선언
		let intervaled;
		// 데이터 변화에 따른 index 선언
		let cur_nm_index = 1;
		
		// 그래프 업데이트 함수
		function updataChartData(cur_nm, rate_date_list, ttb_list, tts_list, max, min) {
			intervaled = setInterval(function() {
				// 보여지는 그래프 데이터가 마지막 index 데이터가 될 경우 index을 0으로 만들어서 무한으로 돌도록 한다.
				if( cur_nm_index == cur_nm.length){
					cur_nm_index = 0;
				}
				
			   // 다음 데이터를 그래프에 업데이트 해준다.
		       show_chart(cur_nm[cur_nm_index], rate_date_list[cur_nm_index], ttb_list[cur_nm_index], tts_list[cur_nm_index], max[cur_nm_index], min[cur_nm_index]);
				cur_nm_index++;
			}, 4000);
		}   
		 
		function rate_search(rate_search_data) {
			
			let month_data = ["1개월", "3개월", "6개월", "1년"];
			let month = ["onemonth", "threemonth", "sixmonth", "oneyear"];
			
			for(let i = 0; i < month.length; i++){
				
				if(rate_search_data == month_data[i]){
					document.getElementById(month[i]).style.background = "#dde0ed";
				}else{
					document.getElementById(month[i]).style.background = "none";
				}
			}
			
			document.getElementById("period_select").value = rate_search_data;
			let cur_nm_selected = document.getElementById("cur_nm_selected").value;
			clearInterval(intervaled); // setInterval 작업 멈추기
			
			call_fetch(rate_search_data, cur_nm_selected);
			
		}
		
		
		function cur_nm_selectedFn() {
			clearInterval(intervaled); // setInterval 작업 멈추기
			let cur_nm_selected = document.getElementById("cur_nm_selected").value;
			let period = document.getElementById("period_select").value;
			cur_nm_select = cur_nm_selected;
			
			for(let i = 0; i < cur_unit_select.length; i++){
				if(cur_unit_select[i] == cur_nm_selected){
					console.log(cur_unit_select[i] +" == "+ cur_nm_selected);
					call_fetch(period, cur_nm_select);
					break;
				}
			}
			
		}
		
		function rate_before_change(f) {
			f.goMoney.value = "";
			f.leaveMoney.value = "";
			
			//document.getElementById("rate_cal_select_before_msg").innerHTML = document.getElementById("rate_cal_select_before").value;
		}
		
		function rate_after_change(f) {
			f.goMoney.value = "";
			f.leaveMoney.value = "";

			//document.getElementById("rate_cal_select_after_msg").innerHTML = document.getElementById("rate_cal_select_after").value;
		}
		
		function tts_count(f) {
			let rate_before_value = f.goMoney.value;
			
			let check_value = "no"; //입력한 값이 유효한지 아닌지
			
			// 숫자 여러 개를 허용하는 정규표현식
			let onlynumber = /^[0-9]+$/;
			let rate_before_value_msg = document.getElementById("rate_before_value_msg");
			
			// goMoney input 칸이 비어있을 경우 leaveMoney input 칸의 값을 지우고 함수를 종료
			if (!rate_before_value) {
				f.leaveMoney.value = "";
				rate_before_value_msg.innerHTML = "";
				return;
			}
			
			//환율 계산하기 (1번 input 칸)
			if( !onlynumber.test(rate_before_value) ){
				rate_before_value_msg.innerHTML = "숫자만 입력해주시기 바랍니다.";
				rate_before_value_msg.style.color = "red";
				check_value = "no";
				return;
			}
			
			// 조건에 맞으면 경고 메세지를 지움.
			rate_before_value_msg.innerHTML = "";
			check_value = "yes";
			
			
			let rate_cal_select_before = document.getElementById("rate_cal_select_before");
			let rate_cal_select_after = document.getElementById("rate_cal_select_after");
			
			// let rate_before = tts_option[rate_cal_select_before.selectedIndex] - ttb_option[rate_cal_select_before.selectedIndex];
			// rate_before /= 2;
			// rate_before_value = rate_before_value - rate_before;
			
			rate_before_option = rate_cal_select_before.options[rate_cal_select_before.selectedIndex];
			rate_after_option = rate_cal_select_after.options[rate_cal_select_after.selectedIndex];
			
			if(rate_before_option.innerHTML == rate_after_option.innerHTML){
				f.leaveMoney.value = rate_before_value;

			}else if(rate_before_option.innerHTML == '한국 원' && rate_after_option.innerHTML != '한국 원' && rate_after_option.innerHTML != '인도네시아 루피아' && rate_after_option.innerHTML != '일본 옌' ){
				f.leaveMoney.value = (rate_before_value / rate_cal_select_after.value).toFixed(3);
		
			}else if(rate_before_option.innerHTML == '한국 원' && rate_after_option.innerHTML != '한국 원' && ( rate_after_option.innerHTML == '인도네시아 루피아' || rate_after_option.innerHTML == '일본 옌')){
				f.leaveMoney.value = (rate_before_value / rate_cal_select_after.value * 100).toFixed(3);

			}else if(rate_before_option.innerHTML != '한국 원' && rate_after_option.innerHTML == '한국 원'  && rate_before_option.innerHTML != '인도네시아 루피아' && rate_before_option.innerHTML != '일본 옌'){
				f.leaveMoney.value = (rate_before_value * rate_cal_select_before.value).toFixed(3);

			}else if(rate_before_option.innerHTML != '한국 원' && rate_after_option.innerHTML == '한국 원'  && ( rate_before_option.innerHTML == '인도네시아 루피아' || rate_before_option.innerHTML == '일본 옌')){
				f.leaveMoney.value = (rate_before_value * rate_cal_select_before.value / 100).toFixed(3);

			}else if(rate_before_option.innerHTML == '인도네시아 루피아' || rate_after_option.innerHTML != '인도네시아 루피아' || rate_before_option.innerHTML == '일본 옌' || rate_after_option.innerHTML != '일본 옌'){
				f.leaveMoney.value = ((rate_before_value * rate_cal_select_before.value) / rate_cal_select_after.value / 100).toFixed(3);
			
			}else if(rate_before_option.innerHTML != '인도네시아 루피아' || rate_after_option.innerHTML == '인도네시아 루피아' || rate_before_option.innerHTML != '일본 옌' || rate_after_option.innerHTML == '일본 옌'){
				f.leaveMoney.value = ((rate_before_value * rate_cal_select_before.value) / rate_cal_select_after.value * 100).toFixed(3);
			
			}else{
				f.leaveMoney.value = ((rate_before_value * rate_cal_select_before.value) / rate_cal_select_after.value).toFixed(3);
				
			}
		}
		
		function ttb_count(f) {
			let rate_after_value = f.leaveMoney.value;

			let check_value = "no"; //입력한 값이 유효한지 아닌지
			
			// 숫자 여러 개를 허용하는 정규표현식
			let onlynumber = /^[0-9]+$/; //만약 /^[0-9]$/; 이면 숫자 딱 하나만! 허용한다는 말임.
			let rate_after_value_msg = document.getElementById("rate_after_value_msg");
			
			// goMoney input 칸이 비어있을 경우 leaveMoney input 칸의 값을 지우고 함수를 종료
			if (!rate_after_value) {
				f.goMoney.value = "";
				rate_after_value_msg.innerHTML = "";
				return;
			}
			
			//환율 계산하기 (2번 input 칸)
			if( !onlynumber.test(rate_after_value) ){
				rate_after_value_msg.innerHTML = "숫자만 입력해주시기 바랍니다!!";
				rate_after_value_msg.style.color = "red";
				check_value = "no";
				return;
			}
			
			// 조건에 맞으면 경고 메세지를 지움.
			rate_after_value_msg.innerHTML = "";
			check_value = "yes";
			
			
			let rate_cal_select_before = document.getElementById("rate_cal_select_before");
			let rate_cal_select_after = document.getElementById("rate_cal_select_after");
			
			// let rate_after = tts_option[rate_cal_select_after.selectedIndex] - ttb_option[rate_cal_select_after.selectedIndex];
			// rate_after /= 2;
			// rate_after_value = rate_after_value - rate_after;
			
			rate_before_option = rate_cal_select_before.options[rate_cal_select_before.selectedIndex];
			rate_after_option = rate_cal_select_after.options[rate_cal_select_after.selectedIndex];
			
			if(rate_before_option.innerHTML == rate_after_option.innerHTML ){
				f.goMoney.value = rate_after_value;
				
			}else if(rate_before_option.innerHTML == '한국 원' && rate_after_option.innerHTML != '한국 원'  && rate_after_option.innerHTML != '인도네시아 루피아' && rate_after_option.innerHTML != '일본 옌' ){
				f.goMoney.value = (rate_after_value * rate_cal_select_after.value).toFixed(3);
				
			}else if(rate_before_option.innerHTML == '한국 원' && rate_after_option.innerHTML != '한국 원'  && ( rate_after_option.innerHTML == '인도네시아 루피아' || rate_after_option.innerHTML == '일본 옌') ){
				f.goMoney.value = (rate_after_value * rate_cal_select_after.value / 100 ).toFixed(3);
				
			}else if(rate_before_option.innerHTML != '한국 원' && rate_after_option.innerHTML == '한국 원' && rate_before_option.innerHTML != '인도네시아 루피아' && rate_before_option.innerHTML != '일본 옌'){
				f.goMoney.value = (rate_after_value / rate_cal_select_before.value).toFixed(3);

			}else if(rate_before_option.innerHTML != '한국 원' && rate_after_option.innerHTML == '한국 원' && ( rate_before_option.innerHTML == '인도네시아 루피아' || rate_before_option.innerHTML == '일본 옌')){
				f.goMoney.value = (rate_after_value / rate_cal_select_before.value * 100).toFixed(3);
				
			}else if(rate_before_option.innerHTML == '인도네시아 루피아' || rate_after_option.innerHTML != '인도네시아 루피아' || rate_before_option.innerHTML == '일본 옌' || rate_after_option.innerHTML != '일본 옌'){
				f.goMoney.value = ((rate_after_value * rate_cal_select_after.value) / rate_cal_select_before.value * 100).toFixed(3);
				
			}else if(rate_before_option.innerHTML != '인도네시아 루피아' || rate_after_option.innerHTML == '인도네시아 루피아' || rate_before_option.innerHTML != '일본 옌' || rate_after_option.innerHTML == '일본 옌'){
				f.goMoney.value = ((rate_after_value * rate_cal_select_after.value) / rate_cal_select_before.value / 100).toFixed(3); 
				
			}else{
				f.goMoney.value = ((rate_after_value * rate_cal_select_after.value) / rate_cal_select_before.value).toFixed(3); 
			}
			
		}
		
		function ttb_tts_change(f) {
			let ttb_tts_select = document.getElementById("ttb_tts_select").value;
			
			let goMoney = f.goMoney.value;
			let leaveMoney = f.leaveMoney.value;
			
			// 색상 선택 div에 해당 색상과 클릭시 color_choic() 함수에 보내질 색상 데이터를 동적으로 기입한다.
			for(let i = 0; i < cur_unit_select.length; i++){
					let rate_cal_select = document.querySelectorAll(".cur_unit_select" + i);
			
				rate_cal_select.forEach((option, j) => {
			        if (ttb_tts_select == 'ttb') {
			            option.value = ttb_option[i];
			        } else {
			            option.value = tts_option[i];
			            }
			     });
			}//for------------
			rate_before_change(f);
			rate_after_change(f);
			
			f.goMoney.value = goMoney;
			tts_count(f)
		}
		
		function choice_user_account(f) {
				let user_account_warn_msg = document.getElementById("user_account_warn_msg");
				let user_account_list = document.getElementById("user_account_list").value;
				let exchange_choice_account = document.getElementById("exchange_choice_account");
				let exchange_money_button = document.getElementById("exchange_money_button");
			
			if( user_account_list == 'no'){	
				user_account_warn_msg.innerHTML = "계좌를 선택해주세요";
				user_account_warn_msg.style.color = "red";
				exchange_money_button.disabled = true;
				exchange_choice_account.value = "";
				
			}else if(user_account_list == 5){
				user_account_warn_msg.innerHTML = "해당 계좌는 사용이 불가합니다.";
				user_account_warn_msg.style.color = "red";
				exchange_money_button.disabled = true;
				exchange_choice_account.value = "";
			}else{
				user_account_warn_msg.innerHTML = "";
				exchange_money_button.disabled = false;
				exchange_choice_account.value = user_account_list;
			}
			
			f.exchange_tomoney.value = "";
			f.exchange_frommoney.value = "";
		}
		
		//환전하실 금액
		function exchange_formmoney_input(f) {
			let exchange_money_type = document.getElementById("exchange_money_type");
			let exchange_type_option = exchange_money_type.options[exchange_money_type.selectedIndex];
			
			let exchange_frommoney = f.exchange_frommoney.value;
			let onlynumber = /^[0-9]+$/;
			let exchange_frommoney_msg = document.getElementById("exchange_frommoney_msg");
			
			// 입력 값이 비어있을 경우
			if (!exchange_frommoney) {
				f.exchange_tomoney.value = "";
				exchange_frommoney_msg.innerHTML = "";
				return;
			}
			
			// 숫자만 입력하도록 유효성 검사
			if (!onlynumber.test(exchange_frommoney)) {
				exchange_frommoney_msg.innerHTML = "숫자만 입력해주세요.";
				exchange_frommoney_msg.style.color = "red";
				return;
			}
			
			exchange_frommoney_msg.innerHTML = "";
			
			// 예외 환전 계산
			if(exchange_type_option.innerHTML == '인도네시아 루피아' || exchange_type_option.innerHTML == '일본 옌' ){
				f.exchange_tomoney.value = Math.round((f.exchange_frommoney.value / exchange_type_option.value * 100).toFixed(3));

			}else{
				f.exchange_tomoney.value = Math.round((f.exchange_frommoney.value / exchange_type_option.value).toFixed(3));
			}
			
		}
		
		//환전받으실 금액
		function exchange_tomoney_input(f) {
			let exchange_money_type = document.getElementById("exchange_money_type");
			let exchange_type_option = exchange_money_type.options[exchange_money_type.selectedIndex];
			
			let exchange_tomoney = f.exchange_tomoney.value;
			let onlynumber = /^[0-9]+$/;
			let exchange_tomoney_msg = document.getElementById("exchange_tomoney_msg");
			
			// 입력 값이 비어있을 경우
			if (!exchange_tomoney) {
				f.exchange_frommoney.value = "";
				exchange_tomoney_msg.innerHTML = "";
				return;
			}
			
			// 숫자만 입력하도록 유효성 검사
			if (!onlynumber.test(exchange_tomoney)) {
				exchange_tomoney_msg.innerHTML = "숫자만 입력해주세요.";
				exchange_tomoney_msg.style.color = "red";
				return;
			}
			
			exchange_frommoney_msg.innerHTML = "";
			
			// 예외 환전 계산
			if(exchange_type_option.innerHTML == '인도네시아 루피아' || exchange_type_option.innerHTML == '일본 옌' ){
				f.exchange_frommoney.value = Math.round((f.exchange_tomoney.value * exchange_type_option.value / 100).toFixed(3));

			}else{
				f.exchange_frommoney.value = Math.round((f.exchange_tomoney.value * exchange_type_option.value).toFixed(3));
			}
			
		}
		
		function exchange_money_reset(f) {
			let exchange_money_type = document.getElementById("exchange_money_type");
			let exchange_type_option = exchange_money_type.options[exchange_money_type.selectedIndex];
			console.log("exchange_type_option1111" + exchange_type_option.innerHTML);
			f.exchange_choice_type.value = exchange_type_option.innerHTML;
			f.exchange_tomoney.value = "";
			f.exchange_frommoney.value = "";
		}
		
		function exchange_account(f) {
			
			let param = "account_pwd="+f.user_check_account_pwd.value + "&account_number="+f.exchange_choice_account.value;
			let url ="del_accountpwd_chk.do";
			
			sendRequest(url, param, function() {
				exchange_accountFn( f );
	           }, "post");
		}
		
		function exchange_accountFn( f ) {
			if( xhr.readyState == 4 && xhr.status == 200 ){
				console.log(f.exchange_choice_type.value);
				//"[{'result':'yes'}]"
				let data = xhr.responseText;
				alert(data);
				
				let json = ( new Function('return '+data) )();
				
				if( json[0].result == 'clear' && exchange_to_kr == 'no' ){
					
					f.action = "exchange_account_insert.do";
					f.method = "post";
					f.submit();
					
				}else if( json[0].result == 'clear' && exchange_to_kr == 'yes' ){
				
					let swap_box = f.exchange_tomoney.value;
					f.exchange_tomoney.value = f.exchange_frommoney.value;
					f.exchange_frommoney.value = swap_box;
					
					f.action = "exchange_back_money.do";
					f.method = "post";
					f.submit();

				}else{
					alert("진행 실패");
				}
				
			}
		}
		

		
		let exchange_to_kr = "no";
		function back_exchange() {
			exchange_to_kr = "yes";
			
			document.getElementById("exchange_user_type_icon").src = "/bank/resources/img/외화환전.png";
			document.getElementById("exchange_user_type_icon").onclick =  function() {
		        location.href = 'rate_inquiry.do'; 
		    };
		    
			document.getElementById("exchange_money_header").innerHTML = "외화 환전하기";
			document.getElementById("exchange_money_type").style.zIndex = "-1";
			let user_exchange_list = document.getElementById("user_exchange_list").style.display = "block";
		
			document.getElementById("exchange_frommoney").style.left = "225px";
			document.getElementById("exchange_frommoney").placeholder = "환전받으실 금액";
			document.getElementById("exchange_tomoney").style.left = "30px";
			document.getElementById("exchange_tomoney").placeholder = "환전하실 금액";
			
		}
		
		function choice_user_exchange_type(f) {
			let user_exchange_list = document.getElementById("user_exchange_list");
			let exchange_money_type = document.getElementById("exchange_money_type");
			
			let selectedType = user_exchange_list.options[user_exchange_list.selectedIndex].innerHTML; 
			
			for(let i = 0; i < exchange_money_type.options.length; i++){
				if(exchange_money_type.options[i].innerHTML == selectedType){
					exchange_money_type.value = exchange_money_type.options[i].value;
					exchange_money_reset(f);
					break;
				}
			}
			
		}
		
		// user_check_account_pwd 유저의 계좌 비밀번호 체크 oninput
		function UserChkAcntPwd(f){
			let userPwd = f.user_check_account_pwd.value;

			let check_value = "no"; //입력한 값이 유효한지 아닌지
			
			// 숫자 여러 개를 허용하는 정규표현식
			let onlynumber = /^[0-9]+$/; //만약 /^[0-9]$/; 이면 숫자 딱 하나만! 허용한다는 말임.
			let userPwd_msg = document.getElementById("userPwd_msg");
			
			if( !onlynumber.test(userPwd) ){
				userPwd_msg.innerHTML = "숫자만 입력!!!";
				userPwd_msg.style.color = "red";
				check_value = "no";
				return;
			}
			
			// 조건에 맞으면 경고 메세지를 지움.
			userPwd_msg.innerHTML = "";
			check_value = "yes";
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
								cursor: pointer;
								}						
		#rate_search_period div:hover{background:#dde0ed;
										}
																	
		.rate_box{vertical-align: middle;
				margin-left: 100px;}
		
		#rate_body{display: flex; 
			margin: 30px auto;
			width: 1500px;
		}
		
		.rate_cal_box{margin-left: 40px;
					margin-top: 40px;}
		
		.rate_cal{width: 300px;
					height: 25px;}
					
		.rate_cal_select{width: 150px;
						height: 27px;
						margin-bottom: 5px;}
						
		.equals_icon{
					width: 30px;
					height: 10px;
					color: gray;
					font-size: 30px;
					margin: 0 0 20px 110px;
		}
		.rate_select_header{display: flex;
							position: absolute;
							top: 160px; }	
							
		#rate_calculate{width: 400px;
						 height: 655px;
						 border: 1px solid;}		
						 
		#ttb_tts_select{margin-left: 75px;
					 margin-top:20px;
					 height: 30px;}
					 
		#exchange_form{position: absolute;
					 margin-top: 20px;
					 border: 1px solid;
					 width: 397px;
					 height: 155px; 
					 background: white;}
		
		#exchange_money_header{margin: 10px 30px 10px;
							   width: 200px;}	
		
		#exchange_user_type_icon{width: 20px; 
								height: 20px; 
								position: absolute; 
								top: 13px; 
								left: 5px; 
								cursor: pointer;}
		
		#user_account_list{position: absolute; 
							top: 15px; 
							width: 220px; 
							margin-left: 158px; 
							border: 1px solid; 
							background: white; 
							z-index: 400;}	
		
		#user_account_warn_msg{position: absolute; 
								top: 33px; 
								width: 310px; 
								margin-left: 138px; 
								font-size: 13px;}	
								
		#user_exchange_list{position: absolute; 
							top: 55px; 
							width: 160px; 
							margin-left: 10px; 
							border: 1px solid; 
							background: white; 
							z-index: 400; 
							display: none}
		
		#exchange_frommoney{width: 123px; 
							position: absolute; 
							top: 77px; 
							left: 30px;}
																										   		 				 
		#exchange_tomoney{width: 123px; 
						 position: absolute; 
						 top: 77px; 
						 left: 225px;}	
		
		#exchange_money_type{position: absolute; 
							top: 55px; 
							right: 34px;}	
		
		#user_check_account_pwd{width: 90px; 
								position: absolute; 
								left: 150px; 
								top: 113px;}	
															 																		   		 				 
		#exchange_money_button{position: absolute; 
								top: 110px; 
								right: 50px; 
								width: 90px; 
								height: 25px;}
								
		#rate_account_list{position: absolute; 
							top: 600px;}			
		
		#my_exchange_type_list{height: auto; overflow: scroll; width: 396px; height: 170px;}	
		
		.my_exchange_type_mini{border: 1px solid; width: 240px; height: 60px; margin-left: 15px; margin-bottom: 10px; position: relative;}							
	</style>
</head>

<body>
	<div id="header">
		<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	</div>
	
	<div id="exchange_back_all"></div>

	<div id="rate_body">
		<div id="rate_calculate" >
			<form>
			<div class="rate_cal_box">
			
			
				<div class="rate_select_header">
					<h3>환율 계산하기</h3> 
					<select id="ttb_tts_select" onchange="ttb_tts_change(this.form);" >
						<option value="tts">살때(보내실때)</option>
						<option value="ttb">팔때(받으실때)</option>
					</select>
				</div>
				
				<select id="rate_cal_select_before" class="rate_cal_select" onchange="rate_before_change(this.form);"></select> 
				<input type ="text" name ="goMoney" id="rate_cal_before" class="rate_cal" oninput="tts_count(this.form);"> <br> 
				<!-- <span id="rate_cal_select_before_msg" style="color: gray;">인도네시아 루피아</span> <br> -->
				<span id="rate_before_value_msg"></span> 
				<h1 class="equals_icon">=</h1>
				
				<br>
				<select id="rate_cal_select_after" class="rate_cal_select" onchange="rate_after_change(this.form);"></select> 
				<input type ="text" name ="leaveMoney" id="rate_cal_after" class="rate_cal" oninput="ttb_count(this.form);"> <br> 
				<!-- <span id="rate_cal_select_after_msg" style="color: gray;">인도네시아 루피아</span> <br> -->
				<span id="rate_after_value_msg"></span>
			</div>
			</form>
			

			<c:if test="${ not empty user_id && empty manager }">                     
			<form id="exchange_form" >
				<img src="/bank/resources/img/원화환전.png" id="exchange_user_type_icon" onclick="back_exchange();" >
				<h3 id="exchange_money_header">원화 환전하기</h3>
				
				
				<select id="user_account_list" onchange="choice_user_account(this.form)" >
					<option value="no"> 계좌목록</option>
					<c:forEach var="vo" items="${account_list}">
							<c:if test="${ vo.account_lockcnt ne 5 }">
								<option value="${vo.account_number}">${vo.account_number} (${vo.bank_name}) 
								</option>
							</c:if>						
							<c:if test="${ vo.account_lockcnt eq 5 }">
								<option value="${vo.account_lockcnt}">${vo.account_number} (${vo.bank_name}) 
									 | 사용불가 
								</option>
							</c:if>						
					</c:forEach>
				</select>
				<span id="user_account_warn_msg" ></span>
				
				<select id="user_exchange_list" onchange="choice_user_exchange_type(this.form)" >
					<option value="no"> 외화목록</option>
					<c:forEach var="vo" items="${exchange_list}">
								<option value="${vo.exchange_money}">${vo.foregin_type}</option>
					</c:forEach>
				</select>
				
				<input name="exchange_frommoney" id="exchange_frommoney" placeholder="환전하실 금액" oninput="exchange_formmoney_input(this.form);">
				<span id="exchange_frommoney_msg" style="font-size: 13px; position: relative; left: 30px;"></span>
				<img src="/bank/resources/img/exchange.png" style="width: 25px; height: 25px; position: absolute; left: 180px; top: 75px">
				<input name="exchange_tomoney" id="exchange_tomoney" placeholder="환전받으실 금액" oninput="exchange_tomoney_input(this.form);">
				<span id="exchange_tomoney_msg" style="font-size: 13px; position: relative; left: 30px;"></span>

				<input name="exchange_choice_account" type="hidden" id="exchange_choice_account"> 
				<input name="exchange_choice_type" type="hidden" id="exchange_choice_type"> 
				
				<select id="exchange_money_type" class="" onchange="exchange_money_reset(this.form);" ></select> 
				
				<input name="user_check_account_pwd" id="user_check_account_pwd" placeholder="계좌 비밀번호" maxlength="4" oninput="UserChkAcntPwd(this.form);"> 				
				<input type="button" value="환전하기" onclick="exchange_account(this.form);" id="exchange_money_button" >
				<span id="userPwd_msg" style="font-size: 13px; position: relative; left: 30px; bottom: 10px;"></span>
				
			</form>			
			
			
				<div id="rate_account_list" >
					<h3 style="margin-left: 30px;">나의 외환 목록</h3>
					
					<div id="my_exchange_type_list" >
					<c:forEach var="vo" items="${exchange_list}">
						<div class="my_exchange_type_mini" >
							<h4 style="border: 1px solid; margin: 5px;">${vo.foregin_type}</h4>
							<h3 style="margin: 5px 5px 5px 50px; ">${vo.exchange_money}</h3>
						
						</div>
					
					</c:forEach>
					</div>
					
				</div>
			</c:if>
			
		</div>
		
		<div class="rate_box">
			<div id="rate_search_period" >
				<div onclick="rate_search('1개월')" id="onemonth">1개월</div>
				<div onclick="rate_search('3개월')" id="threemonth">3개월</div>
				<div onclick="rate_search('6개월')" id="sixmonth">6개월</div>
				<div onclick="rate_search('1년')" id="oneyear">1년</div>
			
				<select id="cur_nm_selected" onchange="cur_nm_selectedFn();">
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