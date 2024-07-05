<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>Insert title here</title>
	
	
	<!-- Ajax사용을 위한 js파일 -->
	<script src="/bank/resources/js/httpRequest.js"></script>
	
	<!-- swiper 설정 -->	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
	<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>

	<!-- chart.js 설정 -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@3.7.1/dist/chart.min.js"></script>

	<!-- swiper script 코드 -->
	<script src="/bank/resources/js/swiper.js"></script>

	<!-- chart.js script 코드 -->
	<script src="/bank/resources/js/chart_js.js"></script>
	
	<!-- account.jsp 및 account_insert_form.jsp css 코드 -->
	<link rel="stylesheet" type="text/css" href="/bank/resources/css/account_css.css">
	
	<!-- header 용 script와 css -->
	<script src="/bank/resources/js/bank_header_js.js"></script>
	<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
	
	<script type="text/javascript">
		window.onload = function () {
			// miss_info : 세션에 저장된 user_id와 파라미터로 받은 user_id가 다를 경우 생기는 데이터 
			let miss_info = "${miss_info}";
			
			if(miss_info == "잘못된 접근입니다."){
				alert(miss_info);
				location.href = "account_list.do";
			}
	
			let account_box = document.getElementById("account_box");
			console.log("sadsad : ");
			// 계좌 리스트는 user_id가 있을 때만(로그인된 상태일 경우), 보여진다.
			let user_id = "${user_id}"; 
			console.log(user_id);
				if(user_id == 'null' || user_id ==''){
				account_box.style.display ="none";
			}else{
				account_box.style.display ="block";
			}
		}
		
		// 계좌 추가 창으로 전환
		function account_insert_form(user_id) {
			location.href="account_insert_form.do";
		}	
			
	 	// 계좌 상세 조회
		function send(accountnumber) {
			location.href = "account_info.do?account_number="+accountnumber;
		}
	 	
		window.addEventListener('resize', function() {
		    var yourDiv = document.querySelector('#container');
		    yourDiv.style.width = window.innerWidth + 'px';
		    yourDiv.style.height = window.innerHeight + 'px';
		});
	</script>
	
	</head>

	<body>
		<div id="container">

			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
			
				<!-- 로그인 여부 -->
				<h2 class="seeMyid">
					<c:if test="${ empty user_id }">
						비회원입니다.
					</c:if>
				
					<c:if test="${not empty user_id }">
						${user_id} 님
					</c:if>
				</h2>
	
			<div class="account_content">
				<!-- 계좌 리스트 박스 -->		
				<div class="account_box" id="account_box">
					<h2 class="seeMyaccount">내 계좌 보기</h2>
					<div id="account_container" class="mySwiper">
						<div id="account_slide" class="swiper-wrapper" >
							<c:forEach var="vo" items="${account_list}" >
								<div class="bankbook_body swiper-slide" onclick="send('${vo.account_number}');">
								
									<c:choose>
									    <c:when test="${vo.account_color eq '#1b202e'}">
											<div class="nowmoney_info" >
											${vo.now_money }
											</div>
											<div class="account_number_info" style="color: white;">
											${vo.account_number}
											</div>
											<div class="bankname_info" style="color: white;">
											${vo.bank_name }
											</div>
											<div class="bankbook_line" style="background-color: #FFCF40"></div>
									    </c:when>
									    
									    <c:when test="${vo.account_color eq '#2c344a'}">
											<div class="nowmoney_info" >
											${vo.now_money }
											</div>
											<div class="account_number_info" style="color: white;">
											${vo.account_number}
											</div>
											<div class="bankname_info" style="color: white;">
											${vo.bank_name }
											</div>
											<div class="bankbook_line"></div>
									    </c:when>
									    
									    <c:otherwise>
											<div class="nowmoney_info">
											${vo.now_money }
											</div>
											<div class="account_number_info">
											${vo.account_number}
											</div>
											<div class="bankname_info">
											${vo.bank_name }
											</div>
											<div class="bankbook_line"></div>
									    </c:otherwise>
									</c:choose>
									
									<!-- 통장 이미지 -->
									<div class="bankbook_front" style="background: ${vo.account_color}"></div>
									<div class="bankbook_page1"></div>
									<div class="bankbook_page2"></div>
									<div class="bankbook_end" style="background: ${vo.account_color}"></div>
								</div>
							</c:forEach>
		
							<div class="account swiper-slide">
								<a><img src="/bank/resources/img/카드 추가.png" onclick="account_insert_form('${user_id}');"> </a>
							</div>
						</div>
	
						<div class="swiper-button-next"></div>
					    <div class="swiper-button-prev"></div>
					    <div class="swiper-pagination"></div>
					</div>
				</div>
				
				<!-- 환율 그래프, 환율 게시판 박스 -->		
				<div id="rate_body">
						<div id="chart_div">
						<h2>﻿한달 누적 환율 그래프</h2>
						<canvas id="myChart"></canvas>
						</div>
						<div class="seeboard">
							<h2>환율 게시판 <a href="r_list.do">+</a></h2>
							<table border="1">
								<c:forEach var="vo" items="${board_list}">
								<tr>
									<td> <a href="r_view.do?r_board_idx=${vo.r_board_idx}"> ${vo.subject} ( ${vo.comm_cnt} ) </a></td>
								</tr>
								</c:forEach>
							</table>
						</div>
				</div>

					
				<!-- 공지, 질문 게시판 박스 -->		
				<div id="board_body">
					<div class="seeqna board_body_content">
						<h2>Q&A <a href="q_list.do">+</a></h2>
						<table border="1">
							<c:forEach var="vo" items="${qna_list}">
							<tr>
								<td><a href="q_view.do?q_board_idx=${vo.q_board_idx}"> ${vo.subject} </a></td>
							</tr>
							</c:forEach>
						</table>
					</div>
	
					<div class="seenotice board_body_content">
						<h2>공지사항 <a href="n_list.do">+</a></h2>
						<table border="1">
							<c:forEach var="vo" items="${notice_list}">
							<tr>
								<td><a href="n_view.do?r_notice_idx=${vo.r_notice_idx}"> ${vo.subject} </a></td>
							</tr>
							</c:forEach>
						</table>
					</div>
				</div>
				</div>
				
				
				<!-- 하단 footer -->
				<div id="footer">
					a
				</div>			
		</div>
	</body>
</html>