<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<!-- Ajax사용을 위한 js파일 -->
		<script src="/bank/resources/js/httpRequest.js"></script>

		<!-- account_insert_form.jsp script 코드 -->
		<script src="/bank/resources/js/account_insert_form_js.js"></script>
		
		<!-- account.jsp 및 account_insert_form.jsp css 코드 -->
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/account_css.css">
		
		<!-- header 용 script와 css -->
		<script src="/bank/resources/js/bank_header_js.js"></script>
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
	</head>
	
	<script>
		// 계좌번호 유효성 체크
		function account_pattern(event) {
			let account_warn_msg = document.getElementById("account_warn_msg");
			let same_account = document.getElementById("same_account");
		    const input = event.target.value;
		
		    // 숫자 유효성 검사 (정규 표현식 사용)
            const isValidNumber = /^\d*$/.test(input);

            if (!isValidNumber) {
                console.warn('Invalid input: Only numbers are allowed.');
                account_warn_msg.innerHTML = "유효하지 않은 형식입니다."
                same_account.disabled = true;
                account_no = "no"
                //event.target.value = input.replace(/\D/g, ''); // 숫자가 아닌 문자를 제거
            }else{
            	account_warn_msg.innerHTML="";
	            same_account.disabled = false;
            }
			
		    console.log(event.type, event.target.value);
		}

		// 계좌번호 유효성 체크
		function pwd_pattern(event, f) {
			let pwd_warn_msg = document.getElementById("pwd_warn_msg");
			let send_button = document.getElementById("send_button");
		    const input = event.target.value;
		
		    // 숫자 유효성 검사 (정규 표현식 사용)
            const isValidNumber = /^\d*$/.test(input);

            if (!isValidNumber) {
                console.warn('Invalid input: Only numbers are allowed.');
                pwd_warn_msg.innerHTML = "유효하지 않은 형식입니다."
                send_button.disabled = true;
            }else{
            	pwd_warn_msg.innerHTML="";
            	send_button.disabled = false;
	            send_check(f);
            }
			
		    console.log(event.type, event.target.value);
		}
	</script>
	
	
	<body>
		<div id="account_insert_container">
			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
			
			<div class="account_box">
				<!-- 은행 아이콘 div -->
				<div id="bank_box">
					<h2>은행 선택</h2>
				</div>
				
				<!-- 색상 선택 div -->
				<div id="color_box"></div>
				
				<!-- 계좌 선택 div -->
				<div id="form_box">
					
					<!-- 통장 이미지 -->
					<div id="insert_account_front"></div>
					<div class="insert_account_line"></div>
					<div class="insert_account_page1"></div>
					<div class="insert_account_page2"></div>
					<div id="insert_account_end"></div>
				
					<!-- 계좌 정보 div -->
					<div class="account_form_box" id="account_form_box">
						<form>
							<!-- DB에 저장될 통장 색상 -->
							<input name="account_color" id="account_color" value="#4cacad" type="hidden">
							
							<input name="bank_name" value="" disabled="disabled" id="bank_name"> 은행 <br> <br>
							계좌번호 <br>
							<input name="account_number" maxlength="14" onchange="send_check(this.form);" id="account_number" oninput="account_pattern(event);"> <br>
							
							<input type="button" value="중복확인" id="same_account" onclick="account_check(this.form);">
							<span id="account_warn_msg" style="color: red"></span>
							
							<div class="isnert_pwd_form">
								<input name="account_pwd" maxlength="4" onchange="send_check(this.form);" id="account_pwd" oninput="pwd_pattern(event , this.form);"> 비밀 번호
								<input type="button" value="추가" id="send_button" disabled="disabled" onclick="account_insert(this.form);"> <br>
							<span id="pwd_warn_msg" style="color: red"></span>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>
	</body>
</html>