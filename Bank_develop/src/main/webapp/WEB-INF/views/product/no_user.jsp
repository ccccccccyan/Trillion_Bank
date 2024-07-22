<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		    .modal {
		        display: none; /* 기본적으로 숨김 */
		        position: fixed;
		        top: 30%;
		        left: 50%;
		        transform: translate(-50%, -50%);
		        background-color: white;
		        border: 1px solid #ccc;
		        padding: 20px;
		        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
		        z-index: 9999;
		    }
		    .modal h2 {
		        font-size: 1.2em;
		        margin-bottom: 10px;
		    }
		    .modal p {
		        font-size: 1em;
		    }
		    .modal button {
		        padding: 10px 20px;
		        background-color: #007bff;
		        color: white;
		        border: none;
		        cursor: pointer;
		    }
		</style>
		<script>
		    // 모달 창을 보여주는 함수
		    function showModal() {
		        var modal = document.getElementById("myModal");
		        modal.style.display = "block";
		    }
		
		    // 계좌 목록 페이지로 이동하는 함수
		    function send() {
		        window.location.href = "account_list.do";
		    }
		
		    // 페이지 로드 시 모달 창 보이기
		    window.onload = function() {
		        showModal();
		    };
		</script>
	</head>
	
	<body>
		<div id="myModal" class="modal">
		    <h2>알림</h2>
		    <p>로그인하신뒤 상품 가입을 진행해 주십시오.</p>
		    <button onclick="send()">메인페이지로 이동</button>
		</div>
	</body>
</html>