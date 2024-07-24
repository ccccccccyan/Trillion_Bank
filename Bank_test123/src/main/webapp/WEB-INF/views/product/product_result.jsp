<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Product Result</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
            padding: 0;
            background-color: #f4f4f4;
        }
        h2 {
            color: #333;
        }
        .product-info {
            background-color: #fff;
            padding: 20px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            margin-bottom: 20px;
        }
        .product-info p {
            margin: 10px 0;
            font-size: 16px;
        }
    </style>
</head>
<body>
	<div id="header">
			<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	</div>

    <div class="product-info">
        <h2>상품 정보</h2>
        <p><strong>상품 이름:</strong> ${vo.account_productname}</p>
        <p><strong>상품 기간:</strong> ${vo.products_date} ~ ${vo.endproducts_date }</p>
        <p><strong>계좌 번호:</strong> ${vo.account_number}</p> 
        <p><strong>적금 금액:</strong> ${vo.saving_money}</p>
        <!-- 기타 필요한 상품 정보 출력 -->
    </div>
</body>
</html>
