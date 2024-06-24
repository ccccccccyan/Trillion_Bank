<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style>
			h1{ border: 1px solid;
				height: 100px;}
			
			#bank_box{
					border: 1px solid;
					width: 330px;
					height: 400px;
					overflow: auto; /* 필요시 스크롤 사용 */
					float: left;
					
			}
			
			.bank_mini{
					border: 1px solid red;
					width: 60px;
					float: left;
					margin: 20px;
					cursor: pointer;
			}
			

			.bank_img{
					border: 1px solid green;
					width: 60px;
			}
			
			#form_box{border: 2px solid blue;
					width: 300px;
					height: 700px;
					float: right}
						
		</style>
		
		<script>
			window.onload = function() {
				let bank_list = ["ibk", "교보", "국민", "농협", "비씨", "새마을", "시티", "신한", "우리"]
			
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
			
			function bank_choice(choice_name) {
				let bank_name = document.getElementById("bank_name");
				bank_name.value = choice_name;
			}	
			
			function send_check(f) {
				let bank_name = f.bank_name.value;
				let account_number = f.account_number.value.trim();
				
				if(bank_name != '' && account_number != ''){
				let send_button = document.getElementById("send_button");
				send_button.disabled = false;
				}else{
				send_button.disabled = true;
				}
			}
		
			function account_insert(f) {
				let bank_name = f.bank_name;
				bank_name.disabled = false;
				let account_number = f.account_number.value.trim();
				f.action="account_insert.do?user_id=${param.user_id}";
				f.submit();
			}
		</script>
		
	</head>
	
	<body>
		<h1 align="right">${user_id} 님 환영합니다</h1>
		
		
		<div id="bank_box"></div>
		
		<div id="form_box">
			<form>
				<input name="user_id" value="${user_id}" type="hidden">
				<input name="bank_name" value="" disabled="disabled" id="bank_name"> 은행 <br>
				<input name="account_number" onchange="send_check(this.form);"> 계좌 번호

				<input type="button" value="추가" id="send_button" disabled="disabled" onclick="account_insert(this.form);">
			</form>
		
		</div>
		
	</body>
</html>