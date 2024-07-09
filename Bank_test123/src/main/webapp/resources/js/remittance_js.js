let check_remittance = "no";
		function send(f) {
			 
			let account_number = f.account_number.value;
			let input_pwd = f.input_pwd.value;
			let target_account_number = f.target_account_number.value;
			let deal_money = Number(f.deal_money.value);
			let now_money = Number(f.now_money.value);
			let target_account_warn_msg = document.getElementById("target_account_warn_msg");
			let account_input_pwd_warn_msg = document.getElementById("account_input_pwd_warn_msg");
			let send_button = document.getElementById("send_button");
			let deal_money_warn_msg = document.getElementById("deal_money_warn_msg");
			
			 // 10~14자리의 숫자로만 이루어져 있는지 검사 공백은 포함안함!
		    let onlynumber = /^[0-9]{10,14}$/;
		    let onlynumberdeal_money = /^[0-9]+$/;
		    let onlynumberpwd = /^[0-9]{4}$/;
		    if (!onlynumber.test(target_account_number)) {
		        target_account_warn_msg.innerHTML = "계좌번호는 숫자 10~14자리입니다.";
		        target_account_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return; // 유효하지 않으면 함수 종료
		    }
		    target_account_warn_msg.innerHTML="";
			
			if (account_number == target_account_number){
		    	target_account_warn_msg.innerHTML = "출금계좌와 입금계좌가 동일합니다.";
		        target_account_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return;
		    }
		    target_account_warn_msg.innerHTML="";
			
			
		    //비밀번호 유효성체크
		    if (!onlynumberpwd.test(input_pwd)) {
		        account_input_pwd_warn_msg.innerHTML = "계좌 비밀번호는 숫자 4자리입니다.";
		        account_input_pwd_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return; // 유효하지 않으면 함수 종료
		    }
		    account_input_pwd_warn_msg.innerHTML="";
		  	
		  	if(!onlynumberdeal_money.test(deal_money)){
		  		deal_money_warn_msg.innerHTML = "계좌 비밀번호는 숫자 4자리입니다.";
		        deal_money_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return; // 유효하지 않으면 함수 종료
		  	}
		  	deal_money_warn_msg.innerHTML="";
		  	
		    if(now_money < deal_money){
				deal_money_warn_msg.innerHTML = "잔액이 부족합니다.";
		        deal_money_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return; // 유효하지 않으면 함수 종료
			}
			deal_money_warn_msg.innerHTML="";
			
			if (!(deal_money > 0)) {
			    deal_money_warn_msg.innerHTML = "거래금액은 1원이상 입력해주세요.";
		        deal_money_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return; // 유효하지 않으면 함수 종료
			}
			deal_money_warn_msg.innerHTML="";
			
			let url = "remittance_pwd_chk.do";
			let param = "account_number="+account_number+"&account_pwd="+encodeURIComponent(input_pwd)+"&target_account_number="+target_account_number+"&deal_money="+deal_money;
			sendRequest(url, param, function(){resultFn(f);}, "post");
		}
			
		function resultFn(f){
			if( xhr.readyState == 4 && xhr.status == 200 ){
				let data = xhr.responseText;
				
				console.log("dadasdsadsaasd");
				console.log(data);
				
				let json = (new Function('return '+data))();
				let target_account_warn_msg = document.getElementById("target_account_warn_msg");
				let account_input_pwd_warn_msg = document.getElementById("account_input_pwd_warn_msg");
				let send_button = document.getElementById("send_button");
				let deal_money_warn_msg = document.getElementById("deal_money_warn_msg");
				
				if( json[0].result == 'no_account'){
					target_account_warn_msg.innerHTML = "존재하지 않는 계좌번호입니다.";
			        target_account_warn_msg.style.color = "red";
			        send_button.disabled = true;
			        check_remittance = "no";
			        return; // 유효하지 않으면 함수 종료
				}
				target_account_warn_msg.innerHTML="";
				
				if( json[0].result == 'no' ){
					account_input_pwd_warn_msg.innerHTML = "비밀번호 불일치";
			        account_input_pwd_warn_msg.style.color = "red";
			        send_button.disabled = true;
			        check_remittance = "no";
			        return; // 유효하지 않으면 함수 종료
				}else{ 
					account_input_pwd_warn_msg.innerHTML="";
					let account_number = f.account_number.value;
					let target_account_number = f.target_account_number.value;
					let deal_money = Number(f.deal_money.value);
					let now_money = Number(f.now_money.value);
					
					document.getElementById("imageContainer").innerHTML = '<img width="50px" height="50px" src="/bank/resources/img/' + json[0].target_bank_name + '.png">';
					document.getElementById("targetUserName").innerText = json[0].target_user_name + "님께";
					document.getElementById("targetBankName").innerText = json[0].target_bank_name + " " + json[0].target_account_number;
					document.getElementById("dealMoney").innerText = json[0].deal_money + "원"; 
					document.getElementById("accountnumber").value = json[0].account_number;
					document.getElementById("targetaccountnumber").value = json[0].target_account_number;					
					check_remittance = "yes";
					
					if(target_account_number != '' && account_number != ''){
				         send_button.disabled = false;
				      }else{
				         send_button.disabled = true;
				    }
				}
			}	
		}	
		
		function fn_send(f) {
			if(check_remittance != 'yes'){
				return;
			}
		    let account_number = f.account_number.value;
		    let target_account_number = f.target_account_number.value;

		    document.getElementById("confirmform").style.opacity = "1";
		    document.getElementById("confirmform").style.top = "200px";

		    var element = document.getElementById('confirmform');

		    element.addEventListener('transitionend', function(event) {
		        document.getElementById("blockall").style.display = "block";
		    });
		}