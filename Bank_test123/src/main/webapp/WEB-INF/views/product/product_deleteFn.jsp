<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style>
		
			.product_delete_background{width: 100%;
										height: 100%;
										background: #a6a6a2;
										opacity: 0.6;
										position: absolute;
										z-index: 900;
									 	top: -120px; 
										}
		
			.product_delete_result{width: 290px;
							height: 300px;
							background-color: #fff;
		    	        	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
		    	        	padding: 20px;
							opacity: 1;
							position: absolute;
							z-index: 950;
							border-radius: 30px;
							left: 610px;
							top: 200px;
							}	
		
		</style>
		
		<script type="text/javascript">
			function close_product_delete_result() {
				
				location.href = 'account_list.do';
			}
		</script>
		
	</head>
	<body>
		<div class="product_delete_background" id="product_delete_background"></div>
			<form class="product_delete_result">
				<h3> 계좌 해지를 완료하였습니다.</h3>
				<h5> 상품 : ${product_delete_vo.account_productname} </h5>
				<h5> 연결 계좌 : ${product_delete_vo.account_number} </h5>
				<h5> 가입기간 : ${product_delete_vo.products_date} ~ ${product_delete_vo.endproducts_date} </h5>
				<h6> 이율 : ${product_delete_vo.products_rate}% / 세금 : ${product_delete_vo.products_tax}%</h6>
				<h5> 만기금액 : ${product_delete_vo.saving_money}원</h5>
				
				<input type="button" value="확인" onclick="close_product_delete_result();" style="width: 200px; height: 30px; background: black; color: white; margin-left: 45px; cursor: pointer;">
				
			</form>
	</body>
</html>