<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                
            }
            form {
            	padding: 220px;
            }
        
            .transaction-list {
                max-width: 800px;
                margin: 0 auto;
                background: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                border-radius: 8px;
                overflow: hidden;
            }
        
            .transaction-header, .transaction-item {
                display: flex;
                padding: 15px;
                border-bottom: 1px solid #e0e0e0;
            }
        
            .transaction-header {
                background: #23212b;
                color: #fff;
                font-weight: bold;
                justify-content: space-between; /* Add this to space out the header items */
            }
        
            .transaction-item:nth-child(odd) {
                background: #f9f9f9;
            }
        
            .transaction-party, .transaction-amount, .transaction-date {
                flex: 1;
                text-align: center;
            }
        
            .transaction-party {
                flex: 2;
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
        </style> 
    </head>
    <body>
    	<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
    	<form>
    
        <div class="transaction-list">
            <div class="transaction-header">
                <div class="transaction-party">거래대상</div>
                <div class="transaction-amount">거래금액</div>
                <div class="transaction-date">거래일시</div>
            </div>
            
            <c:forEach var="vo2" items="${list}">
                <c:choose>
                    <c:when test="${type == '전체'}">
                        <!-- 전체 조회일 경우 모든 거래 내역을 보여줍니다. -->
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
                                    <span style="color:red">출금: ${vo2.deal_money}</span>
                                </c:if>
                                <c:if test="${vo.account_number != vo2.account_number}">
                                    <span style="color:blue">입금: ${vo2.deal_money}</span>
                                </c:if>
                            </div>
                            
                            <div class="transaction-date">
                                ${vo2.bank_date}
                            </div>
                        </div>
                    </c:when>
                    <c:when test="${type == '입금'}">
                        <!-- 송금 조회일 경우 vo2에서 송금에 해당하는 거래 내역만 필터링하여 보여줍니다. -->
                        <c:if test="${vo2.account_number != vo.account_number}">
                            <div class="transaction-item">
                                <div class="transaction-party">
                                    ${vo2.user_name}
                                </div>
                                
                                <div class="transaction-amount">
                                    <span style="color:blue">입금: ${vo2.deal_money}</span>
                                </div>
                                
                                <div class="transaction-date">
                                    ${vo2.bank_date}
                                </div>
                            </div>
                        </c:if>
                    </c:when>
                    <c:when test="${type == '출금'}">
                        <!-- 출금 조회일 경우 vo2에서 출금에 해당하는 거래 내역만 필터링하여 보여줍니다. -->
                        <c:if test="${vo2.depo_username != null && vo2.account_number == vo.account_number}">
                            <div class="transaction-item">
                                <div class="transaction-party">
                                    ${vo2.depo_username}
                                </div>
                                
                                <div class="transaction-amount">
                                    <span style="color:red">출금: ${vo2.deal_money}</span>
                                </div>
                                
                                <div class="transaction-date">
                                    ${vo2.bank_date}
                                </div>
                            </div>
                        </c:if>
                    </c:when>
                </c:choose>
            </c:forEach>
        </div>
        <a href="javascript:history.back()" class="back-button">다시조회</a>
    	</form>
    </body>
</html>