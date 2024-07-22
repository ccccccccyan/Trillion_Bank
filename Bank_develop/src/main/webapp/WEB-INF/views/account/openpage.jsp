<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<!-- header 용 script와 css -->
		<script src="/bank/resources/js/bank_header_js.js"></script>
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
		
		<style>
			html, body {
            	    margin: 0; 
  	    	        padding: 0;
    	            height: 100%; /* 추가: 부모 요소의 높이를 100%로 설정 */
					background-color: #f4f4f4;
           }
			
			li{list-style: none;
				}
			
			a{text-decoration: none;}
		
		
			#container{
						width: 100%;
						height: 4000px; /*  요소의 높이를 자동으로 설정 */
						}
		
			#header{
					width: 100%;
					height: 200px;
					position: absolute;
					left: 0px;
					top: 0px;
					z-index: 4;
					}
			#head_img{width: 100%;
					height: 1000px;
					position: absolute;
					top: 140px;
					}
					
			#head_img img{width: 100%;
					height: 800px;
					position: absolute;
					z-index: 1;
					}
					
			#head_content{
					position: absolute;
					z-index: 3;
					font-size: 60px;
					border: 1px solid;
					width: 930px;
					height: 250px;
 					align-items: center;
 					left: 700px;
 					top: 20px;
 					
 					}
			#head_content span{
 					text-shadow: 1px 2px 10px white;	
			}
			
			#bank_box{position: absolute;
						top: 1150px;
						left: 250px;
						border: 1px solid;
						width: 1300px;
						height: 500px;
						display: flex;
						flex-wrap: wrap;
						opacity: 0;
						transition:  opacity 1s , top 1s 0.2s;
						}
			#bank_box h2{width: 100%;
						font-size: 60px;
						margin-left: 100px;}			
			#bank_box .bank_mini{border: 1px solid;
								width: 150px;
								height: 150px;
								background: white;
								border-radius: 50px;
								margin: 10px;
								}
			.bank_img{
					width: 150px;
					height: 150px;			
								}
			#chart_div{position: absolute;
					width: 800px;
					height: 600px;
					top: 2100px;}
					
		</style>
		
		<script type="text/javascript">
			let head_img_index = 1;
			let head_img_path = "/bank/resources/img/은행대표이미지";
			function change_head_img(){
				head_img_index++;
				if(head_img_index > 2){
					head_img_index = 1;
				}
				document.getElementById("head_img_img").src = head_img_path + head_img_index + ".jpg";
		
				if(head_img_index == 1){
					document.getElementById("head_content1").innerHTML = "매달 일정하게, 꾸준히 키워나가는";
					document.getElementById("head_content2").innerHTML = "미래의 가능성";

					document.getElementById("head_content1").style.color = "black";
					document.getElementById("head_content2").style.color = "black";
				}else{
					document.getElementById("head_content1").innerHTML = "늦은 밤에도 은행을 필요로 하는";
					document.getElementById("head_content2").innerHTML = "이 시대의 직장인에게";

					document.getElementById("head_content1").style.color = "white";
					document.getElementById("head_content2").style.color = "white";
				}
			}
			
			// 1초간격으로 자동으로 change_head_img()함수를 호출한다
			setInterval("change_head_img()", 3000);
			
		window.onload = function() {	
			let bank_list = ["ibk", "국민", "농협", "비씨", "새마을", "시티", "신한", "우리", "카카오뱅크", "토스", "하나", "우체국", "현대", "롯데"];
			
			let bank_box = document.getElementById("bank_box");
			
			// 은행 icon div에 해당 은행별 이미지와 클릭시 bank_choice() 함수에 보내질 은행 이름을 동적으로 기입한다.
			for(let i = 0; i < bank_list.length; i++){
				let bank_mini = document.createElement("div");
				bank_mini.className = "bank_mini";
				bank_mini.id = bank_list[i];
				bank_mini.onclick = function() {
					bank_choice(bank_list[i]);
				};
					
				bank_box.appendChild(bank_mini);
				
				let bank_img = document.createElement("img");
				bank_img.className = "bank_img";
				bank_img.src = "/bank/resources/img/" + bank_list[i] + ".png"
				
				bank_mini.appendChild(bank_img);
			}//for---------------
		}
		
        window.addEventListener('scroll', function() {
            var bank_box = document.getElementById('bank_box');
            var rect = bank_box.getBoundingClientRect();
            var windowHeight = window.innerHeight;

            if (rect.top <= windowHeight && rect.bottom >= 0) {
            	bank_box.style.opacity = 1;
            	bank_box.style.top = "1150px";
            } else {
            	bank_box.style.opacity = 0;
            	bank_box.style.top = "1400px";
            }
        });
		
		</script>
		
			<!-- chart.js 설정 -->
		<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>
	
		<!-- chart.js script 코드 -->
		<script src="/bank/resources/js/chart_js.js"></script>
		
		
	</head>
	
	<body>
		<div>
			<div id="container">
		
			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
			
			<div id="head_img">
				<img id="head_img_img" src="/bank/resources/img/은행대표이미지1.jpg">
				<h1 id="head_content"> <span id="head_content1">매달 일정하게, 꾸준히 키워나가는</span> <span id="head_content2"> 미래의 가능성 </span> </h1>
			</div>
			
			<!-- 은행 아이콘 div -->
			<div id="bank_box">
				<h2>최대 14개의 은행 계좌와 연동 가능</h2>
			</div>
			
			<div id="chart_div">
				<h2>﻿ 실시간 환율 정보 출력 가능 </h2>
				<canvas id="myChart"></canvas>
			</div> 
			
			</div>
		</div>
	</body>
</html>