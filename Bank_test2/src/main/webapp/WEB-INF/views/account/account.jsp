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

	
				<div id="account_container" class="mySwiper">
					<div id="account_slide" class="swiper-wrapper">
							<c:forEach var="vo" items="${account_list}">
								<div class="account swiper-slide" id="">
									${vo.account_number}
									<br>
									${vo.bank_name }
									<br>
									${vo.now_money }
									<br>
								</div>
							</c:forEach>
							<div class="account swiper-slide">
								<a><img src="/bank/resources/img/카드 추가.png" width="250px" height="150px" onclick="account_insert_form('${user_id}');"> </a>
							</div>
					</div>

					<div class="swiper-button-next"></div>
				    <div class="swiper-button-prev"></div>
				    <div class="swiper-pagination"></div>

				</div>
	

			</div>
		</div>
	
	</body>
</html>