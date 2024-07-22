<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>자주 묻는 질문 (FAQ)</title>
        
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
                border-radius: 5px; /* 모서리를 5px 깎아서 둥글게 만듦. */
                box-shadow: 0 0 10px rgba(0,0,0,0.1); /* 박스에 그림자를 줌. */
            }
            h1 {
                text-align: center;
                margin-bottom: 20px;
            }
            h2 {
                margin-top: 30px;
                margin-bottom: 10px;
            }
            details {
                margin-bottom: 10px;
                border: 1px solid #ddd;
                border-radius: 5px;
                padding: 10px;
                background-color: #f9f9f9;
                transition: all 0.3s ease-out;
                overflow: hidden;
            }
            summary {
                font-weight: bold;
                cursor: pointer;
                transition: all 0.3s ease-out;
            }
            details p {
                margin: 0;
                padding: 0;
                opacity: 0;
                max-height: 0;
                transition: opacity 0.3s ease-out, max-height 0.3s ease-out;
            }
            details[open] p {
                opacity: 1;
                max-height: 1000px; /* 충분히 큰 값으로 설정하여 전체 내용을 표시 */
                padding: 10px 0;
            }
            details[open] {
                animation: slideDown 0.3s ease-out;
            }
            @keyframes slideDown {
                from {
                    max-height: 0;
                    opacity: 0;
                }
                to {
                    max-height: 1000px;
                    opacity: 1;
                }
            }
            
            .q_question{
	            display: block;
	            cursor: pointer; /* 커서가 클릭하는 것이라고 인식 */
	            padding: 10px; /* 안쪽 여백 추가 */
	            margin: 0; /* 바깥 여백 제거 */
			}
	        
            .a_answer{
		            display: none; /* 처음에는 보이지 않도록 설정 */
		            padding: 10px; /* 안쪽 여백 추가 */
		            margin: 0; /* 바깥 여백 제거 */
			}
			
			.box{
				border: 1px solid #ccc; /* 경계선 추가 */
				margin: 10px 0; /* 상하에 여백, 좌우에 여백 없음 */
			}
        </style>
        
        <script>
        	/* Q 클릭시 A가 나옴. */
        	function qna_click(event){
        		var answer = event.nextElementSibling; /* 현재 요소의 형제 요소를 반환하는 속성이다. 여기서는 q_question의 형제인 a_answer를 반환함. */
        		if(answer.style.display == "none" || answer.style.display == ""){ /* 초기 값이 빈 문자열일 수 있기 때문에 */
        			answer.style.display = "block";
        		}else{
        			answer.style.display = "none";
        		}
        	}
        </script>
        
    </head>
    
    <body>
    
    <div id="header">
        <jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
    </div>
    
        <div class="container">
            <h1>자주 묻는 질문 (FAQ)</h1>
            
            
            <h2>1. 계좌 개설</h2>
            <!-- div를 클릭했을 때 이벤트가 발생하기 때문에 this만으로도 div를 가리킬 수 있음. -->
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 어떻게 계좌를 개설할 수 있나요?</div>
			<p class="a_answer">ㄴ A: 계좌 개설은 은행 지점 방문 또는 은행의 모바일 앱/웹사이트를 통해 가능합니다. 신분증과 기본 개인 정보가 필요하며, 온라인 개설 시에는 추가 인증 절차가 있을 수 있습니다.</p>
            </div>
            
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 비거주자도 계좌를 개설할 수 있나요?</div>
			<p class="a_answer">ㄴ A: 네, 비거주자도 계좌 개설이 가능합니다. 다만, 추가 서류(예: 여권, 비자 등)와 인증 절차가 필요할 수 있습니다.</p>
            </div>
            
            
            <h2>2. 인터넷 뱅킹</h2>
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 인터넷 뱅킹 가입은 어떻게 하나요?</div>
			<p class="a_answer">ㄴ A: 인터넷 뱅킹 가입은 은행 지점 방문 또는 은행의 모바일 앱/웹사이트를 통해 가능합니다. 계좌 번호와 신분증이 필요하며, 가입 후 초기 비밀번호 설정 및 보안 설정을 진행해야 합니다.</p>
            </div>
            
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 인터넷 뱅킹 비밀번호를 잊어버렸어요. 어떻게 해야 하나요?</div>
			<p class="a_answer">ㄴ A: 인터넷 뱅킹 비밀번호를 잊어버렸다면 은행 웹사이트나 앱에서 비밀번호 찾기 절차를 따르시면 됩니다. 필요 시 고객센터에 문의하여 본인 인증 후 비밀번호를 재설정할 수 있습니다.</p>
            </div>
            
            
            <h2>3. 모바일 뱅킹</h2>
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 모바일 뱅킹 앱은 어디서 다운로드 받을 수 있나요?</div>
			<p class="a_answer">ㄴ A: 모바일 뱅킹 앱은 구글 플레이 스토어(Android)나 애플 앱 스토어(iOS)에서 다운로드 받을 수 있습니다. 앱 이름은 [은행명]을 검색하여 다운로드하세요.</p>
            </div>
            
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 모바일 뱅킹에서 이체 한도가 있나요?</div>
			<p class="a_answer">ㄴ A: 네, 모바일 뱅킹 이체 한도는 보안 등급에 따라 다를 수 있습니다. 기본 한도는 앱에서 확인 가능하며, 필요 시 은행 지점을 방문하여 한도 상향 신청이 가능합니다.</p>
            </div>
            
            
            <h2>4. 카드 관련</h2>
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 새로 발급받은 카드는 어떻게 활성화 하나요?</div>
			<p class="a_answer">ㄴ A: 새로 발급받은 카드는 은행의 모바일 앱, 인터넷 뱅킹, 또는 고객센터를 통해 활성화할 수 있습니다. 카드 뒷면의 고객센터 전화번호로 전화하여 활성화할 수도 있습니다.</p>
            </div>
            
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 분실한 카드는 어떻게 신고하나요?</div>
			<p class="a_answer">ㄴ A: 카드를 분실한 경우 즉시 은행 고객센터에 전화하거나, 모바일 앱 또는 인터넷 뱅킹을 통해 분실 신고를 하셔야 합니다. 필요 시 카드를 재발급 받으실 수 있습니다.</p>
            </div>
            
            
            <h2>5. 대출</h2>
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 대출 신청은 어떻게 하나요?</div>
			<p class="a_answer">ㄴ A: 대출 신청은 은행 지점 방문, 인터넷 뱅킹, 또는 모바일 뱅킹을 통해 가능합니다. 대출 종류에 따라 필요 서류와 심사 절차가 다를 수 있습니다.</p>
            </div>
            
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 대출 상환 방법은 어떻게 되나요?</div>
			<p class="a_answer">ㄴ A: 대출 상환은 매월 정기적으로 자동이체 설정을 통해 이루어질 수 있으며, 인터넷 뱅킹이나 모바일 뱅킹을 통해 직접 상환할 수도 있습니다. 자세한 상환 일정과 방법은 대출 계약서에 명시되어 있습니다.</p>
            </div>
            
            
            <h2>6. 고객 서비스</h2>
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 고객센터 운영 시간은 어떻게 되나요?</div>
			<p class="a_answer">ㄴ A: 고객센터 운영 시간은 평일 오전 9시부터 오후 6시까지입니다. 일부 서비스는 24시간 자동 응답 시스템을 통해 제공될 수 있습니다.</p>
            </div>
            
            <div class="box">
			<div class="q_question" onclick="qna_click(this);">▶ Q: 상담원 연결이 어렵습니다. 다른 방법이 있나요?</div>
			<p class="a_answer">ㄴ A: 상담원 연결이 어려운 경우, 은행의 챗봇 서비스 또는 FAQ 페이지를 이용해 보세요. 이메일 문의나 은행 웹사이트의 고객 문의 양식을 통해서도 도움을 받을 수 있습니다.</p>
            </div>
            
        </div>
        
        <!-- 하단 footer -->
        <div id="footer">
            <jsp:include page="/WEB-INF/views/footer_header.jsp"></jsp:include>
        </div>
        
    </body>
</html>
