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
					border: 1px solid;}
					
			.card_shape{width: 330px;
						height: 200px;
						position: absolute;
						top: 80px;
						left: 25px;
						border-radius: 10px;
						background: #f5a364;
						box-shadow: inset 0 0 10px rgba(227, 131, 57, 0.8); 
						}
						
			.card_sim{width: 40px;
						height: 28px;
						border: 1px solid;
						position: absolute;
						top: 40px;
						left: 25px;
						border-radius: 8px;
						background-color: #a2aeb3;
						}
			
			.card_design{
						position: absolute;
						width: 160px;
						height: 230px;
						bottom: -10px;
						right: 0px;
						opacity: 0.6;
			}			
		</style>
		
	</head>
	
	<body>
		<div class="card_box">
			<div class="card_shape">
				<div class="card_sim"></div>
				<img src="/bank/resources/img/심.png" class="card_sim" >
				<img src="/bank/resources/img/개.png" class="card_design" >
			</div>
		</div>
	</body>
</html>