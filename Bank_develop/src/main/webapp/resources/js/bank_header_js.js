/**
 header용 js
 */
 	function sideMenu_open(sideMenu_number) {
			let sideMenu = document.getElementById(sideMenu_number);
			for(let i = 1; i < 5; i++){
				let sideMenu_str = "sideMenu" + i;
				let sideMenu_check = document.getElementById(sideMenu_str);
				
				if(sideMenu_str == sideMenu_number && sideMenu.style.height == "190px"){
					sideMenu_check.style.width = "0px";
					sideMenu_check.style.height = "0px";
					sideMenu_check.style.border = "none";
					return;
				}
				sideMenu_check.style.width = "0px";
				sideMenu_check.style.height = "0px";
				sideMenu_check.style.border = "none";
			}
			sideMenu.style.width = "190px";
			sideMenu.style.height = "190px";
			sideMenu.style.borderBottom = "6px solid #c0d9fc";
			sideMenu.style.borderRight = "3px solid #c0d9fc";
		}
 
 		function user_pwd_check_open() {
			document.getElementById("user_info_update_pwd_check").style.display = "block";
		}
		
 		function user_info_check(user_id) {
			let user_pwd = document.getElementById("user_info_check_pwd").value;
			if (user_pwd != null && user_pwd != '') { // 사용자가 입력을 취소하지 않은 경우
				let url = "user_infocheck.do";
				let param = "user_id="+user_id + "&user_pwd="+user_pwd;
				
				sendRequest(url, param, user_infoFn, "post");
			}else{
				document.getElementById("user_pwd_check_warn_msg").innerHTML = "비밀번호를 입력해주세요";
				document.getElementById("user_pwd_check_warn_msg").style.color = "red";
			}
		}
			
		function user_infoFn() {
			if(xhr.readyState == 4 && xhr.status == 200){
				let data = xhr.responseText;
				let json = (new Function('return ' + data))();
				if(json[0].result == 'clear' ){
					location.href="user_info_modify_form.do";
				}else{
					document.getElementById("user_pwd_check_warn_msg").innerHTML = "비밀번호 불일치.";
				}
			}
		}		

		function open_settings(user_id) {
			let setting_category = document.getElementById("setting_category");
			setting_category.style.display = "block";
		}
		
		function close_settings() {
			let user_info_update_pwd_check = document.getElementById("user_info_update_pwd_check");
			if(user_info_update_pwd_check){
				user_info_update_pwd_check.style.display = "none";
			}
			
			let setting_category = document.getElementById("setting_category");
			setting_category.style.display = "none";
		}