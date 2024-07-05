<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	
	<style>
        html, body {
                margin: 0; 
                padding: 0;
                height: 100%; /* 추가: 부모 요소의 높이를 100%로 설정 */
           }
		
		li{list-style: none;}
			
		a{text-decoration: none;}
	
		#container{border: 1px solid #a4a2fa;
					width: 400px;
					height: 100%;
					background-color: rgb(127,179,250);
					position: relative;
		}

		#container #header img{position: absolute;
			width: 400px;
			height: 300px;
		}
		
		#container #body{position: absolute;
						top: 350px;}

		
		
		#body .mainMenu{font-size: 30px;
						font-style: normal;
						font-weight: bold;
						color: #24286e;
						margin-bottom: 20px;
						margin-left: 30px;
						width: 200px;
					}
		
		#body li{position: relative;}
					
		#body li ul{display: none;
					border: 1px solid #464cb3;
					width: 120px;
					position: absolute;
 					left: 160px; 
 					overflow: hidden;
 					background: white;
 					top: 0px;
					}

		.mainMenu{cursor: pointer;}

		#container #settings img{position: absolute;
			bottom: 10px;
			left: 10px;
			border: 1px solid;
			width: 120px;
			height: 150px;
		}
	</style>
		
	<script>
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
	        												+"30% { width: 150px; height: 0px; }"
	        												+"100% { width: 150px; height: 150px; } } #body li ul{ animation: side_show 0.5s linear forwards; }";
	        // <style> 요소에 키프레임 애니메이션 추가
	        styleSheet.innerHTML = keyframes_side_show;
	        
	        document.head.appendChild(styleSheet);
	        
			sideMenu.style.display = "block";
			
			
		}
	</script>	
		
	</head>
	
	<body>
		<div id="container">
			<div id="header"> <img src="/bank/resources/img/일조은행아이콘.png"> </div>

			<div id="body">
				<ul>
					<li>
						<div class="mainMenu" onclick="sideMenu_open('sideMenu1');">환율</div>
							<ul id="sideMenu1">
								<li class="sideMenu"><a href="#">환율 조회</a></li>
								<li class="sideMenu"><a href="#">환율 게시판</a></li>
							</ul>
					</li>
					
					<li>
						<div class="mainMenu" onclick="sideMenu_open('sideMenu2');">은행 안내</div>
							<ul id="sideMenu2">
								<li class="sideMenu"><a href="#">CEO인사말</a></li>
								<li class="sideMenu"><a href="#">비전</a></li>
								<li class="sideMenu"><a href="#">조직도</a></li>
								<li class="sideMenu"><a href="#">영업점 안내</a></li>
								<li class="sideMenu"><a href="#">찾아오시는 길</a></li>
							</ul>
					</li>
					
					<li>
						<div class="mainMenu" onclick="sideMenu_open('sideMenu3');">연혁</div>
							<ul id="sideMenu3">
								<li class="sideMenu"><a href="#">전체 일정</a></li>
								<li class="sideMenu"><a href="#">김서영 CEO</a></li>
								<li class="sideMenu"><a href="#">김지환 임원</a></li>
								<li class="sideMenu"><a href="#">오종하 임원</a></li>
								<li class="sideMenu"><a href="#">장민경 임원</a></li>
							</ul>
					</li>
					
					<li>
						<div class="mainMenu" onclick="sideMenu_open('sideMenu4');">자료실</div>
							<ul id="sideMenu4">
								<li class="sideMenu"><a href="#">채용정보</a></li>
								<li class="sideMenu"><a href="#">인재상</a></li>
								<li class="sideMenu"><a href="#">홍보센터</a></li>
								<li class="sideMenu"><a href="#">공지사항</a></li>
								<li class="sideMenu"><a href="#">FAQ (자주 묻는 질문)</a></li>
								<li class="sideMenu"><a href="#">Q&A</a></li>
							</ul>
					</li>
				</ul>
			
			</div>
					
			<div id="settings"> <img src="/bank/resources/img/설정1.png"> </div>
		</div>
	</body>
</html>