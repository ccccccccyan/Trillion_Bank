<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style type="text/css">
			.card_box{width: 370px;
					height: 300px;
					border: 1px solid;
					margin-left: 100px;
					position: relative;
					}
					
			.card_shape{width: 330px;
						height: 200px;
						position: absolute;
						top: 80px;
						left: 25px;
						border-radius: 10px;
						background: #f5a364; 
						box-shadow: inset 0 0 10px rgba(227, 131, 57, 0.8); 
						
/* 						background: #2fdef5; 
						box-shadow: inset 0 0 10px rgba(56, 162, 255, 0.8);  */
						transition: transform 0.3s ease, left 0.3s ease 0.2s;
						}
						
			.card_sim{width: 40px;
						height: 28px;
						position: absolute;
						top: 40px;
						left: 25px;
						border-radius: 5px;
						background-color: #a2aeb3;
						}
			
			.card_design{
						position: absolute;
						width: 160px;
						right: 0px;
						bottom: -10px;
						height: 230px;
/* 						width: 100px;
						height: 180px;
						bottom: 5px;
						right: 10px; */
						opacity: 0.6;
			}
			
			.card_main_content{
							opacity: 1;
							transition: opacity 0.3s ease;
							position: absolute;
							width: 200px;
							height: 50px;
							z-index: 30;
							top: 120px;
							left: 30px;
							 }
			.card_shape:hover .card_main_content{opacity: 0}
			
 			.card_shape:hover {
	 			  transform: rotate(90deg); 
	 			  left: -60px;
				}
			.card_hidden_content{opacity: 0;
							transition: opacity 0.6s ease 0.3s;
							position: absolute;
							z-index: 100;
							right: 5px;
							width: 150px;
							top: 30px;
			}		 		
			.card_shape:hover + .card_hidden_content{opacity: 1;}
		
			.card_date{font-size: 13px;}
		
		</style>
		
	</head>
	
	<body>
		<div class="card_box">
		
			<div class="card_shape">
				<div class="card_main_content">
					<h3 style="position: absolute; top: -120px; right: -40px;">정기예탁금</h3>
					<h4>현재 금액 : 10000\</h4>
				</div>
				
				
				<img src="/bank/resources/img/심.png" class="card_sim" >
				<img src="/bank/resources/img/개.png" class="card_design" >
			</div>
			<div class="card_hidden_content">
				<h3>정기예탁금</h3>
				<h5>현재 금액 : 10000\</h5>
				<h5>계약 금액 : 100000\</h5>
				<span class="card_date">20240724 ~ 20240724</span>
				<h5>연결계좌 : 11111111</h5>
			</div>
		</div>
	</body>
</html>