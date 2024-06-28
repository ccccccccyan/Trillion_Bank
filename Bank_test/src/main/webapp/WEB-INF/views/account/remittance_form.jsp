<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		
		<script src="/bank/resources/js/httpRequest.js"></script>
		
		<script>
		function send(f) {
			let account_number = f.account_number.value;
			let input_pwd = f.input_pwd.value;
			let target_account_number = f.target_account_number.value;
			let deal_money = Number(f.deal_money.value);
			let now_money = Number(f.now_money.value);
			//계좌번호 유효성체크
			if(target_account_number.length < 10 || target_account_number.length > 14){
				alert("계좌번호는 10~14자 입니다.");
				return;
			}
			 // 숫자로만 이루어져 있는지 검사
		    let onlynumber = /^[0-9]+$/;
		    if (!onlynumber.test(target_account_number)) {
		        alert("계좌번호는 숫자로만 입력해야 합니다.");
		        return; // 유효하지 않으면 함수 종료
		    }
		    //비빌번호 유효성체크
		    if(input_pwd.length != 4){
		    	alert("계좌 비밀번호는 4자리 입니다.");
		    	return;
		    }
		    if (!onlynumber.test(input_pwd)) {
		        alert("계좌 비밀번호는 숫자로만 입력해야 합니다.");
		        return; // 유효하지 않으면 함수 종료
		    }
		    if(now_money < deal_money){
				alert("잔액이 부족합니다.");
				return;
			}
			if (!(deal_money > 0)) {
			    alert("거래금액은 1원이상 입력해주세요.");
			    return;
			}
		    
		    
			let url = "remittance_pwd_chk.do";
			let param = "account_number="+account_number+"&account_pwd="+encodeURIComponent(input_pwd)+"&target_account_number="+target_account_number+"&deal_money="+deal_money;
			sendRequest(url, param, resultFn, "post");
		}
			
		function resultFn(){
			if( xhr.readyState == 4 && xhr.status == 200 ){
				let data = xhr.responseText;
				let json = (new Function('return '+data))();
				
				if( json[0].result == 'no_account'){
					alert("유효하지 않은 계좌번호입니다.");
					return;
				}
				
				
				if( json[0].result == 'no' ){
					alert("비밀번호 불일치");
					return;
				}else{
					//json으로 넘겨받은 idx값을 가지고 수정 폼으로 이동
					if( !confirm(json[0].target_user_name +"님에게 송금하시겠습니까?")){
						return;
					}else{
					location.href="remittance.do?account_number="+ 
							json[0].account_number+"&target_account_number="+json[0].target_account_number+"&deal_money="+json[0].deal_money;
					}
					
				
				}
			}
		}
		</script>
		
	</head>
	<body>
		<form>
		<table border="1" align="center">
		
			<input type="hidden" name="account_pwd" value="${vo.account_pwd}">
			<input type="hidden" name="account_number" value="${vo.account_number}">
			<input type="hidden" name="now_money" value="${vo.now_money}">
			
			
			<tr>
				<td>아이디: ${vo.user_id}</td>
			</tr>
			<tr>
				<td>계좌번호<input name="target_account_number" maxlength="14"></td>
			</tr>
			<tr>
				<td>금액<input name="deal_money"></td>
			</tr>
			<tr>
				<td>비밀번호<input type ="password" name="input_pwd" maxlength="4"></td>
			</tr>
			<tr>
				<td>잔액: ${vo.now_money}원</td>
			</tr>
			<tr>
				<td align="right"><input type ="button" value="송금" onclick="send(this.form);"></td>
				<td align="right"><input type ="button" value="취소" onclick="history.back();"></td>
			</tr>
			
		</table>
		</form>
	</body>
</html>