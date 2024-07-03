/**
 header용 js
 */
 		function user_info_check(user_id) {
			let user_pwd = prompt("비밀번호를 입력하세요");
				    
			if (user_pwd !== null) { // 사용자가 입력을 취소하지 않은 경우
			
				let url = "user_infocheck.do";
				let param = "user_id="+user_id + "&user_pwd="+user_pwd;
				
				sendRequest(url, param, user_infoFn, "post");
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
					alert("비밀번호 불일치.");
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
			let setting_category = document.getElementById("setting_category");
			setting_category.style.display = "none";
		}