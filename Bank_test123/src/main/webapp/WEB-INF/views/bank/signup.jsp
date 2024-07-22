<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 폼</title>
<script src="/bank/resources/js/httpRequest.js"></script>
<style>
body {
	font-family: 'Arial', sans-serif;
	background-color: #333;
	color: #fff;
	display: flex;
	justify-content: center;
	align-items: center;
	height: 100vh;
	margin: 0;
}

.signup-container {
	background-color: #444;
	padding-top: 20px;
	padding-left: 28px;
	padding-right: 28px;
	padding-bottom: 28px;
	border-radius: 12px;
	box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
	width: 420px;
	text-align: center;
}

.signup-container h2 {
	margin-bottom: 20px;
	font-size: 30px;
	color: #fff;
}

.signup-container input[type="text"], .signup-container input[type="password"],
	.signup-container input[type="button"] {
	width: calc(100% - 0px);
	padding: 12px;
	margin: 8px 0;
	border: 1px solid #555;
	border-radius: 5px;
	background-color: #555;
	color: #fff;
	box-sizing: border-box;
}

.signup-container input[type="button"] {
	background-color: #007bff;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
	width: calc(50% - 5px);
}

.signup-container input[type="text"].check{
	float :left;
	width: calc(100% - 70px);
}
.signup-container input[type="text"].check_tel{
	float :left;
	width: calc(100% - 160px);
}

.signup-container input[type="button"].inline-button {
	margin-left:10px;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
	width: calc(30% - 70px);
}

.signup-container input[type="button"].inline-button-tel {
	margin-left:10px;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
	width: calc(30% - 50px);
}

.signup-container input[type="button"]:hover {
	background-color: #0056b3;
}

.signup-container .inline-button {
	width: calc(50% - 10px);
	display: inline-block;
	margin-right: 10px;
	margin-bottom: 10px;
}

.signup-container .inline-button+.inline-button {
	margin-left: 20px;
}

.signup-container input[type="text"]::placeholder,
.signup-container input[type="password"]::placeholder {
    color: #ccc; /* 플레이스홀더의 글자색 설정 */
    opacity: 1; /* 투명도 설정 */
}

.logo {
	position: absolute;
	width: 400px;
	height: 65px;
	left: 37px;
	top: 37px;
	cursor: pointer;
}

.span{
	text-align: left;
}
</style>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
    function DaumPostcode_api() {
        new daum.Postcode({
            oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var roadAddr = data.roadAddress; // 도로명 주소 변수
                var extraRoadAddr = ''; // 참고 항목 변수

                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                    extraRoadAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName !== '' && data.apartment === 'Y'){
                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraRoadAddr !== ''){
                    extraRoadAddr = ' (' + extraRoadAddr + ')';
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('sample4_postcode').value = data.zonecode;
                document.getElementById("sample4_roadAddress").value = roadAddr;
                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
                
                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
                if(roadAddr !== ''){
                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
                } else {
                    document.getElementById("sample4_extraAddress").value = '';
                }

                var guideTextBox = document.getElementById("guide");
                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
                if(data.autoRoadAddress) {
                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
                    guideTextBox.style.display = 'block';

                } else if(data.autoJibunAddress) {
                    var expJibunAddr = data.autoJibunAddress;
                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
                    guideTextBox.style.display = 'block';
                } else {
                    guideTextBox.innerHTML = '';
                    guideTextBox.style.display = 'none';
                }
            }
        }).open();
    }
