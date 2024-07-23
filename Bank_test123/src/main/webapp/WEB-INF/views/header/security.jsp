<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>보안 공지사항</title>
		
		<style>
			
			.container{
				max-width: 800px;
				margin: auto;
				padding: 20px;
				border: 1px solid #ddd;
				border-radius: 5px;
				box-shadow: 0 0 10px rgba(0,0,0,0.1);
				background: #f9f9f9;
			}
			
			h1{
				text-align: center;
			}
			
			.highlight {
                color: #1e90ff;
                font-weight: bold;
            }
			
		</style>
		
	</head>
	
	<body>
		<div id="header">
	        <jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	    </div>
		
		<div class="container">
			<h1>일조은행 보안 공지사항</h1>
			
			<p>안녕하십니까, 고객님.</p>
			<p>저희 <span class="highlight">[일조은행(Trillion Bank)]</span>을 믿고 이용해 주시는 
			고객 여러분께 진심으로 감사드립니다. 
			저희 은행은 고객님의 소중한 자산과 개인정보를 보호하기 위해 
			최선을 다하고 있으며, 보안 강화와 관련된 중요 공지사항을 안내드립니다.</p>
			
			<h2>1. 계정 보안 강화</h2>
			
			<p>최근 사이버 보안 위협이 증가함에 따라, 
			고객님의 계정을 더욱 안전하게 보호하기 위해 
			다음과 같은 조치를 시행하고 있습니다.</p>
			
			<p>- <strong>2단계 인증 도입</strong>: 
			온라인 뱅킹 접속 시, 기존의 ID와 비밀번호 외에도 추가 인증 절차를 도입하였습니다. 
			SMS 인증 또는 인증 앱을 통해 두 번째 인증 단계를 완료하셔야 접속이 가능합니다.</p>
			
			<p>- <strong>비밀번호 정책 강화</strong>: 
			비밀번호는 최소 8자 이상, 대문자와 소문자, 숫자, 특수문자를 포함하여야 합니다. 
			또한, 정기적으로 비밀번호를 변경하시기를 권장드립니다.</p>
			
			
			<h2>2. 피싱 및 스미싱 주의</h2>
			
			<p>최근 피싱 및 스미싱이 증가하고 있습니다. 
			일조은행(Trillion Bank)은 다음과 같은 사항에 대해 주의를 당부드립니다.</p>
			
			<p>- <strong>의심스러운 이메일</strong>: 
			일조은행을 사칭한 이메일이 발견될 경우, 링크를 클릭하거나 첨부파일을 
			다운로드하지 마시고 즉시 삭제하시기 바랍니다. 
			저희 은행은 고객님의 개인정보를 이메일로 요청하지 않습니다.</p>
			
			<p>- <strong>문자 메시지</strong>: 
			은행을 사칭하여 개인정보나 금융 정보를 요구하는 문자 메시지를 받을 경우, 
			해당 메시지에 응답하지 마시고, 은행 고객센터로 신고해 주시기 바랍니다.</p>
			
			
			<h2>3. 온라인 거래 보안</h2>
			
			<p>온라인 거래 시, 안전한 거래를 보장하기 위해 다음 사항을 준수해 주시기 바랍니다.</p>
			
			<p>- <strong>공용 네트워크 사용 자제</strong>: 
			공공 와이파이 또는 공용 컴퓨터에서 온라인 뱅킹에 접속하는 것을 피하시기 바랍니다. 
			가정용 또는 개인용 네트워크를 사용하시기 바랍니다.</p>
			
			<p>- <strong>보안 소프트웨어 업데이트</strong>: 
			항상 최신 버전의 보안 소프트웨어와 운영체제를 유지하시기 바랍니다. 
			이를 통해 악성 프로그램으로부터 보호받을 수 있습니다.</p>
			
			
			<h2>4. 보안 교육 및 인식 제고</h2>
			
			<p>일조은행은 고객님의 보안 인식 제고를 위해 정기적으로 
			보안 교육 자료와 가이드를 제공할 예정입니다. 
			저희 웹사이트의 '보안 센터' 페이지에서 최신 보안 정보를 확인하실 수 있습니다.</p>
			
			
			<h2>5. 고객센터 연락처</h2>
			
			<p>보안 관련 의심스러운 활동이나 문의사항이 있을 경우, 
			언제든지 일조은행 고객센터(전화번호: 1234-1234)로 연락해 주시기 바랍니다. 
			저희 고객센터는 여러분을 위해 운영되고 있습니다.</p>
			
			<h2>6. 마무리 말씀</h2>
			
			<p>고객님의 신뢰를 바탕으로 일조은행(Trillion Bank)은 끊임없이 
			보안 강화를 위해 노력하고 있습니다. 언제나 안전하고 신뢰할 수 있는 금융 서비스를 
			제공하기 위해 최선을 다하겠습니다.</p>
			
			<br>
			
			<p>감사합니다.</p>
			
			<p>일조은행(Trillion Bank) 드림</p>
			
		</div>
		
		<!-- 하단 footer -->
        <div id="footer">
            <jsp:include page="/WEB-INF/views/footer_header.jsp"></jsp:include>
        </div>
		
	</body>
</html>