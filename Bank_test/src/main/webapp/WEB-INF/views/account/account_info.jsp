<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/account_css.css">
		
		
		<script>
			function send(f) {
				let account_number = f.account_number.value;
				f.action = "remittance_form.do?account_number="+account_number;
				f.submit();
			}
			
			function del(accountnum){
				location.href="delete_form.do?account_number="+accountnum;
			}
		</script>
	</head>
	
	<body>
<%-- 			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div> --%>
	
		<form>
			<table border="1" align="center">
			<input type="hidden" value="${vo.account_number}" name ="account_number">
				<tr align = "center">
					<td>${vo.bank_name}</td>
					<td><input type="button" value="송금하기" onclick="send(this.form);"></td>
					<td><input type="button" value="계좌삭제" onclick="del(${vo.account_number});"></td>	
				</tr>
				<tr>
					<td colspan="3">계좌 잔액: ${vo.now_money}원</td>
				</tr>
				<tr>
					<th>거래대상</th>
					<th>거래금액</th>
					<th>거래일시</th>
				</tr>
				
				
				<c:forEach var="vo2" items="${list}">
	            <tr>
	            	<c:if test="${vo.account_number == vo2.account_number}">
	                <td>${vo2.depo_username}</td>
	                </c:if>
	                <c:if test="${vo.account_number != vo2.account_number}">
	                <td>${vo2.user_name}</td>
	                </c:if>
	                <td>
	                    <c:if test="${vo.account_number == vo2.account_number}">
	                        <span style="color:red">출금: ${vo2.deal_money}</span>
	                    </c:if>
	                    <c:if test="${vo.account_number != vo2.account_number}">
	                        <span style="color:blue">입금: ${vo2.deal_money}</span>
	                    </c:if>
	                </td>
	                <td>${vo2.bank_date}</td>
	            </tr>
        </c:forEach>
			</table>
		</form>
	</body>
</html>