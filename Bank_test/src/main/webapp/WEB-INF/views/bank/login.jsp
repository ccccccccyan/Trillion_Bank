<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
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
    .login-container {
        background-color: #444;
        padding: 30px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
        width: 320px;
        text-align: center;
    }
    .login-container h2 {
        margin-bottom: 20px;
        font-size: 24px;
        color: #fff;
    }
    .login-container input[type="text"],
    .login-container input[type="password"] {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: 1px solid #555;
        border-radius: 5px;
        background-color: #555;
        color: #fff;
        box-sizing: border-box;
    }
    .login-container input[type="button"] {
        width: 100%;
        padding: 12px;
        margin: 10px 0;
        border: none;
        border-radius: 5px;
        background-color: #007bff;
        color: white;
        font-size: 16px;
        cursor: pointer;
        transition: background-color 0.3s;
    }
    .login-container input[type="button"]:hover {
        background-color: #0056b3;
    }
    .login-container a {
        display: block;
        margin: 10px 0;
        color: #007bff;
        text-decoration: none;
    }
    .login-container a:hover {
        text-decoration: underline;
    }
</style>

<script>
	function send(f) {
	    let user_id = f.user_id.value;
	    let user_pwd = f.user_pwd.value;
	    
	    if(user_id =='' || user_pwd ==''){
	    	alert("올바른 정보를 입력해주십시오.")
	    }
	
	    let url = "login_check.do";
	    let param = "user_id=" + user_id + "&user_pwd=" + encodeURIComponent(user_pwd);
	    sendRequest(url, param, resultFn, "post");
	}

    function resultFn() {
        if (xhr.readyState == 4 && xhr.status == 200) {
            let data = xhr.responseText;
            let json = (new Function('return ' + data))();
            let user_id = json[0].User_id;
            if (json[0].result == 'no') {
                alert("회원정보 불일치");
                return;
            }else if (json[0].result == 'freeze'){
            	alert("이 계정은 현재 동결상태이므로 서비스 이용을 원하시면 가까운 지점이나 본사를 방문하여주십시오.")
            	return;
            }
            else {
                location.href = "account_list.do?user_id=" + user_id;
            }
        }
    }
</script>

</head>
<body>
    <div class="login-container">
        <h2>LOG IN</h2>
        <form name="f">
            <div class="id">
                <input type="text" name="user_id" maxlength="12" placeholder="ID"><br>
                <input type="password" name="user_pwd" placeholder="PASSWORD"><br>
            </div>
            <input type="button" value="LOG IN" onclick="send(this.form)" />
            <input type="button" value="SIGN UP" onclick="location.href='signup.do'" />
            <input type="button" value="FIND ID" onclick="location.href='search_id.do'" />
            <input type="button" value="FIND PASSWORD" onclick="location.href='search_pwd.do'" />
        </form>
    </div>
</body>
</html>
