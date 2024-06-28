<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="/bank/resources/js/httpRequest.js"></script>
		<script>
			function del(f) {
				let account_number = f.account_number.value;
				let input_pwd = f.input_pwd.value;
				let url = "del_accountpwd_chk.do";
				let param = "account_number="+account_number+"&account_pwd="+encodeURIComponent(input_pwd);
				sendRequest(url, param, resultDel, "post");
			}
			
			function resultDel() {
				if( xhr.readyState == 4 && xhr.status == 200 ){
					
					let data = xhr.responseText;
					let json = (new Function('return '+data))();
					console.log(json[0].account_number);
					if( json[0].result == 'no'){
						alert("비밀번호 불일치");
						return;
					}else{
						if(!confirm("정말로 삭제하시겠습니까?")){
							return;
						}else{
						location.href="account_delete.do?account_number="+json[0].account_number;
						}
					}
				}
			}
		</script>
		
	</head>
	
	<body>
		
		<div align="center">
			<form>
			<input type="hidden" name="account_number" value="${vo.account_number}">
			
			${vo.bank_name}은행 계좌삭제<br>
			비밀번호를 입력해주세요.<br>
			<input type="password" name="input_pwd" maxlength="4">
			<input type="button" value="삭제하기" onclick="del(this.form);">
			</form>	
		</div>
		
	</body>
</html>