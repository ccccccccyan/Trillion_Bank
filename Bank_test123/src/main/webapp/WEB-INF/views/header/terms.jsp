<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>이용약관</title>
		
		<style>
		
			.header {
				margin-bottom: 20px; /* 헤더 아래쪽으로 20px의 마진 추가 */
			}
		
			body {
	            font-family: Arial, sans-serif;
	            line-height: 1.6;
	            margin: 20px;
	            padding: 0;
	            padding-top: 20px; /* 페이지 상단에 20px의 패딩 추가 */
	            padding-bottom: 20px; /* 페이지 하단에 20px의 패딩 추가 */
	        }
	        
	        .container {
	            max-width: 800px;
	            margin: auto;
	            background: #f9f9f9;
	            padding: 20px;
	            border: 1px solid #ddd;
	            border-radius: 5px;
	            box-shadow: 0 0 10px rgba(0,0,0,0.1);
	        }
	        h1 {
	            text-align: center;
	            margin-bottom: 20px;
	        }
	        h2 {
	            margin-top: 30px;
	            margin-bottom: 10px;
	        }
	        p {
	            margin-bottom: 10px;
	        }
	        .definition {
	            margin-left: 20px;
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
			<h1>은행 약관 동의</h1>
			
			<h2>제 1장: 총칙</h2>
			<p><span class="highlight">목적:</span> 본 약관은 <span class="highlight">[일조은행(Trillion Bank)]</span>이 제공하는 모든 금융 서비스와 관련하여 회원(고객)과 은행 간의 권리와 의무를 규정함을 목적으로 합니다.</p>
			
			<h2>용어의 정의</h2>
			<p><span class="highlight">"회원"</span>이란 본 약관에 동의하고 <span class="highlight">[일조은행(Trillion Bank)]</span>이 제공하는 서비스를 이용하는 개인 또는 법인을 말합니다.</p>
			<p><span class="highlight">"서비스"</span>란 <span class="highlight">[일조은행(Trillion Bank)]</span>이 회원에게 제공하는 모든 금융 상품과 서비스를 말합니다.</p>
			
			<h2>약관의 효력과 변경</h2>
			<p>본 약관은 회원이 서비스를 이용함에 있어 적용되며, 회원은 본 약관의 변경을 동의하는 것으로 간주됩니다.</p>
			<p><span class="highlight">[일조은행(Trillion Bank)]</span>은 필요한 경우 본 약관을 변경할 수 있으며, 변경된 약관은 <span class="highlight">[일조은행(Trillion Bank)]</span>의 웹사이트나 기타 적절한 방법을 통해 공지됩니다.</p>
			
			<h2>제 2장: 서비스 이용</h2>
			
			<h3>계좌 개설과 관리</h3>
			<p>회원은 <span class="highlight">[일조은행(Trillion Bank)]</span>의 규정에 따라 계좌를 개설하고 관리할 수 있습니다.</p>
			<p>계좌 개설 시 필요한 정보는 회원 본인의 신원 확인을 위해 제공되어야 합니다.</p>
			<p>계좌 관리는 회원이 스스로 책임져야 하며, 계좌 정보의 정확성과 최신화는 항상 유지되어야 합니다.</p>
			
			<h3>금융 거래</h3>
			<p>회원은 <span class="highlight">[일조은행(Trillion Bank)]</span>이 제공하는 금융 거래를 이용할 수 있습니다.</p>
			<p>모든 거래는 <span class="highlight">[일조은행(Trillion Bank)]</span>의 규정과 정책에 따라 처리되며, 회원은 해당 규정을 준수해야 합니다.</p>
			<p>거래 시 발생하는 비용 및 수수료는 <span class="highlight">[일조은행(Trillion Bank)]</span>이 별도로 고지한 바에 따라 회원이 부담해야 합니다.</p>
			
			<h2>제 3장: 수수료 및 비용</h2>
			
			<h3>서비스 이용 수수료</h3>
			<p><span class="highlight">[일조은행(Trillion Bank)]</span>이 제공하는 서비스 이용에 따른 수수료 및 비용은 별도의 공지나 알림을 통해 회원에게 고지됩니다.</p>
			<p>서비스 이용 시 발생하는 모든 수수료는 회원이 부담해야 합니다.</p>
			
			<h3>환율 적용</h3>
			<p>외화 거래 등에서 적용되는 환율은 <span class="highlight">[일조은행(Trillion Bank)]</span>의 정책에 따라 결정되며, 회원은 이에 동의한 것으로 간주됩니다.</p>
			
			<h2>제 4장: 계좌 보안과 이용 책임</h2>
			
			<h3>계좌 보안</h3>
			<p>회원은 자신의 계좌와 관련된 모든 정보를 안전하게 보호해야 합니다. 계좌 정보 유출 시 발생하는 손실이나 문제에 대해 <span class="highlight">[일조은행(Trillion Bank)]</span>은 책임지지 않습니다.</p>
			<p>계좌 비밀번호 및 보안 질문 등 계정 접근을 제한하는 모든 보안 조치는 회원 본인이 책임져야 합니다.</p>
			
			<h3>이용 책임</h3>
			<p>회원은 <span class="highlight">[일조은행(Trillion Bank)]</span>의 서비스를 이용함에 있어 법령 및 <span class="highlight">[일조은행(Trillion Bank)]</span>의 정책을 준수해야 합니다.</p>
			<p>회원은 자신의 계좌를 부당하게 사용하여 발생하는 모든 책임을 지며, 이로 인한 손실에 대해 <span class="highlight">[일조은행(Trillion Bank)]</span>은 책임을 지지 않습니다.</p>
			
			<h2>제 5장: 약관의 해석과 적용</h2>
			
			<h3>약관의 해석</h3>
			<p>본 약관에 명시되지 않은 사항이나 해석에 대해선 <span class="highlight">[일조은행(Trillion Bank)]</span>의 결정이 최종적이며, 회원은 이를 존중해야 합니다.</p>
			<p>약관에서 정한 규정과 서비스 이용 시 발생하는 모든 분쟁은 <span class="highlight">[일조은행(Trillion Bank)]</span>의 본점 소재지 법원에서 해결됩니다.</p>
			
		</div>
		
		<!-- 하단 footer -->
		<div id="footer">
			<jsp:include page="/WEB-INF/views/footer_header.jsp"></jsp:include>
		</div>
		
	</body>
</html>