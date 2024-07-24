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
        #container {
            width: 400px;
            padding: 30px;
            padding-bottom: 90px;
            background-color: #fff;
            margin: 200px auto;
            border-radius: 15px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }
        .product-info {
            margin-top: 20px;
        }
        .product-info table {
            width: 100%;
            border-collapse: collapse;
        }
        .product-info table td {
            padding: 10px;
            border-bottom: 1px solid #ddd;
        }
        .product-info table td:first-child {
            font-weight: bold;
            width: 30%;
        }
        input[type="button"] {
        	
            margin-top: 30px;
            padding: 10px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            float:right;
        }
        input[type="button"]:hover {
            background-color: #0056b3;
        }
    </style>
</head>
<body>
<div id="header">
    <jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
</div>
<div id="container">
    <div class="product-info">
        <h2>상품 정보</h2>
        <table>
            <tr>
                <td><strong>상품 이름 :</strong></td>
                <td>${vo.account_productname}</td>
            </tr>
            <tr>
                <td><strong>상품 기간 :</strong></td>
                <td>${vo.products_date} ~ ${vo.endproducts_date}</td>
            </tr>
            <tr>
                <td><strong>계좌 번호 :</strong></td>
                <td>${vo.account_number}</td>
            </tr>
            <tr>
                <td><strong>적금 금액 :</strong></td>
                <td>${vo.products_deal_money}</td>
            </tr>
        </table>
        <input type="button" value="메인페이지로" onclick="location.href='account_list.do'">
    </div>
</div>
</body>
</html>