</script>
<script>
	let sixnumber = 0;
	let isTelVerified = false; // 전화번호 인증 여부를 체크하는 변수
	let intervaled_user_self;

	function send(f) {
		 if (!isTelVerified) {
             alert("전화번호 인증을 완료해 주세요.");
             return;
         }
		
		let user_name = f.user_name.value;
		let user_id = f.user_id.value;
		let user_pwd = f.user_pwd.value;
		let user_pwd_check = f.user_pwd_check.value;
		let user_tel = f.user_tel.value;
		let user_addr = f.user_addr.value;

		if (user_pwd != user_pwd_check) {
			alert("비밀번호가 일치하지 않습니다.");
			return;
		} else if (user_pwd.length < 8 || user_pwd.length > 16) {
			alert("8~16자의 비밀번호를 입력하여주십시오.");
			return;
		}

		if (!/^[a-zA-Z0-9]+$/.test(user_id) || user_id.length < 4 || user_id.length > 12) {
			alert("영어와 숫자로만 이루어진 4~12자의 아이디를 입력하여주십시오.");
			return;
		}
		
		if(!/^\d+$/.test(user_tel) || user_tel.length != 11){
			alert("숫자로만 이루어진 11글자의 번호를 입력해주십시오.")
			return;
		}
		
		if(sample4_postcode == ''|| sample4_roadAddress =='' || sample4_jibunAddress =='' || user_addr =='' || sample4_extraAddress ==''){
			alert("올바른 주소를 입력하여주십시오.")
			return;
		}
		

		let url = "signup_ins.do";
		let param = "user_name=" + user_name + "&user_id=" + user_id +
			"&user_pwd=" + encodeURIComponent(user_pwd) + "&user_tel=" +
			user_tel + "&user_addr=" + user_addr;

		sendRequest(url, param, resultFn, "post");
	}

	function resultFn() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				let user_id = json[0].User_id;
				let user_name = json[0].User_name;
				let user_pwd = json[0].User_pwd;
				let user_tel = json[0].User_tel;
				let user_addr = json[0].User_addr;
				let manager = json[0].Manager;
				
				location.href = "signup_final.do?user_id=" + user_id + "&user_name=" + user_name +
								"&user_pwd=" + encodeURIComponent(user_pwd) + "&user_tel=" + user_tel + 
								"&user_addr=" + user_addr + "&manager=" + manager;
				
				alert("회원가입이 정상적으로 완료되었습니다.")
			} else {
				alert("가입실패");
			}
		}
	}
	
	function send2(f) {
		let user_name = f.user_name.value;
		let user_id = f.user_id.value;
		let user_pwd = f.user_pwd.value;
		let user_pwd_check = f.user_pwd_check.value;
		let user_tel = f.user_tel.value;
		let user_addr = f.user_addr.value;

		if (user_pwd != user_pwd_check) {
			alert("비밀번호가 일치하지 않습니다.");
			return;
		} else if (user_pwd.length < 8 || user_pwd.length > 16) {
			alert("8~16자의 비밀번호를 입력하여주십시오.");
			return;
		}

		if (!/^[a-zA-Z0-9]+$/.test(user_id) || user_id.length < 4 || user_id.length > 12) {
			alert("영어와 숫자로만 이루어진 4~12자의 아이디를 입력하여주십시오.");
			return;
		}
		
		if(!/^\d+$/.test(user_tel) || user_tel.length != 11){
			alert("숫자로만 이루어진 11글자의 번호를 입력해주십시오.")
			return;
		}
		
		if(sample4_postcode == ''|| sample4_roadAddress =='' || sample4_jibunAddress =='' || user_addr =='' || sample4_extraAddress ==''){
			alert("올바른 주소를 입력하여주십시오.")
			return;
		}
		
		if (user_id.toLowerCase().includes("admin")) {
			let adminPwd = prompt("관리자 계정으로 등록하려면 비밀번호를 입력하세요:");
			if (adminPwd !== "wlqdprkrhtlvek") {
				alert("비밀번호가 틀렸습니다.");
				return;
			} else {
				alert("관리자 권한부여가 완료되었습니다.");
			}
			}else{
			 	alert("접근 권한이 없습니다.");
			 	return;
		}

		let url = "signup_ins_admin.do";
		let param = "user_name=" + user_name + "&user_id=" + user_id +
			"&user_pwd=" + encodeURIComponent(user_pwd) + "&user_tel=" +
			user_tel + "&user_addr=" + user_addr;

		sendRequest(url, param, resultFn2, "post");
	}

	function resultFn2() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				let user_id = json[0].User_id;
				let user_name = json[0].User_name;
				let user_pwd = json[0].User_pwd;
				let user_tel = json[0].User_tel;
				let user_addr = json[0].User_addr;
				let manager = json[0].Manager;
				location.href = "signup_final_admin.do?user_id=" + user_id + "&user_name=" + user_name + 
								"&user_pwd=" + encodeURIComponent(user_pwd) + "&user_tel=" + user_tel + 
								"&user_addr=" + user_addr + "&manager=" + manager;
			} else {
				alert("가입실패");
			}
		}
	}


	function check_id(f) {
		let user_id = f.user_id.value;
		
		if (!/^[a-zA-Z0-9]+$/.test(user_id) || user_id.length < 4 || user_id.length > 12) {
			alert("영어와 숫자로만 이루어진 4~12자의 아이디를 입력하여주십시오.");
			return;
		}
		
		let url = "signup_ins_id.do";
		let param = "user_id=" + user_id;

		sendRequest(url, param, result_id, "post"); 
	}

	function result_id() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				alert("사용가능한 ID입니다.");
			} else {
				alert("중복되는 ID입니다.");
			}
		}
	}
	

	function check_tel(f) {
		let user_tel = f.user_tel.value;
		
		if(!/^\d+$/.test(user_tel) || user_tel.length != 11){
			alert("숫자로만 이루어진 11글자의 번호를 입력해주십시오.")
			return;
		}

		
		let url = "signup_ins_tel.do";
		let param = "user_tel=" + user_tel;

		sendRequest(url, param, result_tel, "post");
	}

	function result_tel() {
		if (xhr.readyState == 4 && xhr.status == 200) {
			let data = xhr.responseText;
			let json = (new Function('return ' + data))();

			if (json[0].result == 'clear') {
				alert("가입가능한 전화번호입니다.");
				document.getElementById("tel_verify_btn").disabled = false;
			} else {
				alert("해당 전화번호는 회원가입이 완료된 번호입니다.");
			}
		}
	}

	function check_user_self(f) {
			param = "user_tel="+f.user_tel.value;
			url ="user_self_check.do";
		
			sendRequest(url, param, check_user_selfOK, "post");	
	}	
	function check_user_selfOK() {
		if( xhr.readyState == 4 && xhr.status == 200 ){
			
			//"[{'result':'yes'}]"
			let data = xhr.responseText;
			console.log(data);
			
			let json = ( new Function('return '+data) )();
			
			if( json[0].result == 'clear' ){
				sixnumber =json[0].sixNumber;
				console.log("sixnumber : "+sixnumber);
			}else{
				alert("진행 실패");
			}
			
		}
	}
	
	
	function check_user_sixnumber(f) {
		if(sixnumber == 0){
			alert("인증번호를 발송해주십시오");
			return;
		}else if(f.user_number.value != sixnumber){
			alert("인증번호를 불일치");
			return;

		}else if(f.user_number.value == sixnumber){
				alert("인증완료.");
				
				clearInterval(intervaled_user_self);
				sixnumber = 0;
				
				isTelVerified = true; // 인증 완료 상태로 설정
                document.querySelector('input[type="button"][value="회원가입"]').disabled = false;
                document.querySelector('input[type="button"][value="관리자 회원가입"]').disabled = false;
		}
	}
	
	
