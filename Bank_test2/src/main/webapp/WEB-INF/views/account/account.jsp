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
		
			#account_slide{
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
			
			.account_box .account_move{position: absolute;
							z-index: 2;
							font-size: 16px;
							border: 1px solid red;
							cursor: pointer;
							}
			
			#back > img{width: 50px;}
			#next > img{width: 50px;}
			
			#back{	top: 80px;
					left: 100px;
					}

			#next{  top: 80px;
					right: 100px;
					}
		</style>
		
		<script>
			function account_insert_form(user_id) {
				
				location.href="account_insert_form.do?user_id="+user_id;
				
			}
			
			let position_Count = 0;
			
			function account_moving(moving_width) {
				let oldStyle = document.getElementById("move");
				if (oldStyle) {
					oldStyle.remove();
				}
				let oldposition_Count = position_Count;
				position_Count += Number(moving_width);
				
				let account_slide = document.getElementById("account_slide");
				
				let style = document.createElement("style");
				style.id = "move"
				style.innerHTML = '#account_slide{ animation: move 1s forwards;} @keyframes move { from { right: '+oldposition_Count*100+'px; } to { right: '+position_Count*100+'px } }';
				
				document.head.appendChild(style);
			//	account_slide.style.left = position_Count*100+"px";
			
			}
		</script>
		
	</head>
	
	<body>
	<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			
		<div class="account_box">
			
			<div id="back" class="account_move" onclick="account_moving('-1');"><img src="/bank/resources/img/이전.png"> </div>
		
			<div id="account_slide">
				<c:forEach var="vo" items="${account_list}">
				<div class="account" id="">	
							${vo.account_number} <br>
							${vo.bank_name } <br>
							${vo.now_money } <br>
				</div>
				</c:forEach>
				??????????????
				<div class="account" id="">
					<a><img src="/bank/resources/img/카드 추가.png" width="250px" height="150px" onclick="account_insert_form('${user_id}');"> </a>
				</div>				
			</div>
			
			<div id="next" class="account_move" onclick="account_moving('1');"><img src="/bank/resources/img/다음.png"> </div>

		</div>
		
		<a href="#">환율조회</a>
		<a href="#">환율게시판</a>
		<a href="#">공지사항</a>
		<a href="#">Q&A</a>
		
	</body>
</html>