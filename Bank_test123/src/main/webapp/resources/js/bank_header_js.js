/**
 header용 js
 */
 	function sideMenu_open(sideMenu_number) {
			let sideMenu = document.getElementById(sideMenu_number);

			let oldstyle = document.getElementById("oldstyle");
			if(oldstyle){
				oldstyle.remove();
			}
			
			for(let i = 1; i < 5; i ++){
				let sideMenu_str = "sideMenu" + i;
				let sideMenu_check = document.getElementById(sideMenu_str);

				
				if(sideMenu_str == sideMenu_number && sideMenu.style.display == "block"){
					sideMenu_check.style.display = "none";
					return;
				}

				if(sideMenu_check.style.display == "block"){
					sideMenu_check.style.display = "none";
				}
				
			}
			
		    // 동적 <style> 요소 생성
	        let styleSheet = document.createElement("style");
	        styleSheet.type = "text/css"; // JavaScript를 사용하여 동적으로 생성된 <style> 요소의 타입을 설정하는 코드
										// CSS 파일이 아닌 HTML 문서 내에서 스타일을 정의할 때는 대부분 text/css를 사용
	        styleSheet.id = "oldstyle"
			// 동적 키프레임 정의
			let keyframes_side_show = "@keyframes side_show { 0% { width: 0px; height: 0px; } "
	        												+"30% { width: 150px; height: 0px; } "
	        												+"100% { width: 150px; height: 190px; } } #body li ul{ animation: side_show 0.5s linear forwards; }";
	        // <style> 요소에 키프레임 애니메이션 추가
	        styleSheet.innerHTML = keyframes_side_show;
	        
	        document.head.appendChild(styleSheet);
	        
			sideMenu.style.display = "block";
		}// sideMenu_open---------------------------
 
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
				
				console.log(data);
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
			
			let header = document.getElementById("header");
			
			if(header){
				header.style.width = "100%";
			}

		}
		
		function close_settings() {
			document.getElementById("user_info_update_pwd_check").style.display = "none";
			let setting_category = document.getElementById("setting_category");
			setting_category.style.display = "none";
		}