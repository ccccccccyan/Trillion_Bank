<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
	<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<title>일조은행</title>
	
	
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
			// 계좌 리스트는 user_id가 있을 때만(로그인된 상태일 경우), 보여진다.
			let user_id = "${user_id}"; 
			let manager = "${manager}"; 
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
	 		// 이전 수정 폼 초기화 
	 		document.getElementById("change_info").style.display = "none";
	 		document.getElementById("change_info").value = "";
	 		document.getElementById("change_color_msg").innerHTML = "";
	 		document.getElementById("change_send").style.display = "none";
	 		document.getElementById("change_color").style.display = "none";
	 		
	 		// 본인인증 창 다시 표시
	 		document.getElementById("user_self_check_box").style.display = "block";
	 		
	 		// 검색결과 초기화
			let search_account_number = event.target.value;
	 		let search_warn_msg = document.getElementById("search_warn_msg");
	 		let search_result = document.getElementById("search_result");
	 		search_result.innerHTML = "";
			
	 		// 유효성 체크
			let onlynumber = /^[0-9]{10,14}$/;
			if(!onlynumber.test(search_account_number)){
				search_warn_msg.innerHTML = "유효한 형식의 계좌 번호는 숫자 10 ~ 14자리 입니다.";
				search_warn_msg.style.color = "red";
				search_result.style.display = "none";
				return;
			}
			search_warn_msg.innerHTML = "";
			
			// 프로미스 객체를 받아온다.
			search_userinfoFn(search_account_number)
			 .then(search_data => {
	           // 검색 결과가 없을 경우
	           if(search_data.search_result == 'no'){
	   			    search_warn_msg.innerHTML = "검색 결과가 없습니다.";
				    search_warn_msg.style.color = "gray";
					search_result.style.display = "none";
	           		return;
	           }

			   // 검색 결과가 있을 경우
	           // 반환 타입은 두 리스트를 담은 map으로 보내지기 때문에 각 리스트에서 따로 값을 받아와야 한다.
				search_data.account_result.forEach(account_data => {
					// account_data와 매치되는 userinfo_result 데이터를 찾아서 가져온다
				    let corresponding_user_data = search_data.userinfo_result.find(user_data => user_data.user_id == account_data.user_id);
					
					// 검색 결과 데이터 한줄씩 추가
					search_result.innerHTML += "<div class='search_content' onclick='change_searchinfo("+ account_data.account_number +")'>"
								   				+ account_data.account_number + "(" + account_data.bank_name + ") "
								   				+ corresponding_user_data.user_id + "님 (" + corresponding_user_data.user_tel + ")" + "</div> " 
				});
				search_result.style.display = "block"; // 검색 결과 div 표시
			 })
		     .catch(error => {
			     console.error('처리 중 오류 발생', error);
			     search_warn_msg.innerHTML = "통신 중 문제가 발생했습니다.";
			     search_warn_msg.style.color = "red";
		     });
	 	}
	 	
	 	
	 	// 계좌 검색으로 사용자 정보 조회 
	 	function search_userinfoFn(search_account_number) {
	 		let search_result = document.getElementById("search_result");
	 		let search_warn_msg = document.getElementById("search_warn_msg");
	 		
	 		// fetch 앞에 return을 붙이면 해당 함수를 호출했을때 프로미스 객체를 반환받을 수 있다.
	 		return fetch("search_userinfo_account.do?search_account_number="+search_account_number)
	 		  .then(response => {
	           	console.log(response);
	               if (!response.ok) { // ==> xhr.readyState == 4 && xhr.status == 200
						search_warn_msg.innerHTML = "서버와 통신 중 문제가 발생했습니다.";
						search_warn_msg.style.color = "red";
	                   throw new Error('Network response was not ok');
	               }
	               return response.json();
	           })
	 		  // 에러 발생 시 호출
	          .catch(error => {
   			   search_warn_msg.innerHTML = "통신 중 문제가 발생했습니다.";
			   search_warn_msg.style.color = "red";
	           console.error('There was a problem with the fetch operation:', error);
	          });
		}
	 	
	 	// 검색 박스 이외의 곳을 클릭했을 경우
	    document.addEventListener('click', function(event) {
			let search_result = document.getElementById("search_result");
			let search_account_number = document.getElementById("search_account_number");
	 		let search_warn_msg = document.getElementById("search_warn_msg");
	        
	        // 클릭된 요소가 검색 결과 박스 내부에 있는지 확인
	        let isClickedInsideSearchBox = search_result.contains(event.target);  // 한 요소가 다른 요소를 포함하는지를 판별 . 즉, 검색 결과 박스 내부에 클릭된 요소가 포함되어 있는지를 판별
	        let isClickedOnSearchInput = (event.target == search_account_number); // 검색 input 필드에 직접 클릭했을 경우에만 true를 반환하고, 그 외의 경우엔 false를 반환

	        // 검색 결과 박스가 열려 있고, 검색 input 이외의 곳을 클릭한 경우
	        if (!isClickedInsideSearchBox && !isClickedOnSearchInput && search_result.style.display == 'block') {
				search_result.style.display = "none";
				search_warn_msg.innerHTML = "";
	        }
	    });
	 	
	 	// 검색 결과 중 하나를 선택했을 경우
	 	function change_searchinfo( account_number) {
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
				// 계정 비활성화 여부 
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
				
				if(search_data.account_result.bank_name == '카카오뱅크'){
					search_bank_name_position.style.width = "105px";
				}else{
					search_bank_name_position.style.width = "75px";
				}
				
				search_user_id.innerHTML = search_data.account_result.user_id;
				search_now_money.innerHTML = search_data.account_result.now_money;
				search_account_color.style.background = search_data.account_result.account_color;
			 })
		     .catch(error => {
			     console.error('처리 중 오류 발생', error);
			     search_warn_msg.innerHTML = "통신 중 문제가 발생했습니다.";
			     search_warn_msg.style.color = "red";
		     });
			
			// 검색이 완료되었으니 검색 박스 none
			let search_result = document.getElementById("search_result");
			search_result.style.display = "none";
			// 본인인증 버튼 활성화
			document.getElementById("user_self_check_button").disabled = false;
		}
	 	
	 	
	 	let update_ok = "no";
	 	function change_ok(f) {
	 		let change_key = f.change_info.placeholder;
			let change_data = f.change_info.value;
	 		let user_id = document.getElementById("search_user_id").innerHTML;
	 		let account_number = document.getElementById("search_account").innerHTML;
	 		let change_form_warn_msg = document.getElementById("change_color_msg");
			
			let param;
			let url;	
			let onlynumber;
			
			// 사용자 이름 수정
			if(change_key == '변경할 이름을 입력해 주세요'){
				// 유효성 체크				
				onlynumber = /^[a-zA-Z가-힣]*$/;
				if(!onlynumber.test(change_data) || change_data == ''){
					change_form_warn_msg.innerHTML = "유효한 이름이 아닙니다.";
					change_form_warn_msg.style.color = "red";
					update_ok = "no";
					return;
				}
				change_form_warn_msg.innerHTML = "유효한 이름 입니다.";
				change_form_warn_msg.style.color = "green";
				update_ok = "yes";
				
			// 사용자 계정 비밀번호 수정
			}else if(change_key == '계정에 사용할 새로운 비밀번호를 입력해 주세요'){
				onlynumber =/^[a-zA-Z0-9]{8,18}$/;
				// 유효성 체크				
				if(!onlynumber.test(change_data) || change_data == ''){
					change_form_warn_msg.innerHTML = "비밀번호는 영문자, 숫자 8~18자리입니다.";
					change_form_warn_msg.style.color = "red";
					update_ok = "no";
					return;
				}
				change_form_warn_msg.innerHTML = "사용 가능한 비밀번호 입니다.";
				change_form_warn_msg.style.color = "green";
				update_ok = "yes";

			// 사용자 계정 전화번호 수정
			}else if(change_key == '새로운 전화번호를 입력해 주세요'){
				onlynumber = /^[0-9]{11}$/;
				// 유효성 체크				
				if(!onlynumber.test(change_data) || change_data == ''){
					change_form_warn_msg.innerHTML = "유효한 전화번호가 아닙니다.";
					change_form_warn_msg.style.color = "red";
					update_ok = "no";
					return;
				}else{
					// 전화번호 중복 체크
					param = "user_id="+user_id + "&user_tel="+change_data;
					url ="modify_ins_tel.do";
		
					sendRequest(url, param, function() {
						user_tel_update__before_ok( account_number, change_data, user_id );
			           }, "post");
				}

			// 계좌 비밀번호 수정
			}else if(change_key == '계좌에 사용할 새로운 비밀번호를 입력해 주세요'){
				// 유효성 체크				
				onlynumber = /^[0-9]{4}$/;
				if(!onlynumber.test(change_data) || change_data == ''){
					change_form_warn_msg.innerHTML = "비밀번호는 숫자 4자리입니다.";
					change_form_warn_msg.style.color = "red";
					update_ok = "no";
					return;
				}
				change_form_warn_msg.innerHTML = "사용 가능한 비밀번호 입니다.";
				change_form_warn_msg.style.color = "green";
				update_ok = "yes";
			}
		}
	 	
	 	
		// 전화번호 중복 체크 여부 
	 	function user_tel_update__before_ok(account_number, user_tel, user_id) {
			if( xhr.readyState == 4 && xhr.status == 200 ){
				let change_form_warn_msg = document.getElementById("change_color_msg");
				let data = xhr.responseText;
				let json = ( new Function('return '+data) )();
				if( json[0].result == 'clear' ){
					change_form_warn_msg.innerHTML = "사용 가능한 전화번호 입니다.";
					change_form_warn_msg.style.color = "green";
					update_ok = "yes";
					
				}else{
					change_form_warn_msg.innerHTML = "전화번호가 중복됩니다.";
					change_form_warn_msg.style.color = "red";
					update_ok = "no";
					return;
				}
			}
		}
		
		// 사용자 이름, 전화번호 비밀번호, 계좌 비밀번호 변경시 해당 폼 표시
	 	function change_name_pwd_tel() {
	 		document.getElementById("change_color").style.display = "none";
	 		document.getElementById("change_color_msg").innerHTML = "";
			
	 		document.getElementById("change_info").value = "";
	 		document.getElementById("change_info").style.display = "block";
	 		document.getElementById("change_send").style.display = "block";
		}
	 	
		// 사용자 이름 변경 폼 표시
	 	function change_user_name() {
	 		change_name_pwd_tel();
	 		document.getElementById("change_info").placeholder = "변경할 이름을 입력해 주세요";
		}
	 	
		// 사용자 비밀번호 변경 폼 표시
	 	function change_user_pwd() {
	 		change_name_pwd_tel();
	 		document.getElementById("change_info").placeholder = "계정에 사용할 새로운 비밀번호를 입력해 주세요";
		}
	 	
		// 사용자 전화번호 변경 폼 표시
	 	function change_user_tel() {
	 		change_name_pwd_tel();
	 		document.getElementById("change_info").placeholder = "새로운 전화번호를 입력해 주세요";
		}
	 	
		// 계좌 비밀번호 변경 폼 표시
	 	function change_account_pwd() {
	 		change_name_pwd_tel();
	 		document.getElementById("change_info").placeholder = "계좌에 사용할 새로운 비밀번호를 입력해 주세요";
		}
	 	
		// 계좌 색상 변경 폼 표시
	 	function change_account_color() {
	 		document.getElementById("change_info").style.display = "none";
	 		document.getElementById("change_info").value = "";
	 		
	 		document.getElementById("change_color_msg").innerHTML = "변경할 색상을 입력해 주세요";
	 		
	 		document.getElementById("change_color").style.display = "block";
	 		document.getElementById("change_color_msg").style.display = "block";
	 		document.getElementById("change_send").style.display = "block";
	 		
	 		// 이미 색상들이 배치되어 있을 경우
	 		let color_mini_list = document.querySelectorAll('.color_mini');
	 		if (color_mini_list.length > 0) {
	 			return;
	 		}
	 		
	 		// 색상 리스트	
			let color_list = ["#ff5145", "#ff763b", "#ffad33", "#ffd736", "#d0ff36", "#a8ff2e", "#68ff1c",
				"#52f760", "#63ffa4", "#63ffce", "#73fffa", "#73d7ff", "#73b7ff", "#73a2ff", "#737eff", 
				"#3d4f82", "#2c344a", "#1b202e", "#b473ff", "#d773ff", "#c95df5", "#f55df2"];
			
			// 색상 선택 div에 해당 색상과 클릭시 color_choic() 함수에 보내질 색상 데이터를 동적으로 기입한다.
			for(let i = 0; i < color_list.length; i++){
				let color_mini = document.createElement("div");
				color_mini.className = "color_mini";
				color_mini.id = color_list[i];
				color_mini.style.width = "15px";
				color_mini.style.height = "30px";
				color_mini.style.float = "left";
				color_mini.style.background = color_list[i];
				color_mini.style.flex = "1";
				color_mini.onclick = function() {
					color_choice(color_list[i]);
				};
				document.getElementById("change_color").appendChild(color_mini);
			}//for------------
		}
	 	
	 	// 통장 색상 선택
	 	function color_choice(color) {
			let search_account_color = document.getElementById("search_account_color");
			let change_color = document.getElementById("change_color");
			
			// 색상별 통장 색 변경
			search_account_color.style.background = color;
			change_color.value = color;
		}// color_choice----------
	 	
		// 사용자 정보 변경
	 	function change_user_info(f) {
			let change_key = f.change_info.placeholder;
			let change_data = f.change_info.value;
	 		let user_id = document.getElementById("search_user_id").innerHTML;
	 		let account_number = document.getElementById("search_account").innerHTML;
			let change_color = document.getElementById("change_color").value;
			
			let param;
			let url;	
			
			// 이름을 변경할 경우
			if(change_key == '변경할 이름을 입력해 주세요' && update_ok == 'yes'){
				param = "user_id="+user_id + "&user_name="+change_data;
				url ="user_id_update.do";
				
				sendRequest(url, param, function() {
					update_user_info( account_number );
		           }, "post");
				
			// 계정 비밀번호를 변경할 경우
			}else if(change_key == '계정에 사용할 새로운 비밀번호를 입력해 주세요' && update_ok == 'yes'){
				param = "user_id="+user_id + "&user_pwd="+change_data;
				url ="user_pwd_update.do";

				sendRequest(url, param, function() {
					update_user_info( account_number );
		           }, "post");
				
			// 계정 전화번호를 변경할 경우
			}else if(change_key == '새로운 전화번호를 입력해 주세요' && update_ok == 'yes'){
				param = "user_id="+user_id + "&user_tel="+change_data;
				url ="user_tel_update.do";

				sendRequest(url, param, function() {
					update_user_info( account_number );
		           }, "post");

			// 계좌 전화번호를 변경할 경우
			}else if(change_key == '계좌에 사용할 새로운 비밀번호를 입력해 주세요' && update_ok == 'yes'){
				param = "account_number="+account_number + "&account_pwd="+change_data;
				url ="account_pwd_update.do";

				sendRequest(url, param, function() {
					update_user_info( account_number );
		           }, "post");
			
			// 계좌 색상을 변경할 경우
			}else if(change_info.style.display != "block"){
				param = "account_number="+account_number + "&account_color="+change_color;
				url ="account_color_update.do";

				sendRequest(url, param, function() {
					update_user_info( account_number );
		           }, "post");
			}
		}
	 	
		// 사용자 정보 수정 성공 여부
		function update_user_info( account_number ) {
			if( xhr.readyState == 4 && xhr.status == 200 ){
				let data = xhr.responseText;
				let json = ( new Function('return '+data) )();
				
				// 변경 폼 비활성화
		 		document.getElementById("change_color").style.display = "none";
	 			document.getElementById("change_info").style.display = "none";
 				document.getElementById("change_send").style.display = "none";
 				
				if( json[0].result == 'clear' ){
			 		document.getElementById("change_color_msg").innerHTML = "수정이 완료되었습니다.";
	 				change_searchinfo( account_number );
				}else{
			 		document.getElementById("change_color_msg").innerHTML = "수정에 실패하였습니다.";
				}
			}
		}
	 	
	 	// 계좌 검색으로 사용자 정보 조회 
	 	function change_searchinfoFn(account_number) {
	 		let search_warn_msg = document.getElementById("search_warn_msg");
	 		
	 		// fetch 앞에 return을 붙이면 해당 함수를 호출했을때 프로미스 객체를 반환받을 수 있다.
	 		return fetch("change_searchinfo_account.do?account_number="+account_number)
	 		  .then(response => {
	               if (!response.ok) { // ==> xhr.readyState == 4 && xhr.status == 200
						search_warn_msg.innerHTML = "서버와 통신 중 문제가 발생했습니다.";
						search_warn_msg.style.color = "red";
	                   throw new Error('Network response was not ok');
	               }
	               return response.json();
	           })
	 		  // 에러 발생 시 호출
	          .catch(error => {
   			   search_warn_msg.innerHTML = "통신 중 문제가 발생했습니다.";
			   search_warn_msg.style.color = "red";
	           console.error('There was a problem with the fetch operation:', error);
	          });
		}
	 	
	 	let head_img_index = 1;
		let head_img_path = "/bank/resources/img/은행대표이미지";
	 	// 은행 대표이미지 출력
		function change_head_img(){
			head_img_index++;
			if(head_img_index > 3){
				head_img_index = 1;
			}
			document.getElementById("head_img_img").src = head_img_path + head_img_index + ".jpg";
			
			let head_content = [["꾸준히 키워나가는", "미래의 가능성", "black"],
							  ["늦은 밤, 당신에게", "꼭 필요한 은행", "white"],
							  ["강아지에 의한", "강아지를 위한 적금", "white"]];
			
			document.getElementById("head_content1").innerHTML = head_content[head_img_index-1][0];
			document.getElementById("head_content2").innerHTML = head_content[head_img_index-1][1];
			document.getElementById("head_content1").style.color = head_content[head_img_index-1][2];
			document.getElementById("head_content2").style.color = head_content[head_img_index-1][2];
		}
		
		// 1초간격으로 자동으로 change_head_img()함수를 호출한다
		setInterval("change_head_img()", 3000);
	 	
		// 사용자 비활성화 여부 변경
		function change_user_name_unknown(unknown_ok) {
			let user_id = document.getElementById("search_user_id").innerHTML;
			let account_number = document.getElementById("search_account").innerHTML;
			
			let param;
			let url;
			
			if(unknown_ok == 'no'){
				param = "user_id="+user_id;
				url ="user_remove.do";
			}else{
				let user_name = prompt("변경할 이름을 입력하여 주십시오.");
				// 취소
				if(user_name == null){
					return;
				}
				param = "user_id="+user_id + "&user_name="+user_name;
				url ="user_name_open.do";
			}
			
			sendRequest(url, param, function() {
				change_user_name_unknownFn( account_number );
	           }, "post");
		}
		
		function change_user_name_unknownFn( account_number ) {
			if( xhr.readyState == 4 && xhr.status == 200 ){
				let data = xhr.responseText;
				let json = ( new Function('return '+data) )();
				
				if( json[0].result == 'clear' ){
					change_searchinfo( account_number);
				}else{
					alert("진행 실패");
				}
			}
		}
		
		// 사용자 정보 수정시 화면 상단으로 돌아가지 않고 고정시킨다.
		document.addEventListener('DOMContentLoaded', function() {
			document.querySelectorAll('.no_scroll').forEach(function(element) {
			    element.addEventListener('click', function(event) {
			        event.preventDefault(); // 기본 이벤트 방지
			        // 현재 스크롤 위치 저장
			        var scrollY = window.scrollY || window.pageYOffset;
			        // body에 lock-scroll 클래스 추가
			        document.body.classList.add('lock-scroll');
			        // 스크롤 위치를 고정
			        window.scrollTo(0, scrollY);
			    });
			});
		});
		
		// 본인인증 완료 여부		
		function user_self_check_ok() {
			let user_check_background = document.getElementById("user_check_background");
			user_check_background.style.display = "block";
		}
		
		// 본인인증 창 닫기		
		function close_user_self(f) {
			//본인인증 폼 초기화
			f.reset();		
			clearInterval(intervaled_user_self);
			sixnumber = 0;
			user_check_timer_min = 2;
			user_check_timer_sec = 30;
			document.getElementById("user_tel_check_button").value="인증하기"; 
			document.getElementById("user_check_timer_msg").innerHTML = "";
			document.getElementById("check_user_tel_msg").innerHTML = "계정에 등록되어 있는 전화번호를 입력하여 주십시오";
			document.getElementById("check_user_tel_msg").style.color = "gray";
			document.getElementById("user_check_background").style.display = "none";
		}
		
		function change_toproduct() {
			document.getElementById("account_container").style.display = "none";
			document.getElementById("seeMyaccount").style.display = "none";
			document.getElementById("seeMyproduct").style.display = "block";
			document.getElementById("product_box").style.display = "block";
			document.getElementById("change_account_to_product").onclick =  function() {
		        location.href = 'account_list.do'; 
		    };
		}
		
	</script>
	</head>

	<body>
		<div id="container">
		
			<!-- 관리자 화면에서 보여지는 사용자 본인인증 jsp -->
			<div id="user_check_background" style="display: none;">
				<jsp:include page="/WEB-INF/views/account/userchange_check.jsp"></jsp:include>
			</div>

			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
			
			<div id="head_img"> 
				<img id="head_img_img" src="/bank/resources/img/은행대표이미지1.jpg">
				<h1 id="head_content"> <span id="head_content1">꾸준히 키워나가는</span> <span id="head_content2"> 미래의 가능성 </span> </h1>
			</div>
				
			<div class="account_content">
			
				<!-- 계좌 리스트 박스 -->		
				<div class="account_box" id="account_box">
					<img src="/bank/resources/img/원화환전.png" id="change_account_to_product" onclick="change_toproduct();" style="position: absolute; left: 360px; width: 30px; height: 30px; margin-top: 20px; cursor: pointer; z-index: 900;">
					
					<h2 class="seeMyaccount" id="seeMyaccount">내 계좌 보기</h2>
					<h2 class="seeMyproduct" id="seeMyproduct" style="display: none;">내 예적금 보기</h2>
					<div id="account_container" class="mySwiper">
						<div id="account_slide" class="swiper-wrapper" >
							<c:forEach var="vo" items="${account_list}" >
								<div class="swiper-slide" onclick="send('${vo.account_number}');">
								
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
					
						<div class="mySwiper_product" id="product_box" style="display: none;">
								<div class="swiper-wrapper" >
								<c:forEach var="vo" items="${product_list}" >
									<div class="swiper-slide" >
										<div class="card_shape">
											<div class="card_main_content">
												<h3 style="position: absolute; top: -120px; right: -40px;">${vo.account_productname}</h3>
												<h4>현재 금액 : ${vo.saving_money }원</h4>
											</div>
											
											
											<img src="/bank/resources/img/심.png" class="card_sim" >
											<img src="/bank/resources/img/개.png" class="card_design" >
										</div>
										<div class="card_hidden_content">
											<h3>${vo.account_productname}</h3>
											<h5>현재 금액 : ${vo.saving_money }원</h5>
											<h5>계약 금액 : ${vo.products_deal_money}원</h5>
											<span class="card_date">${vo.products_date} ~ ${vo.endproducts_date}</span>
											<h5>연결계좌 : ${vo.account_number}</h5>
											<h5>연결계좌 : ${vo.account_number}</h5>
										</div>
									</div>
								</c:forEach>
			
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
						<br> <span id="search_warn_msg"></span>
						<div id="search_result" ></div>
					</div>
											
					<div class="account_slide" >
						<div id="search_info">
							<h4 id="search_user_name_position"> 계정 활성화 여부 :<span id="search_user_name"></span></h4>
							<h4 id="search_bank_name_position"> <span id="search_bank_name"></span></h4>
							<h4 id="search_user_id_position">아이디 : <span id="search_user_id"></span> 님</h4>
							<h4 id="search_user_account_position">계좌 번호 : <span id="search_account"> </span></h4>
							<h4 id="search_tel_position">전화 번호 : <span id="search_tel"> </span></h4>
							<h4 id="search_now_money_position">현재 잔액 : <span id="search_now_money"> </span> \</h4>
							<h4 id="search_account_color_position">통장 색상 : <span id="search_account_color"></span></h4>
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
							<a href="#" onclick="change_user_name_unknown('yes')" class="no_scroll">계정 활성화</a>
							<a href="#" onclick="change_user_name_unknown('no')" class="no_scroll">계정 비활성화</a>
						</div>
						<div class="update_userinfo">
							<h4>계정 정보 수정 및 변경</h4>
							<a href="#" id="change_user_name" onclick="change_user_name();" class="no_scroll">계정 이름 변경</a>
							<a href="#" id="change_user_pwd" onclick="change_user_pwd();" class="no_scroll">계정 비밀번호 변경</a>
							<a href="#" id="change_user_tel" onclick="change_user_tel();" class="no_scroll">전화번호 변경</a>
						</div>
						
						<div id="update_userinfo">
							<h4>계좌 정보 수정 및 변경</h4>
							<a href="#" id="change_account_pwd" onclick="change_account_pwd();" class="no_scroll">계좌 비밀번호 변경</a>
							<a href="#" id="change_account_color" onclick="change_account_color();" class="no_scroll">계좌 색상 변경</a>
						</div>
						

						<form id="change_form" style="width: 700px; height: 60px; margin-top: 20px;">
							<span id="change_color_msg" style="width: 600px; height: 30px;"></span>
							<div id="change_color" style="width: 500px; height: 30px; display: none;"></div>
							<input name="change_info" id="change_info" oninput="change_ok(this.form);" style="width: 350px; height: 25px; display: none;">
							<input type="button" id="change_send" value="진행" onclick="change_user_info(this.form);" style="display: none; height: 28px; margin-top: -30px; background: black; color: white; margin-left: 360px;">
							<input type="hidden" id="change_color" style="display: none;">
						</form>
					</div>
					
					<!-- 본인인증 jsp를 block 해주는 div -->	
					<div id="user_self_check_box" style=" width: 610px; height: 440px;  border-radius: 20px; background: #b5b5b5; opacity: 0.9; position: absolute; top:150px; left:650px; z-index: 100;">
						<h3 style="margin: 200px auto 30px; width: 440px; ">사용자 정보 수정을 위해 본인인증이 필요합니다.</h3>
						<input type="button" id="user_self_check_button" value="본인인증" onclick="user_self_check_ok();" disabled="disabled" style="margin-left: 200px; width: 200px; height: 35px; font-size: 20px; background-color: #1f2021; color: white; cursor: pointer;">
					</div>
				</div>
				
				<!-- 환율 그래프, 환율 게시판 박스 -->		
				<div id="rate_body">
						<div id="chart_div">
						<h2 style="margin-left: 30px;">﻿한달 누적 환율 그래프</h2>
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
					<jsp:include page="/WEB-INF/views/footer_header.jsp"></jsp:include>
				</div>
		</div>
	</body>
</html>