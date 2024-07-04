<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script>
			function testfunction(event) {
				let warn_msg = document.getElementById("warn_msg");
				let test_btn = document.getElementById("test_btn");
			    const input = event.target.value;

	            // 숫자 유효성 검사 (정규 표현식 사용)
	            const isValidNumber = /^\d*$/.test(input);

	            if (!isValidNumber) {
	                console.warn('Invalid input: Only numbers are allowed.');
	                warn_msg.innerHTML = "유효하지 않은 값입니다."
	                test_btn.disabled = true;
	                //event.target.value = input.replace(/\D/g, ''); // 숫자가 아닌 문자를 제거
	            }else{
		            warn_msg.innerHTML="";
	                test_btn.disabled = false;
	            }
				
			    console.log(event.type, event.target.value);
			}
			

		</script>
		
	</head>
	
	<body>
		<!-- 
			keydown: 키가 눌릴 때 발생합니다.
			keypress: 키가 눌릴 때 발생하며, 문자 입력과 관련된 키에 대해서만 발생합니다 
			(주로 deprecated 되어 사용이 권장되지 않습니다).
			keyup: 키가 눌렸다가 떼어질 때 발생합니다.
			
			진행 순 
			keydown -> keypress -> input -> keyup 
			
			value 변화
			keydown : 값 없음
			keypress : 값 없음
			input : 값은 들어왔으나 보여지지는 않고 있는 상태
			keyup : 값은 들어와있고 보여지는 상태
			
			
			event 객체는 HTML 요소에서 발생하는 이벤트에 대한 정보를 포함하는 객체입니다. 
			브라우저는 이벤트가 발생할 때마다 자동으로 이 객체를 생성하고 이벤트 핸들러 함수에 전달합니다. 
			event 객체는 이벤트의 종류, 발생 위치, 키보드 및 마우스 상태 등과 같은 다양한 정보를 제공합니다.
			
				event 객체의 주요 속성 및 메서드
				
					type: 이벤트의 유형을 나타내는 문자열입니다 (예: "click", "keydown", "input" 등).
					target: 이벤트가 발생한 DOM 요소를 참조합니다. 이는 이벤트가 발생한 요소를 가리키며, 이벤트 핸들러 내부에서 자주 사용됩니다. 즉, 이벤트가 트리거된 HTML 요소를 참조합니다. 이를 통해 이벤트가 발생한 요소에 직접 접근할 수 있으며, 그 요소의 속성이나 값을 가져오거나 변경할 수 있습니다.
					preventDefault(): 이벤트의 기본 동작을 방지합니다. 예를 들어, 폼 제출을 막거나 링크 클릭 시 페이지 이동을 막을 때 사용됩니다.
					stopPropagation(): 이벤트가 더 이상 상위 요소로 전파되지 않도록 합니다.
		 -->
		<input type="text" id="username" name="username" 
			onkeydown="testfunction(event);"
			onkeypress="testfunction(event);"
			onkeyup="testfunction(event);"
			oninput="testfunction(event);"
			>
			
		<div oninput=""></div>
		<span id="warn_msg"></span>
		<input type="button" value="전송" disabled="disabled" id="test_btn">      
	</body>
</html>