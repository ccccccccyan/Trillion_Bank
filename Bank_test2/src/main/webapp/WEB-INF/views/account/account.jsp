<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<title>Insert title here</title>
	
	<!-- swiper 설정 -->	
	<script src="/bank/resources/js/swiper-bundle.min.js"></script>
	<link rel="stylesheet" href="/bank/resources/css/swiper-bundle.min.css">

	<script src="/bank/resources/js/account_js.js"></script>
	<link rel="stylesheet" type="text/css" href="/bank/resources/css/account_css.css">

	<script src="/bank/resources/js/bank_header_js.js"></script>
	<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
	
	<script>
	document.addEventListener("DOMContentLoaded", function() {
	    // Swiper 라이브러리가 로드된 후에 실행되어야 하는 코드
	    var swiper = new Swiper(".mySwiper", {
	        slidesPerView: 3,
            centeredSlides: false, // 중앙 정렬 해제
	        spaceBetween: 30,
	        pagination: {
	            el: ".swiper-pagination",
	            type: "fraction",
	        },
	        navigation: {
	            nextEl: ".swiper-button-next",
	            prevEl: ".swiper-button-prev",
	        },
	    });
	})
	
	</script>

	  
	</head>



	<body>
		<div id="container">

			
			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
		
			<div class="account_box ">
				<h2 class="seeMyaccount">내 계좌 보기</h2>
				<div id="account_container" class="mySwiper">
					<div id="account_slide" class="swiper-wrapper">
							<c:forEach var="vo" items="${account_list}">
								<div class="bankbook_body swiper-slide">
									<div class="nowmoney_info">
									${vo.now_money }
									</div>
									<div class="account_number_info">
									${vo.account_number}
									</div>
									<div class="bankname_info">
									${vo.bank_name }
									</div>
									
									<div class="bankbook_front"></div>
									<div class="bankbook_line"></div>
									<div class="bankbook_page1"></div>
									<div class="bankbook_page2"></div>
									<div class="bankbook_end"></div>
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
			
			<hr style="background-color: #9dc1c9; margin-top: 1000px; height: 2px">
			
			<div class="seenotice">
				<h2>공지사항</h2>
				<table border="1">
					<tr>
						<td>제목</td>
					</tr>
					<tr>
						<td>제목</td>
					</tr>
					<tr>
						<td>제목</td>
					</tr>
					<tr>
						<td>제목</td>
					</tr>
					<tr>
						<td>제목</td>
					</tr>
				</table>
			</div>
			
			<div class="seeboard">
				<h2>환율 게시판</h2>
				<table border="1">
					<tr>
						<td>제목</td>
						<td>조회수</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>조회수</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>조회수</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>조회수</td>
					</tr>
					<tr>
						<td>제목</td>
						<td>조회수</td>
					</tr>
				</table>
			</div>
			
			<div class="seeqna">
				<h2>Q&A</h2>
				<table border="1">
					<tr>
						<td>제목</td>
					</tr>
					<tr>
						<td>제목</td>
					</tr>
					<tr>
						<td>제목</td>
					</tr>
					<tr>
						<td>제목</td>
					</tr>
					<tr>
						<td>제목</td>
					</tr>
				</table>
			</div>
			<div class="fagor">
				<h2>﻿그래프 (아니면 FAQ)</h2>
				
			</div>
			
		</div>
	
	</body>
</html>