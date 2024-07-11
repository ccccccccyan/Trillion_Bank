<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" type="text/css" href="/bank/resources/css/account_css.css">

<style>
body {
	font-family: Arial, sans-serif;
	background-color: #f4f4f4;
	margin: 0;
}

.account-table {
	max-width: 800px;
	margin: 0 auto;
	background: #fff;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	border-radius: 8px;
	padding: 220px;
	text-align: center;
}

.account-info {
	display: flex;
	justify-content: space-between;
	align-items: center;
	padding: 10px 0;
	border-bottom: 1px solid #e0e0e0;
}

.bank-name {
	flex: 1;
	text-align: left;
	font-weight: bold;
	font-size: 1.2em;
}

.account-balance {
	padding: 15px 0;
	font-size: 1.1em;
	font-weight: bold;
	border-bottom: 1px solid #e0e0e0;
}

.transaction-list {
	margin-top: 20px;
}

.transaction-header {
	display: flex;
	justify-content: space-between;
	background-color: #23212b;
	color: white;
	padding: 10px;
	font-weight: bold;
	border-radius: 5px 5px 0 0;
}

.transaction-item {
	display: flex;
	justify-content: space-between;
	border-bottom: 1px solid #ccc;
	padding: 10px;
	align-items: center;
}

.transaction-item:nth-child(odd) {
	background: #f9f9f9;
}

.transaction-party, .transaction-amount, .transaction-date {
	flex: 1;
	text-align: left;
	font-size: 0.9em;
}

.transaction-amount span {
	font-weight: bold;
}

.back-button {
	display: block;
	width: 100px;
	margin: 20px auto;
	padding: 10px;
	text-align: center;
	background: #23212b;
	color: #fff;
	text-decoration: none;
	border-radius: 5px;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
}

.back-button:hover {
	background: #23212b;
	opacity: 0.9;
}

.sort-button {
	text-align: right;
	padding: 5px 0;
	cursor: pointer;
	color: #007bff;
}

.account-info input[type="button"] {
	background-color: #23212b;
	color: #fff;
	border: none;
	padding: 10px 20px;
	margin-left: 10px;
	cursor: pointer;
	border-radius: 5px;
	box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
}

.account-info input[type="button"]:hover {
	opacity: 0.9;
}
</style>



<script>	
			// 계좌비밀번호 5회 틀릴시 잠겼을때 경고창으로 잠겼다고 띄움
			window.onload = function() {
			    if (${vo.account_lockcnt} == 5) {
			        alert("계좌 비밀번호 5회실패! 일조은행에 문의해주세요.");
			        location.href = "account_list.do";
			    }
			};
			//계좌 상세보기 컨트롤러
			function send(f) {
				let account_number = f.account_number.value;
				f.action = "remittance_form.do?account_number="+account_number;
				f.submit();
			}
			//계좌 삭제 컨트롤러
			function del(accountnum){
				location.href="delete_form.do?account_number="+accountnum;
			}
			//디테일 서치컨트롤러 
			function detail(accountnum){
				location.href="accountdetail_Searchform.do?account_number="+accountnum;
			}

			
		</script>
</head>

<body>
	<div id="header">
		<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	</div>

	<form>
		<div class="account-table">
			<input type="hidden" value="${vo.account_number}" name="account_number">

			<div class="account-info">
				<div class="bank-name">${vo.bank_name}은행${vo.account_number}</div>
				<div>
					<input type="button" value="송금하기" onclick="send(this.form);">
					<input type="button" value="계좌삭제" onclick="del(${vo.account_number});">
				</div>
			</div>

			<div class="account-balance">계좌 잔액: ${vo.now_money}원</div>

			<div class="transaction-list">
				<div align="right" onclick="detail(${vo.account_number})" style="cursor: pointer;">전체·최신순 ▼</div>
				<div class="transaction-header">
					<div>거래대상</div>
					<div>거래금액</div>
					<div>거래일시</div>
				</div>

				<c:forEach var="vo2" items="${list}">
					<div class="transaction-item">
						<div class="transaction-party">
							<c:if test="${vo.account_number == vo2.account_number}">
                        ${vo2.depo_username}
                    </c:if>
							<c:if test="${vo.account_number != vo2.account_number}">
                        ${vo2.user_name}
                    </c:if>
						</div>

						<div class="transaction-amount">
							<c:if test="${vo.account_number == vo2.account_number}">
								<span style="color: red">출금: ${vo2.deal_money}</span>
							</c:if>
							<c:if test="${vo.account_number != vo2.account_number}">
								<span style="color: blue">입금: ${vo2.deal_money}</span>
							</c:if>
						</div>

						<div class="transaction-date">${vo2.bank_date}</div>
					</div>
				</c:forEach>
				<a href="#" class="back-button" onclick="location.href='account_list.do'">뒤로가기</a>
			</div>
		</div>
	</form>
</body>
</html>