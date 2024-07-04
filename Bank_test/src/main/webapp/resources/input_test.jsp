<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script>
			document.getElementById('contactForm').addEventListener('submit', function(event) {
			    event.preventDefault(); // 기본 제출 동작을 방지합니다.
			
			    // 폼 유효성 검사
			    if (this.checkValidity()) {
			        // 유효한 경우 추가 처리
			        alert('Form submitted successfully!');
			
			        // 여기서 서버로 데이터를 전송하거나 추가적인 처리를 수행할 수 있습니다.
			        // 예를 들어:
			        // fetch('/submit', { method: 'POST', body: new FormData(this) });
			
			    } else {
			        // 유효하지 않은 경우 오류 메시지 표시
			        alert('Please fill out the form correctly.');
			    }
			});
		</script>
		
	</head>
	
	<body>
		<!-- label : input 태그와 연결되어 사용자에게 입력 필드의 목적을 설명, for 속성을 사용하여 특정 input 태그와 연결한다.
			사용자가 레이블을 클릭할 때 해당 입력 필드로 포커스가 이동
		 -->
	
		
		<br>
		
		<form id="contactForm">
			<label for="username">Username:</label>
			<input type="text" id="username" name="username">
		    <div>
		    
<!--  -->
<!-- 

pattern 속성은 브라우저가 폼 제출 시 자동으로 유효성 검사를 수행하도록 합니다. 
만약 사용자가 입력한 값이 pattern과 일치하지 않으면 폼은 제출되지 않고,
브라우저는 사용자에게 오류 메시지를 표시합니다. 이 메시지는 title 속성을 통해 사용자 정의할 수 있습니다.

	pattern 속성1 (이메일): [a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$
	
		^ 및 $: 문자열의 시작과 끝을 나타냅니다.
		[a-z0-9._%+-]+: 이메일 사용자명 부분에 허용되는 문자 세트를 정의합니다.
		@: 이메일 주소에서 사용자명과 도메인을 구분하는 "@" 기호를 나타냅니다.
		[a-z0-9.-]+: 도메인 부분에 허용되는 문자 세트를 정의합니다.
		\.: 도메인과 최상위 도메인(TLD)을 구분하는 "."을 나타냅니다.
		[a-z]{2,}$: TLD 부분에 허용되는 문자 세트와 길이를 정의합니다 (최소 2자).
		title 속성: 입력 값이 패턴과 일치하지 않을 때 브라우저에서 표시할 메시지를 정의
 
 
	pattern 속성2 (전화번호): \d{3}-\d{3}-\d{4}
	
		\d: 숫자를 나타냅니다.
		{3}: 정확히 3개의 숫자를 요구합니다.
		-: 숫자 그룹 사이에 하이픈을 요구합니다.
		전체 패턴은 세 개의 숫자 그룹(각각 3, 3, 4개)과 하이픈 구분 기호를 요구합니다.
 -->
		    
		        <label for="email">Email:</label>
		        <input type="text" id="email" name="email" pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" 
		               title="Please enter a valid email address" required>
		    </div>
		    <div>
		        <label for="phone">Phone Number:</label>
		        <input type="tel" id="phone" name="phone" pattern="\d{3}-\d{3}-\d{4}" 
		               title="Please enter a phone number in the format 123-456-7890" required>
		    </div>
		    <div>
		        <button type="submit">Submit</button>
		    </div>
	</form>
	</body>
</html>