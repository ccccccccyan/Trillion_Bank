/**
메인 페이지 작동 파일
 */
 		//account.jsp-------------------------------------------------------
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
		
		
 		//account_insert_form.jsp-------------------------------------------------------
		
		function bank_choice(choice_name) {
			let bank_name = document.getElementById("bank_name");
			bank_name.value = choice_name;
			
			if(choice_name == "일조"){
				color_choice("#1b202e");
			}
			
		}	
			
		function send_check(f) {
			let bank_name = f.bank_name.value;
			let account_number = f.account_number.value.trim();
			let account_pwd = f.account_pwd.value.trim();
			let send_button = document.getElementById("send_button");
				
			if(bank_name != '' && account_number != '' && account_pwd != '' && account_no == 'yes'){
			send_button.disabled = false;
			}else{
			send_button.disabled = true;
			}
		}
		
		function account_insert(f) {
			let bank_name = f.bank_name;
			bank_name.disabled = false;
			let account_number = f.account_number.value.trim();
			f.action="account_insert.do?user_id=${param.user_id}";
			f.submit();
		}
		
		//--------------------------------------------
