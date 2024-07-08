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
			let account_manager = document.getElementById("account_manager");
			console.log("sadsad : ");
			// 계좌 리스트는 user_id가 있을 때만(로그인된 상태일 경우), 보여진다.
			let user_id = "${user_id}"; 
			let manager = "${manager}"; 
			console.log(user_id);
			console.log(manager);
			if(user_id == 'null' || user_id ==''){
				account_box.style.display ="none";
				account_manager.style.display ="none";
			}else if(manager == 'Y'){
				account_box.style.display ="none";
				account_manager.style.display ="block";
			}else{
				account_box.style.display ="block";
				account_manager.style.display ="none";
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
	 	
	 	
	 	// 계좌 검색으로 사용자 정보 조회
	 	function search_userinfo(event) {
			let search_account_number = event.target.value;
	 		let search_worn_msg = document.getElementById("search_worn_msg");
	 		let search_result = document.getElementById("search_result");
	 		search_result.innerHTML = "";
			
			let onlynumber = /^[0-9]{10,14}$/;
			if(!onlynumber.test(search_account_number)){
				search_worn_msg.innerHTML = "유효한 형식의 계좌 번호는 숫자 10 ~ 14자리 입니다.";
				search_worn_msg.style.color = "red";
				search_result.style.display = "none";
				return;
			}
			search_worn_msg.innerHTML = "";
			
			// 프로미스 객체를 받아온다.
			search_userinfoFn(search_account_number)
			 .then(search_data => {
				console.log("search_data : "+search_data);
	            
		 		let account_number = [];
		 		let bank_name = [];
		 		let user_id = [];
		 		let user_tel = [];
	            let search_print = "";
			            
	           if(search_data.search_result == 'no'){
	   			    search_worn_msg.innerHTML = "검색 결과가 없습니다.";
				    search_worn_msg.style.color = "gray";
					search_result.style.display = "none";
	           		return;
	           }
			           
	           search_data.account_result.forEach(account_data => {
	       		account_number.push(account_data.account_number);
	           	bank_name.push(account_data.bank_name);
	            });
			            
	           search_data.userinfo_result.forEach(user_data => {
	           	user_id.push(user_data.user_id);
	           	user_tel.push(user_data.user_tel);
	            });
			            
	            for(let i = 0; i < account_number.length; i++){
		           	search_print += "<div class='search_content' onclick='change_searchinfo("+ account_number[i] +")'>"
	    	       					+ account_number[i] + "(" + bank_name[i] + ")   "
			       					+ user_id[i] + "님 (" + user_tel[i] + ")"
			       					+"</div> " 
			    }
				search_result.innerHTML = search_print;
				search_result.style.display = "block";
			 })
		     .catch(error => {
		     console.error('처리 중 오류 발생', error);
		     search_worn_msg.innerHTML = "통신 중 문제가 발생했습니다.";
		     search_worn_msg.style.color = "red";
		     });
			 
	 	}
	 	
	 	
	 	// 계좌 검색으로 사용자 정보 조회 
	 	function search_userinfoFn(search_account_number) {
	 		let search_result = document.getElementById("search_result");
	 		let search_worn_msg = document.getElementById("search_worn_msg");
	 		
	 		// fetch 앞에 return을 붙이면 해당 함수를 호출했을때 프로미스 객체를 반환받을 수 있다.
	 		return fetch("search_userinfo_account.do?search_account_number="+search_account_number)
	 		  .then(response => {
	           	console.log(response);
	               if (!response.ok) { // ==> xhr.readyState == 4 && xhr.status == 200
						search_worn_msg.innerHTML = "서버와 통신 중 문제가 발생했습니다.";
						search_worn_msg.style.color = "red";
	                   throw new Error('Network response was not ok');
	               }
	               return response.json();
	           })
	 		  // 에러 발생 시 호출
	          .catch(error => {
   			   search_worn_msg.innerHTML = "통신 중 문제가 발생했습니다.";
			   search_worn_msg.style.color = "red";
	           console.error('There was a problem with the fetch operation:', error);
	          });
		}
	 	
	 	// 검색 박스 이외의 곳을 클릭했을 경우
	    document.addEventListener('click', function(event) {
			let search_result = document.getElementById("search_result");
			let search_account_number = document.getElementById("search_account_number");
	 		let search_worn_msg = document.getElementById("search_worn_msg");
	        
	        // 클릭된 요소가 검색 결과 박스 내부에 있는지 확인
	        let isClickedInsideSearchBox = search_result.contains(event.target);  // 한 요소가 다른 요소를 포함하는지를 판별 . 즉, 검색 결과 박스 내부에 클릭된 요소가 포함되어 있는지를 판별
	        let isClickedOnSearchInput = (event.target == search_account_number); // 검색 input 필드에 직접 클릭했을 경우에만 true를 반환하고, 그 외의 경우엔 false를 반환

	        // 검색 결과 박스가 열려 있고, 검색 input 이외의 곳을 클릭한 경우
	        if (!isClickedInsideSearchBox && !isClickedOnSearchInput && search_result.style.display == 'block') {
				search_result.style.display = "none";
				search_worn_msg.innerHTML = "";
	        }
	        
	    });
	 	
	 	// 검색 결과 중 하나를 선택했을 경우
	 	function change_searchinfo( account_number) {
			console.log(account_number);

			let search_username = document.getElementById("search_username");
			let search_user_name = document.getElementById("search_user_name");
			let search_bank_name = document.getElementById("search_bank_name");
			let search_bank_name_position = document.getElementById("search_bank_name_position");
			let search_user_id = document.getElementById("search_user_id");
			let search_account = document.getElementById("search_account");
			let search_tel = document.getElementById("search_tel");
			let search_now_money = document.getElementById("search_now_money");
			let search_account_color = document.getElementById("search_account_color");
			
			// 다시 한번 정보 조회
			change_searchinfoFn(account_number)
			 .then(search_data => {
				console.log(search_data);
				
				if(search_data.userinfo_result.user_name == 'unknown'){
					search_user_name.innerHTML = " ×";
				}else{
					search_user_name.innerHTML = " ●";
				}
				
				// 검색 결과 출력
				search_tel.innerHTML = search_data.userinfo_result.user_tel;
				search_username.innerHTML = search_data.userinfo_result.user_name;
				
				search_account.innerHTML = search_data.account_result.account_number;
				search_bank_name.innerHTML = search_data.account_result.bank_name;
				search_bank_name_position.style.background = "url('/bank/resources/img/"+ search_data.account_result.bank_name +".png') no-repeat right";
				search_bank_name_position.style.backgroundSize = "26px";
				search_user_id.innerHTML = search_data.account_result.user_id;
				search_now_money.innerHTML = search_data.account_result.now_money;
				search_account_color.style.background = search_data.account_result.account_color;
				
			 })
		     .catch(error => {
			     console.error('처리 중 오류 발생', error);
			     search_worn_msg.innerHTML = "통신 중 문제가 발생했습니다.";
			     search_worn_msg.style.color = "red";
		     });
			
			// 검색이 완료되었으니 검색 박스 none
			let search_result = document.getElementById("search_result");
			search_result.style.display = "none";
		}
	 	
	 	// 계좌 검색으로 사용자 정보 조회 
	 	function change_searchinfoFn(account_number) {
	 		let search_worn_msg = document.getElementById("search_worn_msg");
	 		
	 		// fetch 앞에 return을 붙이면 해당 함수를 호출했을때 프로미스 객체를 반환받을 수 있다.
	 		return fetch("change_searchinfo_account.do?account_number="+account_number)
	 		  .then(response => {
	           	console.log(response);
	               if (!response.ok) { // ==> xhr.readyState == 4 && xhr.status == 200
						search_worn_msg.innerHTML = "서버와 통신 중 문제가 발생했습니다.";
						search_worn_msg.style.color = "red";
	                   throw new Error('Network response was not ok');
	               }
	               return response.json();
	           })
	 		  // 에러 발생 시 호출
	          .catch(error => {
   			   search_worn_msg.innerHTML = "통신 중 문제가 발생했습니다.";
			   search_worn_msg.style.color = "red";
	           console.error('There was a problem with the fetch operation:', error);
	          });
		}
	 	
	 	
	 	
	 	
	 	// 임시
	 	let head_img_index = 1;
		let head_img_path = "/bank/resources/img/은행대표이미지";
		function change_head_img(){
			head_img_index++;
			if(head_img_index > 2){
				head_img_index = 1;
			}
			document.getElementById("head_img_img").src = head_img_path + head_img_index + ".jpg";
	
			if(head_img_index == 1){
				document.getElementById("head_content1").innerHTML = "꾸준히 키워나가는";
				document.getElementById("head_content2").innerHTML = "미래의 가능성";

				document.getElementById("head_content1").style.color = "black";
				document.getElementById("head_content2").style.color = "black";
			}else{
				document.getElementById("head_content1").innerHTML = "늦은 밤, 당신에게";
				document.getElementById("head_content2").innerHTML = "꼭 필요한 은행";

				document.getElementById("head_content1").style.color = "white";
				document.getElementById("head_content2").style.color = "white";
			}
		}
		
		// 1초간격으로 자동으로 change_head_img()함수를 호출한다
		setInterval("change_head_img()", 3000);
	 	
	</script>
	
	</head>

	<body>
		<div id="container">

			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
			
			<div id="head_img"> <!-- 임시 -->
				<img id="head_img_img" src="/bank/resources/img/은행대표이미지1.jpg">
				<h1 id="head_content"> <span id="head_content1">꾸준히 키워나가는</span> <span id="head_content2"> 미래의 가능성 </span> </h1>
			</div>
			
				<!-- 로그인 여부 -->
				<h2 class="seeMyid">
					<c:if test="${ empty user_id }">
						비회원입니다.
					</c:if>
				
					<c:if test="${not empty user_id && empty manager }">
						${user_id} 님
					</c:if>

					<c:if test="${not empty user_id && not empty manager }">
						${user_id} 님 <br> 
						( 관리자 )
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
				
				<!-- 관리자에게만 보이는 통장 검색 기능 -->
				<div id="account_manager">
					<h2><span id="search_username">사용자</span>님 통장 관리</h2> 
					
					<div id="search_user_account">
						계좌 검색 
						<input id="search_account_number" name="search_account_number" oninput="search_userinfo(event);" placeholder="계좌 번호 검색하기"> ▼ 
						<br> <span id="search_worn_msg"></span>
						<div id="search_result"></div>
					</div>
											
					<div class="account_slide" >
						<div id="search_info">
							<h4 id="search_user_name_position"> 계정 활성화 여부 :<span id="search_user_name"></span></h4>
							<h4 id="search_bank_name_position"> <span id="search_bank_name"></span></h4>
							<h4 id="search_user_id_position">아이디 : <span id="search_user_id"></span> 님</h4>
							<h4 id="search_user_account_position">계좌 번호 : <span id="search_account"> </span></h4>
							<h4 id="search_tel_position">전화 번호 : <span id="search_tel"> </span></h4>
							<h4 id="search_now_money_position">현재 잔액 : <span id="search_now_money"> </span> \</h4>
							<h4 id="search_account_color_position">통장 색상 : <div id="search_account_color"></div></h4>
						</div>
						
						<div class="bankbook_back" style="background: black;"></div>
						<div class="bankbook_mainpage">
							<hr> <hr> <hr> <hr> <hr> <hr> <hr> <hr>	<hr>
						</div>
						<div class="bankbook_hidepage"></div>
						<div class="bankbook_shadow" ></div> 
					</div>
					
					<div id="update_user_account">
							
						<div class="update_user">
							<h4>계정 상태 관리</h4>
							<div>계정 활성화</div>
							<div>계정 비활성화</div>
						</div>
						<div class="update_userinfo">
							<h4>계정 정보 수정 및 변경</h4>
							<div>계정 이름 변경</div>
							<div>아이디 찾기</div>
							<div>계정 비밀번호 변경</div>
							<div>전화번호 찾기</div>
							<div>전화번호 변경</div>
						</div>
						
						<div id="update_userinfo">
							<h4>계좌 정보 수정 및 변경</h4>
							<div>계좌 비밀번호 변경</div>
							<div>계좌 색상 변경</div>
						</div>
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
				<div id="footer"></div>			
		</div>
	</body>
</html>