<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<style>
			body{
			margin: 0;
			padding: 0;
			}
			
			a{text-decoration: none;}
			
			h1{ border: 1px solid;
				height: 100px;}
		
			.account_box{
				border: 2px solid yellow;
				position: relative;
				width: 100%;
				height: 250px;
			}
		
			.account_slide{
				border: 1px solid;
				overflow: hidden;
				width: 2000px;
				height: 200px;
				padding: 10px;
				position: absolute;
				z-index: 1;
			}
			
			.account{
				margin-top: 30px;
				border: 1px solid green;
				float:left;
				width: 250px;
				height: 150px;
				margin-left: 50px;
				background-color: lightgray;
				cursor: pointer;
			}
			
			.account_box a{position: absolute;
							z-index: 2;
							font-size: 16px;
							border: 1px solid red;
							cursor: pointer;
							}
			
			.back > img{width: 50px;}
			.next > img{width: 50px;}
			
			.back{	top: 60px;
					left: 600px;
					}

			.next{  top: 60px;
					right: 600px;
					}
		</style>
		
	</head>
	
	<body>
	<h1 align="right">${user_id} 님 환영합니다</h1>
		
		<div class="account_box">
			
			<a class="back"><img src="/bank/resources/img/이전.png"> </a>
		
			<div class="account_slide">
				<c:forEach var="vo" items="${account_list}">
				<div class="account" id="">	
							${vo.account_number} <br>
							${vo.bank_name } <br>
							${vo.now_money } <br>
				</div>
				</c:forEach>
				
				<div class="account" id="">
					<a><img src="/bank/resources/img/카드 추가.png" width="250px" height="150px"> </a>
				</div>				
			</div>
			
			<a class="next"><img src="/bank/resources/img/다음.png"> </a>

		</div>
		
		<a href="#">환율조회</a>
		<a href="#">환율게시판</a>
		<a href="#">공지사항</a>
		<a href="#">Q&A</a>
		
	</body>
</html>