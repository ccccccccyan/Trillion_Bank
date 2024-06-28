<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script src="/bank/resources/js/account_js.js"></script>
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/account_css.css">
		
		<script src="/bank/resources/js/bank_header_js.js"></script>
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
		
		<script>
			window.onload = function() {
				let bank_list = ["일조","ibk", "국민", "농협", "비씨", "새마을", "시티", "신한", "우리", "카카오뱅크", "토스", "하나", "우체국", "현대", "롯데"];
			
				let bank_box = document.getElementById("bank_box");
				
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
				}
			}	

		</script>
		
	</head>
	
	<body>
		<div id="account_insert_container">

		<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
		
		<div class="account_box">
			<div id="bank_box">
				<h2>은행 선택</h2>
			</div>
		
			<div id="color_box">
			.
			</div>
			<div id="form_box">
				<form>
					<input name="user_id" value="${user_id}" type="hidden">
					<input name="bank_name" value="" disabled="disabled" id="bank_name"> 은행 <br>
					<input name="account_number" maxlength="14" onchange="send_check(this.form);"> 계좌 번호
					<input name="account_pwd" maxlength="4" onchange="send_check(this.form);"> 비밀 번호
	
					<input type="button" value="추가" id="send_button" disabled="disabled" onclick="account_insert(this.form);">
				</form>
			</div>
		</div>
		
		</div>
	</body>
</html>