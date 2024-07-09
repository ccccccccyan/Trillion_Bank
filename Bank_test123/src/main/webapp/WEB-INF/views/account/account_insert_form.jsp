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
<link rel="stylesheet" type="text/css"
	href="/bank/resources/css/account_css.css">

<!-- header 용 script와 css -->
<script src="/bank/resources/js/bank_header_js.js"></script>
<link rel="stylesheet" type="text/css"
	href="/bank/resources/css/bank_header_css.css">
</head>

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
				<div class="insert_account_line" id="insert_account_line"
					style="background: #1e2626"></div>
				<div class="insert_account_page1"></div>
				<div class="insert_account_page2"></div>
				<div id="insert_account_end"></div>

				<!-- 계좌 정보 div -->
				<div class="account_form_box" id="account_form_box">
					<form>
						<!-- DB에 저장될 통장 색상 -->
						<input name="account_color" id="account_color" value="#4cacad"
							type="hidden"> <input name="bank_name" value=""
							disabled="disabled" id="bank_name"> 은행 <br> <br>
						계좌번호 <br> <input name="account_number" maxlength="14"
							oninput="send_check(this.form);" id="account_number"
							placeholder="계좌번호는 숫자 10 ~ 14자리"> <br> <span
							id="account_warn_msg" style="color: red"></span>

						<div class="isnert_pwd_form">
							<input name="account_pwd" maxlength="4"
								oninput="send_check(this.form);" id="account_pwd"
								placeholder="숫자 4자리"> 비밀 번호 <input type="button"
								value="추가" id="send_button" disabled="disabled"
								onclick="account_insert(this.form);"> <br> <span
								id="pwd_warn_msg" style="color: red"></span>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
</body>
</html>