<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>계좌 삭제 폼</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header_css.css">
    <script src="/bank/resources/js/httpRequest.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
        }
        
        .container {
            max-width: 400px;
            margin: 0px auto;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
            padding: 30px;
            text-align: center;
        }
        
        .container h2 {
            font-size: 1.5em;
            margin-bottom: 20px;
        }
        
        .form-group {
            margin-bottom: 15px;
        }
        
        .form-group label {
            display: block;
            font-weight: bold;
            margin-bottom: 5px;
        }
        
        .form-group input[type="password"] {
            width: calc(100% - 10px);
            padding: 10px;
            border: 1px solid #ccc;
            border-radius: 5px;
            font-size: 1em;
        }
        
        .form-group input[type="button"] {
            width: 100%;
            padding: 12px;
            background-color: #23212b;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            font-size: 1em;
        }
        
        .form-group input[type="button"]:hover {
            background-color: #1a1720;
        }
    </style>
    
    
    <script>
        function del(f) {
            let account_number = f.account_number.value;
            let input_pwd = f.input_pwd.value;
            let url = "del_accountpwd_chk.do";
            let param = "account_number="+account_number+"&account_pwd="+encodeURIComponent(input_pwd);
            sendRequest(url, param, resultDel, "post");
        }
        
        function resultDel() {
            if (xhr.readyState == 4 && xhr.status == 200) {
                let data = xhr.responseText;
                let json = (new Function('return ' + data))();
                let money = Number(json[0].now_money);
                console.log("gdhklgdhkl : " + data);
                let bank_name = json[0].bank_name;
              	console.log("하이하이 : "+ bank_name);
              	
				if( money > 0 && bank_name == '일조'){
					alert("계좌에 잔액이 남아있습니다. 가까운 지점에 방문해주세요.");
					return;
				}
                
                if (json[0].result == 'no') {
                    alert("비밀번호 불일치");
                    return;
                } else {
                    if (!confirm("정말로 삭제하시겠습니까?")) {
                        return;
                    } else {
                    	location.href="account_list.do";
                        location.href = "account_delete.do?account_number=" + json[0].account_number; 
                    }
                }
            }
        }
    </script>
    
	</head>
		<body>
			
			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
		
		
		    <div class="container">
		        <h2>${vo.bank_name}은행 계좌 삭제</h2>
		        <form>
		            <input type="hidden" name="account_number" value="${vo.account_number}">
		            
		            <div class="form-group">
		                <label for="input_pwd">비밀번호</label>
		                <input type="password" id="input_pwd" name="input_pwd" maxlength="4" required>
		            </div>
		            
		            <div class="form-group">
		                <input type="button" value="삭제하기" onclick="del(this.form);">
		            </div>
		        </form>
		    </div>
		</body>
</html>