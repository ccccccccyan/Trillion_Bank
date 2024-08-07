<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>송금 및 이체</title>
		<link rel="stylesheet" type="text/css" href="/bank/resources/css/bank_header.css">
		<script src="/bank/resources/js/httpRequest.js"></script>
		<!-- account_insert_form.jsp script 코드 -->
        <script src="/bank/resources/js/remittance_js.js"></script>
		<style>
			
		html, body {
		    margin: 0;
		    padding: 0;
		    height: 100%;
		    overflow: hidden;
		} 
			
        #body-container{
        	position: relative;
            font-family: 'Noto Sans KR', Arial, sans-serif; /* 한글 폰트 추가 */
            background-color: #f4f4f4;
            margin: 0;
        }
        #header{position: absolute;
        	z-index: 9;
        	width: 100%;
        	height: 200px;
        	}
        form {
            padding: 30px;
        }
        
        table {
            width: 400px;
            margin: 0 auto;
            border-collapse: collapse;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 8px;
        }
        
        table td {
            padding: 10px;
            text-align: center;
            font-family: 'Noto Sans KR', Arial, sans-serif; /* 한글 폰트 추가 */
            font-weight: bold;
        }
        
        table input[type="text"],
        table input[type="password"],
        table input[type="number"] {
            width: calc(100% - 20px);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 5px;
            margin-top: 5px;
            font-size: 14px; /* 폰트 크기 조정 */
        }
        
        #passwordInput {
		    display: none;
		    position: absolute;
		    width: 470px;
		    top: 350px;
		    left: 50%;
		    transform: translate(-50%, -50%);
		    z-index: 1000;
		    background-color: #fff;
		    padding: 20px;
		    border-radius: 8px;
		    box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
		    font-family: 'Noto Sans KR', Arial, sans-serif;
		}
		
		#passwordInput label {
		    display: block;
		    margin-bottom: 10px;
		    font-weight: bold;
		}
		
		#passwordInput input[type="password"] {
		    width: calc(100% - 20px);
		    padding: 8px;
		    border: 1px solid #ccc;
		    border-radius: 5px;
		    margin-top: 5px;
		    font-size: 14px;
		}
		
		#passwordInput input[type="button"] {
		    width: 100px;
		    padding: 10px;
		    background-color: #23212b;
		    color: #fff;
		    border: none;
		    cursor: pointer;
		    border-radius: 5px;
		    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
		    font-family: 'Noto Sans KR', Arial, sans-serif;
		    font-weight: bold;
		    font-size: 14px;
		    margin-top: 10px;
		}
		
		#passwordInput input[type="button"]:hover {
		    background-color: #1a1720;
		}
		        
        
        table input[type="button"] {
            width: 100px;
            padding: 10px;
            background-color: #23212b;
            color: #fff;
            border: none;
            cursor: pointer;
            border-radius: 5px;
            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            font-family: 'Noto Sans KR', Arial, sans-serif; /* 한글 폰트 추가 */
            font-weight: bold;
            font-size: 14px; /* 폰트 크기 조정 */
        }
        
        table input[type="button"]:hover {
            background-color: #1a1720;
        }
        #form1{position: absolute;
        		top: 150px;
             	left: 745px;
        		z-index: 1;}
        
        #confirmform {
        	 position: absolute;
             opacity: 0;
             width : 250px;
             height : 300px;
             top: 700px;
             left: 820px;
             text-align: center;
             background-color: #fff;
             border-radius: 8px;
             box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
             z-index: 900; /* 다른 요소 위에 띄우기 위해 z-index 설정 */
             max-width: 80%; /* 최대 너비 설정 */         
             transition-property: top, opacity ;   
             transition-duration: 1s; 
             transition-delay: 0.3s;
               
           }

	        
	        #confirmform img {
	            max-width: 100%;
	            height: auto;
	            margin-bottom: 10px;
	            border-radius: 5px;
	        }
	        
	        #confirmform div {
	            margin-bottom: 10px;
	        }
	        
	        #confirmform div#targetUserName {
	            font-weight: bold;
	            font-size: 18px;
	            margin-bottom: 15px;
	        }
	        
	        #confirmform input[type="button"] {
	            width: 100px;
	            padding: 10px;
	            background-color: #23212b;
	            color: #fff;
	            border: none;
	            cursor: pointer;
	            border-radius: 5px;
	            box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
	            font-family: 'Noto Sans KR', Arial, sans-serif; /* 한글 폰트 추가 */
	            font-weight: bold;
	            font-size: 14px; /* 폰트 크기 조정 */
	            margin-right: 10px;
	        }
	        
	        #confirmform input[type="button"]:hover {
	            background-color: #1a1720;
	        }
	        
	        #confirmform input[type="button"]:last-child {
	            margin-right: 0;
	        }
	        #blockall {
	          position: absolute;
	          width: 1920px;
	          height: 1100px;
	           
	          background-color: #d7dbd8;
	          opacity: 0.7;
	          z-index: 800;
			  display: none;
	        }
	        
	        /* #remittance_form 폼 스타일링 */
			 #remittance_form {
			     position: absolute;
	             opacity: 0;
	             width : 250px;
	             height : 300px;
	             top: 700px;
	             left: 820px;
	             text-align: center;
	             background-color: #fff;
	             border-radius: 8px;
	             box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
	             z-index: 1000; /* 다른 요소 위에 띄우기 위해 z-index 설정 */
	             max-width: 80%; /* 최대 너비 설정 */         
	             transition-property: top, opacity ;   
	             transition-duration: 1s; 
	             transition-delay: 0.3s;
		    }
			
			#remittance_form img {
			    max-width: 100%;
			    height: auto;
			    margin-bottom: 10px;
			    border-radius: 5px;
			}
			
			#remittance_form div {
			    margin-bottom: 10px;
			}
			
			#remittance_form div#targetUserName {
			    font-weight: bold;
			    font-size: 18px;
			    margin-bottom: 15px;
			}
			
			#remittance_form input[type="button"] {
			    width: 100px;
			    padding: 10px;
			    background-color: #23212b;
			    color: #fff;
			    border: none;
			    cursor: pointer;
			    border-radius: 5px;
			    box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
			    font-family: 'Noto Sans KR', Arial, sans-serif;
			    font-weight: bold;
			    font-size: 14px;
			    margin-right: 10px;
			}
			
			#remittance_form input[type="button"]:hover {
			    background-color: #1a1720;
			}
			
			#remittance_form input[type="button"]:last-child {
			    margin-right: 0;
			}
	</style>
			
		
		
	</head>
	<body>
			
		<div id="body-container">
			
			<div id="header">
				<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
			</div>
	    <form id="form1">
	        <table border="1" align="center">
	            
	              
	            <tr>
	                <td>아이디: ${vo.user_id}</td>
	            </tr>
	            <tr>
	                <td>계좌번호<input id="target_account_number" name="target_account_number" maxlength="14" oninput="send(this.form);" type="text">
	                 <span id="target_account_warn_msg" style="color: red"></span></td>
	            </tr>
	            <tr>
	                <td>금액<input name="deal_money" id="deal_money" oninput="send(this.form);" type="number">
	                <span id="deal_money_warn_msg" style="color: red"></span></td>
	            </tr>
	            <!-- <tr>
	                <td>비밀번호<input type="password" onchange="send(this.form);" name="input_pwd" maxlength="4"><br>
	                <span id="account_input_pwd_warn_msg" style="color: red"></span></td>
	            </tr> -->
	           
	            <tr>
	                <td><div id="now_money">잔액: ${vo.now_money}원</div></td>
	            </tr>
	            <tr>
	                <td align="center" colspan="2">
	                    <input type="button" id="send_button" value="이체하기" onclick="fn_send(this.form);" >
	                    <input type="button" value="취소" onclick="history.back();">
	                </td>
	            </tr>
	        </table>
	        <input type="hidden" id="account_number" name="account_number" value="${vo.account_number}">
	        <input type="hidden" id="nowmoney" name="now_money" value="${vo.now_money}">
	    </form>
	    
	    <!-- 비밀번호 입력 폼 -->
        <div id="passwordInput" style="display: none;">
            <form id="passwordForm">
                <label for="password">계좌비밀번호 입력:</label>
                <input type="password"  name="input_pwd" maxlength="4"><br>
	                <span id="account_input_pwd_warn_msg" style="color: red"></span><br>
                <input type="button" value="확인" onclick="check_pwd(this.form);">
                <input type="button" value="취소" onclick="passwordInputcancel();">
            </form>
        </div>
	    <!-- onchange="check_pwd(this.form);" -->
	    
	    
	    <form id="confirmform">
	    	<div id="imageContainer">
	        <!-- 스크립트에서 동적으로 추가될 이미지가 여기에 들어감 (bank이미지!) -->
	   		</div>
	   		<input type="hidden" name="account" id="accountnumber" value="">
	   		<input type="hidden" name="targetaccount" id="targetaccountnumber" value="">
	    	<div id=targetUserName></div>
	    	<div id=targetBankName></div>
	    	<div id=dealMoney></div>
	    	<div>보낼게요</div>
	    	<input type="button" value="아니요" onclick="cancelTransaction();">
	    	<input type="button" value="다음" onclick="showPasswordInput();">  	   	
	    </form>
	    
	    <form id="remittance_form">
	    	<div id="imageContainer2">
	        <!-- 스크립트에서 동적으로 추가될 이미지가 여기에 들어감 (bank이미지!) -->
	   		</div>
	   		<input type="hidden" name="account" id="account_number2" value="">
	   		<input type="hidden" name="targetaccount" id="target_account_number2" value="">
	    	<div id=target_UserName></div>
	    	<div id=target_BankName></div>
	    	<div id=deal_Money></div>
	    	<div>이체하였습니다.</div>
	    	<input type="button" value="확인" onclick="sendlist(form1);">
	    	<input type="button" value="추가이체" onclick="allcancel();">  	   	
	    </form>
	    
    <div id="blockall"></div>
	   	</div>
	</body>
</html>