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
				
				let color_list = ["#ff5145", "#ff763b", "#ffad33", "#ffd736", "#d0ff36", "#a8ff2e", "#68ff1c",
					"#52f760", "#63ffa4", "#63ffce", "#73fffa", "#73d7ff", "#73b7ff", 
					"#73a2ff", "#737eff", "#1e2a4a", "#b473ff", "#d773ff", "#c95df5", "#f55df2"
					];
	
				let color_box = document.getElementById("color_box");
			
				for(let i = 0; i < color_list.length; i++){
					let color_mini = document.createElement("div");
					color_mini.className = "color_mini";
					color_mini.id = color_list[i];
					color_mini.style.background = color_list[i];
					color_mini.onclick = function() {
						color_choice(color_list[i]);
					};
					
					color_box.appendChild(color_mini);
				}
			}	
			
			
			function color_choice(color) {
				let insert_account_front = document.getElementById("insert_account_front");
				let insert_account_end = document.getElementById("insert_account_end");
				let account_color = document.getElementById("account_color");
				
				insert_account_front.style.background = color;
				insert_account_end.style.background = color;
				account_color.value = color;
				
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
		
			<div id="color_box"></div>
			
			<div id="form_box">
					<div id="insert_account_front"></div>
					<div class="insert_account_line"></div>
					<div class="insert_account_page1"></div>
					<div class="insert_account_page2"></div>
					<div id="insert_account_end"></div>
			
				<div class="account_form_box">
					<form>
						<input name="user_id" value="${user_id}" type="hidden">
						<input name="account_color" id="account_color" value="#4cacad" type="hidden">
						
						<input name="bank_name" value="" disabled="disabled" id="bank_name"> 은행
						<h3>계좌번호</h3>
						<input name="account_number" maxlength="14" onchange="send_check(this.form);" id="account_number"> <br>
						
						<div class="isnert_pwd_form">
							<input name="account_pwd" maxlength="4" onchange="send_check(this.form);" id="account_pwd"> 비밀 번호
			
							<input type="button" value="추가" id="send_button" disabled="disabled" onclick="account_insert(this.form);">
						</div>
					</form>
				</div>
			</div>
		</div>
		
		</div>
	</body>
</html>