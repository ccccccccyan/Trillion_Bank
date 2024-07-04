	window.onload = function () {
		// miss_info : 세션에 저장된 user_id와 파라미터로 받은 user_id가 다를 경우 생기는 데이터 
		let miss_info = "${miss_info}";
		
		if(miss_info == "잘못된 접근입니다."){
			alert(miss_info);
			location.href = "account_list.do";
		}

		let account_box = document.getElementById("account_box");

		// 계좌 리스트는 user_id가 있을 때만(로그인된 상태일 경우), 보여진다.
		let user_id = "${user_id}"; 
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