<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
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
	
	<!-- account.jsp script 코드 -->
	<script src="/bank/resources/js/account_js.js"></script>

	<!-- account.jsp 및 account_insert_form.jsp css 코드 -->
	<link rel="stylesheet" type="text/css" href="/bank/resources/css/account_css.css">
	
	<!-- header 용 script와 css -->
	<script src="/bank/resources/js/bank_header_js.js"></script>
	<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
	
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

			<!-- 계좌 리스트 박스 -->		
			<div class="account_box" id="account_box">
				<h2 class="seeMyaccount">내 계좌 보기</h2>
				<div id="account_container" class="mySwiper">
					<div id="account_slide" class="swiper-wrapper" >
						<c:forEach var="vo" items="${account_list}" >
							<div class="bankbook_body swiper-slide" onclick="send('${vo.account_number}');">
								<div class="nowmoney_info">
								${vo.now_money }
								</div>
								<div class="account_number_info">
								${vo.account_number}
								</div>
								<div class="bankname_info">
								${vo.bank_name }
								</div>
								
								<!-- 통장 이미지 -->
								<div class="bankbook_front" style="background: ${vo.account_color}"></div>
								<div class="bankbook_line"></div>
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
			
			<!-- 공지, 질문 게시판 박스 -->		
			<div id="board_body">
				<div class="seeqna board_body_content">
					<h2>Q&A</h2>
					<table border="1">
						<c:forEach var="vo" items="${qna_list}">
						<tr>
							<td>${vo.subject}</td>
						</tr>
						</c:forEach>
					</table>
				</div>

				<div class="seenotice board_body_content">
					<h2>공지사항</h2>
					<table border="1">
						<c:forEach var="vo" items="${notice_list}">
						<tr>
							<td>${vo.subject}</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			
			<!-- 환율 그래프, 환율 게시판 박스 -->		
			<div id="rate_body">
				<div class="fagor">
					<h2>﻿그래프 (아니면 FAQ)</h2>
						<canvas id="myChart"></canvas>
				</div>

				<div class="seeboard">
					<h2>환율 게시판</h2>
					<table border="1">
						<c:forEach var="vo" items="${board_list}">
						<tr>
							<td>${vo.subject} ( ${vo.comm_cnt} )</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			
			<!-- 하단 footer -->
			<div id="footer">
				a
			</div>			
		</div>
	</body>
</html>