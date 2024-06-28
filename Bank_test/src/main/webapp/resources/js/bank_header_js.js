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