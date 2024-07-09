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
						height: auto; /*  요소의 높이를 자동으로 설정 */
						}
		
			#header{
					width: 100%;
					height: 200px;
					position: absolute;
					left: 0px;
					top: 0px;
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
					width: 1000px;
					height: 250px;
 					align-items: center;
 					left: 700px;
 					top: 20px;
 					
 					}
			#head_content span{
 					text-shadow: 1px 2px 10px white;	
			}		
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
					document.getElementById("head_content1").innerHTML = "늦은 밤에만 시간이 되는 직장인에게";
					document.getElementById("head_content2").innerHTML = "꼭 필요한 은행";

					document.getElementById("head_content1").style.color = "white";
					document.getElementById("head_content2").style.color = "white";
				}
			}
			
			// 1초간격으로 자동으로 change_head_img()함수를 호출한다
			setInterval("change_head_img()", 3000);
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
			
			<div id="chart_div">
			<h2>﻿한달 누적 환율 그래프</h2>
			<canvas id="myChart" width="800" height="600"></canvas>
			</div>
			
			</div>
		</div>
	</body>
</html>