</script>
</head>
<body>
	<img src="/bank/resources/img/일조은행아이콘.png" class ="logo" onclick="location.href='login.do'">
	<div class="signup-container">
		<h2>SIGN UP</h2>
		<form name="f">
			<div class="id">
				<input type="text" name="user_name" placeholder="이름" required><br>
				<input type="text" name="user_id" class="check" placeholder="영어 + 숫자의 4~12자리의 ID" required maxlength="12"> 
				<input type="button" value="확인" class="inline-button" onclick="check_id(this.form)">
				<input type="password" name="user_pwd" placeholder="영어 + 숫자의 8~16자리의 비밀번호" maxlength="16" required><br> 
				<input type="password" name="user_pwd_check" placeholder="비밀번호 확인" maxlength="16" required><br>
				<input type="text" name="user_tel" class="check_tel" placeholder="전화번호 '-'을 제외한 11자리" maxlength="11" required>
				<input type="button" value="중복확인" class="inline-button-tel" onclick="check_tel(this.form);">
				<input type="button" value="인증" disabled="disabled" id="tel_verify_btn" class="inline-button" onclick="check_user_self(this.form);"> <br> 
				<input type="text" name="user_number" id="check_user_number" class="check" placeholder="인증번호를 입력해주십시오." maxlength="6" required>
				<input type="button" value="확인" id="check_user_number_button" class="inline-button" onclick="check_user_sixnumber(this.form);"> <br> 
				<input type="text" id="sample4_postcode" class="check" placeholder="우편번호">
				<input type="button" onclick="DaumPostcode_api()" class="inline-button" value="찾기"><br>
				<input type="text" id="sample4_roadAddress" placeholder="도로명주소">
				<input type="text" id="sample4_jibunAddress" placeholder="지번주소">
				<span id="guide" style="color: #999; display: none"></span> 
				<input type="text" id="user_addr" placeholder="상세주소"> 
				<input type="text" id="sample4_extraAddress" placeholder="참고항목"><br>
				<input type="button" value="회원가입"  onclick="send(this.form)">
				<input type="button" value="관리자 회원가입"  onclick="send2(this.form)">
			</div>
		</form>
	</div>
</body>
</html>
