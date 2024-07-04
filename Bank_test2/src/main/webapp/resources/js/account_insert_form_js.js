	// 계좌 번호 중복 확인 여부
	let account_no = "no";
	
	window.onload = function() {
		// 은행 리스트
		let bank_list = ["일조","ibk", "국민", "농협", "비씨", "새마을", "시티", "신한", "우리", "카카오뱅크", "토스", "하나", "우체국", "현대", "롯데"];
		
		let bank_box = document.getElementById("bank_box");
		
		// 은행 icon div에 해당 은행별 이미지와 클릭시 bank_choice() 함수에 보내질 은행 이름을 동적으로 기입한다.
		for(let i = 0; i < bank_list.length; i++){
			let bank_mini = document.createElement("div");
			bank_mini.className = "bank_mini";
			bank_mini.id = bank_list[i];
			bank_mini.onclick = function() {
				bank_choice(bank_list[i]);
			};
				
			bank_box.appendChild(bank_mini);
			
			let bank_img = document.createElement("img");
			bank_img.className = "bank_img";
			bank_img.src = "/bank/resources/img/" + bank_list[i] + ".png"
			
			bank_mini.appendChild(bank_img);
		}//for---------------
		
		// 색상 리스트	
		let color_list = ["#ff5145", "#ff763b", "#ffad33", "#ffd736", "#d0ff36", "#a8ff2e", "#68ff1c",
			"#52f760", "#63ffa4", "#63ffce", "#73fffa", "#73d7ff", "#73b7ff", "#73a2ff", "#737eff", 
			"#3d4f82", "#2c344a", "#1b202e",
			"#b473ff", "#d773ff", "#c95df5", "#f55df2"];
		
		let color_box = document.getElementById("color_box");
		
		// 색상 선택 div에 해당 색상과 클릭시 color_choic() 함수에 보내질 색상 데이터를 동적으로 기입한다.
		for(let i = 0; i < color_list.length; i++){
			let color_mini = document.createElement("div");
			color_mini.className = "color_mini";
			color_mini.id = color_list[i];
			color_mini.style.background = color_list[i];
			color_mini.onclick = function() {
				color_choice(color_list[i]);
			};
			color_box.appendChild(color_mini);
		}//for------------
	}//	window.onload------------------
	
	// 색상 선택시 호출되는 함수	
	function color_choice(color) {
		let insert_account_front = document.getElementById("insert_account_front");
		let insert_account_end = document.getElementById("insert_account_end");
		let account_color = document.getElementById("account_color");
		
		let account_form_box = document.getElementById("account_form_box");
		let bank_name = document.getElementById("bank_name");
		let account_number = document.getElementById("account_number");
		
		// 색상별 글자 색 변경
		if(color == "#2c344a" || color == "#1b202e"){
			account_form_box.style.color = "#fff";
			bank_name.style.color = "#fff";
			account_number.style.color = "#fff";
		}else{
			account_form_box.style.color = "#171a21";
			bank_name.style.color = "#171a21";
			account_number.style.color = "#171a21";
		}
		
		// 색상별 통장 색 변경
		insert_account_front.style.background = color;
		insert_account_end.style.background = color;
		account_color.value = color;
	}// color_choice----------
		

	
	
	// 선택한 은행별 데이터 변경
	function bank_choice(choice_name) {
		let bank_name = document.getElementById("bank_name");
		bank_name.value = choice_name;
		
		// 일조 은행 선택시 통장 색 변경 함수 호출
		if(choice_name == "일조"){
			color_choice("#1b202e");
		}
	}// bank_choice-------------	

	// 계좌번호 유효성 체크	
	function send_check(f) {
		let bank_name = f.bank_name.value;
		let account_number = f.account_number.value.trim();
		let account_warn_msg = document.getElementById("account_warn_msg");
		let send_button = document.getElementById("send_button");
		
		let pattern = /^[0-9]*$/;
		
		if(!pattern.test(account_number)){
			 account_warn_msg.innerHTML = "계좌번호는 숫자 10 ~ 14자리입니다."
			 account_warn_msg.style.color = "red";
             send_check_no = "no";
	         send_button.disabled = true;
             return;
		}
		account_warn_msg.innerHTML="";
		
		let url = "account_number_check.do";
		let param = "account_number="+account_number;
		
		// 계좌 번호 중복 체크
		sendRequest(url, param, function() {
               check_resultFn(f);
           }, "post");
	}
	
	// 계좌번호 중복 체크 결과 확인	
	function check_resultFn(f) {
		if(xhr.readyState == 4 && xhr.status == 200){
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();
			let account_warn_msg = document.getElementById("account_warn_msg");
			let send_button = document.getElementById("send_button");
			
			if(json[0].result == 'clear'){
				account_warn_msg.innerHTML = "사용 가능한 계좌 번호입니다.";
				account_warn_msg.style.color = "green";
				account_no = "yes";
			}else{
				account_warn_msg.innerHTML = "이미 사용중인 계좌 번호입니다.";
				account_warn_msg.style.color = "red";
				account_no = "no";
	            send_button.disabled = true;
				return;
			}
			
			let account_pwd = f.account_pwd.value.trim();
			let pwd_warn_msg = document.getElementById("pwd_warn_msg");
			let pattern = /^[0-9]*$/;

			if(!pattern.test(account_pwd)){
				 pwd_warn_msg.innerHTML = "유효하지 않은 형식입니다."
	             send_button.disabled = true;
				 return;
			}else{
				 pwd_warn_msg.innerHTML="";
			}
			// 모든 유효성 체크와 계좌 번호 중복 확인이 정상적으로 완료됐을 경우
			send_check_fn(f);
		}
	}// check_resultFn-----------
	
	// 모든 작성이 정상적으로 완료됐는지 여부 확인		
	function send_check_fn(f) {
		let send_button = document.getElementById("send_button");
		let bank_name = f.bank_name.value;
		let account_number = f.account_number.value.trim();
		let account_pwd = f.account_pwd.value.trim();
	
		// 전송 버튼 활성화
		if(bank_name != '' && account_number != '' && account_pwd != '' && account_no == 'yes'){
			send_button.disabled = false;
		}else{
			send_button.disabled = true;
		}
	}
	
	// 계좌 추가	
	function account_insert(f) {
		let bank_name = f.bank_name;
		bank_name.disabled = false;
		let account_number = f.account_number.value.trim();
		f.action="account_insert.do?user_id=${user_id}";
		f.submit();
	}
		