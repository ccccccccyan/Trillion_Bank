<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

	<style>
    body {
        font-family: Arial, sans-serif;
        justify-content: center; /* 가운데 정렬 */
        align-items: center; /* 세로 가운데 정렬 */
        height: 100vh; /* 화면 전체 높이를 기준으로 가운데 정렬 */
        flex-direction: column; /* 세로 방향으로 요소들 정렬 */
        margin: 0; /* 기본 마진 제거 */
        padding: 0; /* 기본 패딩 제거 */
    	background-color: #f4f4f4;
    }
    
    #header {
        position: relative; /* 상대 위치 설정 */
        z-index: 1000; /* 헤더의 z-index 값을 크게 설정 */
        margin-bottom: 20px; /* 헤더와 상품 사이 간격 설정 */
    }
    
    .bank-links-container {
        display: flex;
        flex-direction: column; /* 세로 방향으로 요소들 정렬 */
        align-items: center; /* 가운데 정렬 */
    }
    
    .bank-link {
        position: relative; /* 상대 위치 설정 */
        text-decoration: none;
        padding: 10px;
        border: 2px solid #c0d9fc;
        margin-bottom: 15px;
        width: 400px;
        background-color: #ffffff;
    }
    
    .bank-link:hover {
        background-color: #e0e0e0; /* 호버 시 배경색 변경 */
    }
    
    .bank-link a {
        font-weight: bold;
        font-size: 18px;
        color: #a4c2eb;
    }
    
    .product-description {
        font-size: 14px;
        color: #333;
        margin-top: 5px; /* 상품 설명과의 간격 설정 */
    }
    
    .confirmation {
        position: absolute; /* 절대 위치 설정 */
        top: 50%; /* 상단 기준으로 중앙 정렬 */
        right: 8px; /* 오른쪽으로 이동 */
        transform: translateY(-50%); /* 세로 중앙 정렬 */
        background-color: #23212b;
        color: white;
        padding: 8px 12px;
        border: none;
        border-radius: 4px;
        font-size: 14px;
        cursor: pointer;
    }
</style>
		</head>
		<body>
		<div id="header">
		    <jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
		</div>
		
		<div class="bank-links-container">
		    <div class="bank-link" onclick="location.href='regular_deposit.do?idx='+1">
		        <a href="#">일조은행 my플러스 정기예탁금</a>
		        <button class="confirmation">가입</button>
		        <div class="product-description">일정기간 예치 후, 이자수익을 받는 거치식예금</div>
		    </div>
		    
		    <div class="bank-link" onclick="location.href='regular_deposit.do?idx='+2">
		        <a href="#">일조은행 청년희망 정기예탁금</a>
		        <button class="confirmation">가입</button>
		        <div class="product-description">세금 우대와 1~2%높은 이자수익을 받는 거치식예금</div>
		    </div>
		    
		    
		    <div class="bank-link" onclick="location.href='installment_savings.do?idx='+1">
		        <a href="#">일조은행 my플러스 정기적금</a>
		        <button class="confirmation">가입</button>
		        <div class="product-description">매월 일정액을 납입하는 적금</div>
		    </div>
		    
		    <div class="bank-link" onclick="location.href='installment_savings.do?idx='+2">
		        <a href="#">일조은행 청년희망 정기적금</a>
		        <button class="confirmation">가입</button>
		        <div class="product-description">매월 일정액을 납입하는 적금</div>
		    </div>
		    
		</div>
		</body>
</html>