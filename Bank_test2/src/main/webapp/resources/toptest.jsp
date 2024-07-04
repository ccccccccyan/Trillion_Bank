<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	
		<style>
			 #confirmform {
			 	position: absolute;
			 	opacity: 0;
	            top: 500px;
	            left: 50%;
	           /*  transform: translate(-50%, -50%); */
	            background-color: #fff;
	            padding: 20px;
	            border-radius: 8px;
	            box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	            z-index: 1000; /* 다른 요소 위에 띄우기 위해 z-index 설정 */
	            max-width: 80%; /* 최대 너비 설정 */         
	            transition-property: top, opacity ;   
	           transition-duration: 1s; 
	           transition-delay: 0.3s;
	            
	        }
		</style>
		
		<script>
			function view() {
				let confirmform = document.getElementById("confirmform");
			
				confirmform.style.opacity = "1";
				confirmform.style.top = "200px";
			}
		</script>
	</head>
	
	<body>
		<div id="confirmform">dasdashdjsavdhdbashdba</div>
		<input type="button" value="sadsd" onclick="view();">
	</body>
</html>