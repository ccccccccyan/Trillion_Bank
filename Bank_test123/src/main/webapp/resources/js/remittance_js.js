let check_remittance = "no";

		function send(f) {
		    let account_number = f.account_number.value;
		    let target_account_number = f.target_account_number.value;
		    let deal_money = Number(f.deal_money.value);
		    let now_money = Number(f.now_money.value);
		    let target_account_warn_msg = document.getElementById("target_account_warn_msg");
		    let deal_money_warn_msg = document.getElementById("deal_money_warn_msg");
		    let send_button = document.getElementById("send_button");

		    let onlynumber = /^[0-9]{10,14}$/;
		    let onlynumberdeal_money = /^[0-9]+$/;

		    // 계좌번호 유효성 검사
		    if (!onlynumber.test(target_account_number)) {
		        target_account_warn_msg.innerHTML = "계좌번호는 숫자 10~14자리입니다.";
		        target_account_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return;
		    }
		    target_account_warn_msg.innerHTML = "";

		    // 출금계좌와 입금계좌가 동일한지 확인
		    if (account_number == target_account_number) {
		        target_account_warn_msg.innerHTML = "출금계좌와 입금계좌가 동일합니다.";
		        target_account_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return;
		    }
		    target_account_warn_msg.innerHTML = "";

		    // 거래금액 유효성 검사
		    if (!onlynumberdeal_money.test(deal_money) || deal_money <= 0) {
		        deal_money_warn_msg.innerHTML = "유효한 거래 금액을 입력해주세요.";
		        deal_money_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return;
		    }
		    deal_money_warn_msg.innerHTML = "";

		    // 잔액이 부족한지 확인
		    if (now_money < deal_money) {
		        deal_money_warn_msg.innerHTML = "잔액이 부족합니다.";
		        deal_money_warn_msg.style.color = "red";
		        send_button.disabled = true;
		        check_remittance = "no";
		        return;
		    }
		    deal_money_warn_msg.innerHTML = "";

		    // 모든 유효성 검사가 완료된 후 비밀번호 유효성 검사
		    check_account(f);
		}

		function check_account(f) {
		    let send_button = document.getElementById("send_button");
		    let account_number = f.account_number.value;
		    let target_account_number = f.target_account_number.value;
		    let deal_money = Number(f.deal_money.value);
		    let url = "checkaccount.do";
		    let param = "account_number=" + account_number + "&target_account_number=" + target_account_number + "&deal_money=" + deal_money; // "account_number=" + account_number + "&account_pwd=" + encodeURIComponent(input_pwd) + "&target_account_number=" + target_account_number + "&deal_money=" + deal_money;
		    sendRequest(url, param, function () { resultFn(f); }, "post");
		}

		function resultFn(f) {
		    if (xhr.readyState == 4 && xhr.status == 200) {
		        let data = xhr.responseText;
		        let json = (new Function('return ' + data))();
		        let target_account_warn_msg = document.getElementById("target_account_warn_msg");
		       
		        let send_button = document.getElementById("send_button");
		        let deal_money_warn_msg = document.getElementById("deal_money_warn_msg");

		        if (json[0].result == 'no_account') {
		            target_account_warn_msg.innerHTML = "존재하지 않는 계좌번호입니다.";
		            target_account_warn_msg.style.color = "red";
		            send_button.disabled = true;
		            check_remittance = "no";
		            return;
		        }else {
		        	target_account_warn_msg.innerHTML = "";
		            //account_input_pwd_warn_msg.innerHTML = "";
		            let account_number = f.account_number.value;
		            let target_account_number = f.target_account_number.value;
		            let deal_money = Number(f.deal_money.value);

		            document.getElementById("imageContainer").innerHTML = '<img width="50px" height="50px" src="/bank/resources/img/' + json[0].target_bank_name + '.png">';
		            document.getElementById("targetUserName").innerText = json[0].target_user_name + "님께";
		            document.getElementById("targetBankName").innerText = json[0].target_bank_name + " " + json[0].target_account_number;
		            document.getElementById("dealMoney").innerText = json[0].deal_money + "원";
		            document.getElementById("accountnumber").value = json[0].account_number;
		            document.getElementById("targetaccountnumber").value = json[0].target_account_number;
		            check_remittance = "yes";

		            if (target_account_number != '' && account_number != '') {
		                send_button.disabled = false;
		            } else {
		                send_button.disabled = true;
		            }
		        }
		    }
		}

		function fn_send(f) {
		   if (check_remittance == 'yes') {
		    console.log("하하하하하ㅏㅏㅏㅏㅏㅏ");
		    let account_number = f.account_number.value;
		    let target_account_number = f.target_account_number.value;

		    document.getElementById("confirmform").style.opacity = "1";
		    document.getElementById("confirmform").style.top = "200px";

		    var element = document.getElementById('confirmform');
		        document.getElementById("blockall").style.display = "block";

		    //element.addEventListener('transitionend', function (event) {
		    	//if(event.target.style.opacity == '1'){
		    	//}
		    //});
		      //  return;
		    }else{ 
		    document.getElementById("passwordInput").style.display = "none";
		    document.getElementById("blockall").style.display = "none";
		    }
		
		}
		
		
		function showPasswordInput() {
			document.getElementById("confirmform").style.opacity = "0";
            // 다음 버튼 클릭 시 비밀번호 입력창을 보여주는 함수입니다.
            
            document.getElementById("passwordInput").style.display = "block";
        }
		
		
		function check_pwd(ff) {
			 let input_pwd = ff.input_pwd.value;
			 let account_input_pwd_warn_msg = document.getElementById("account_input_pwd_warn_msg");
			 let onlynumberpwd = /^[0-9]{4}$/;
			 let account_number = document.getElementById("account_number").value;
			 let target_account_number = document.getElementById("target_account_number").value;
			 let deal_money = document.getElementById("deal_money").value;
			 console.log("dsajkldjsalkj target : " + target_account_number+ "deal_money" + deal_money + "account_number" + account_number);
			 //비밀번호 유효성 검사
			 if (!onlynumberpwd.test(input_pwd)) {
			        account_input_pwd_warn_msg.innerHTML = "계좌 비밀번호는 숫자 4자리입니다.";
			        account_input_pwd_warn_msg.style.color = "red";
			        send_button.disabled = true;
			        check_remittance = "no";
			        return;
			 } 
			 account_input_pwd_warn_msg.innerHTML = "";
		
			 let url = "remittance_pwd_chk.do";
			 let param = "account_number=" + account_number + "&account_pwd=" + encodeURIComponent(input_pwd) + "&target_account_number=" + target_account_number + "&deal_money=" + deal_money;
			    sendRequest(url, param, resultcheckpwd, "post");
			}
			function resultcheckpwd(){
			if (xhr.readyState == 4 && xhr.status == 200) {
			        let data = xhr.responseText;
			        let json = (new Function('return ' + data))();
			        let account_input_pwd_warn_msg = document.getElementById("account_input_pwd_warn_msg");
			        let send_button = document.getElementById("send_button");
			        if (json[0].account_lockcnt == '5') {
		                alert("계좌 비빌번호 5회 실패! 일조은행에 문의해주세요.");
		                location.href = "account_list.do";
		            }
			        
			        if (json[0].result == 'no') {
		                account_input_pwd_warn_msg.innerHTML = json[0].account_lockcnt + "/5 비밀번호 불일치";
		                account_input_pwd_warn_msg.style.color = "red";
		                return;
		            }else {
		                account_input_pwd_warn_msg.innerHTML = "";
		                document.getElementById("imageContainer2").innerHTML = '<img width="50px" height="50px" src="/bank/resources/img/' + json[0].target_bank_name + '.png">';
		                document.getElementById("target_UserName").innerText = json[0].target_user_name + "님께";
		                document.getElementById("target_BankName").innerText = json[0].target_bank_name + " " + json[0].target_account_number;
		                document.getElementById("deal_Money").innerText = json[0].deal_money + "원";
		                document.getElementById("account_number").value = json[0].account_number;
		                document.getElementById("target_account_number2").value = json[0].target_account_number;
		                document.getElementById('now_money').textContent = '잔액: ' + json[0].now_money + '원';
		                document.getElementById("passwordInput").style.display = "none";
		                document.getElementById("blockall").style.display = "none";
						
						document.getElementById("confirmform").style.opacity = "0";
			            document.getElementById("confirmform").style.top = "700px";
			            document.getElementById("blockall").style.display = "none";
		                // remittance_form 표시
		                document.getElementById("remittance_form").style.display = "block";
		                document.getElementById("remittance_form").style.opacity = "1";
		                document.getElementById("remittance_form").style.top = "200px";
		                document.getElementById("blockall").style.display = "block";
		           }
		      }
		}
		
		function cancelTransaction() {
            document.getElementById("confirmform").style.opacity = "0";
            document.getElementById("confirmform").style.top = "700px";
            document.getElementById("blockall").style.display = "none";
        }
		function passwordInputcancel(){
			document.getElementById("confirmform").style.opacity = "0";
            document.getElementById("confirmform").style.top = "700px";
            document.getElementById("blockall").style.display = "none";
            document.getElementById("passwordInput").style.display = "none";
            document.getElementById("passwordForm").reset();
            
		}
		function allcancel(){
			document.getElementById("confirmform").style.opacity = "0";
            document.getElementById("confirmform").style.top = "700px";
            document.getElementById("blockall").style.display = "none";
            document.getElementById("passwordInput").style.display = "none";
            document.getElementById("remittance_form").style.opacity = "0";
            document.getElementById("remittance_form").style.top = "700px";
            document.getElementById("form1").reset();
            document.getElementById("passwordForm").reset();
            location.reload(true); //페이지 새로고침 캐시 무시
  		}
		function sendlist(fff) {
			let account_number = fff.account_number.value;
			fff.method = "post";
			location.href = "account_info.do?account_number=" + account_number;
			
		}