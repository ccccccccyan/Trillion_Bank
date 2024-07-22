<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>개인정보 처리방침</title>
        
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
            <h1>은행 개인정보 처리방침</h1>
            
            <h2>제1조 (목적)</h2>
            <p>본 개인정보 처리방침은 <span class="highlight">[일조은행(Trillion Bank)]</span> (이하 "일조은행")이 고객의 개인정보를 처리함에 있어 개인정보 보호법을 준수하고, 고객의 권익을 보호하기 위함을 목적으로 합니다.</p>
            
            <h2>제2조 (개인정보의 수집 항목 및 수집 방법)</h2>
            <p>1. 수집하는 개인정보의 항목</p>
            <div class="definition">
                <p>- 필수항목: 성명, 생년월일, 성별, 연락처(전화번호, 이메일 등), 주소, 계좌번호, 신용카드 정보, 신분증 사본</p>
                <p>- 선택항목: 직업, 소득정보, 가족관계, 기타 고객이 제공하는 정보</p>
            </div>
            <p>2. 개인정보 수집 방법</p>
            <div class="definition">
                <p>- 홈페이지, 모바일 앱, 서면 양식, 전화, 팩스, 이메일, 고객센터 문의, 제휴사로부터의 제공</p>
            </div>
            
            <h2>제3조 (개인정보의 처리 목적)</h2>
            <p>은행은 다음과 같은 목적을 위해 개인정보를 처리합니다:</p>
            <div class="definition">
                <p>- 금융 거래 본인 인증 및 서비스 제공</p>
                <p>- 계좌 개설 및 관리</p>
                <p>- 고객 상담 및 민원 처리</p>
                <p>- 신규 서비스 개발 및 마케팅</p>
                <p>- 법적/규제 의무 이행</p>
            </div>
            
            <h2>제4조 (개인정보의 제3자 제공)</h2>
            <p>은행은 고객의 개인정보를 원칙적으로 외부에 제공하지 않습니다. 다만, 다음의 경우에는 예외로 합니다:</p>
            <div class="definition">
                <p>- 고객의 동의를 받은 경우</p>
                <p>- 법령에 의거하거나, 수사 목적으로 법령에 정해진 절차와 방법에 따라 수사기관의 요구가 있는 경우</p>
            </div>
            
            <h2>제5조 (개인정보의 처리 위탁)</h2>
            <p>은행은 서비스 이행을 위해 아래와 같이 개인정보 처리를 위탁하고 있으며, 위탁 계약 시 개인정보가 안전하게 관리될 수 있도록 필요한 사항을 규정하고 있습니다:</p>
            <div class="definition">
                <p>- 위탁 대상자: [위탁업체명]</p>
                <p>- 위탁 업무 내용: [위탁업무내용]</p>
            </div>
            
            <h2>제6조 (개인정보의 보유 및 이용 기간)</h2>
            <p>은행은 법령에 따른 개인정보 보유 및 이용 기간 또는 고객으로부터 개인정보를 수집 시에 동의 받은 개인정보 보유 및 이용 기간 내에서 개인정보를 처리, 보유합니다.</p>
            <div class="definition">
                <p>- 거래 종료 후 5년</p>
                <p>- 법령에 따른 보존 기간이 명시된 경우 해당 기간</p>
            </div>
            
            <h2>제7조 (개인정보의 파기 절차 및 방법)</h2>
            <p>은행은 개인정보 보유 기간의 경과, 처리 목적 달성 등 개인정보가 불필요하게 되었을 때에는 지체 없이 해당 개인정보를 파기합니다.</p>
            <div class="definition">
                <p>- 파기 절차: 파기 사유가 발생한 개인정보를 선정하고, 은행의 개인정보 보호책임자의 승인을 받아 파기</p>
                <p>- 파기 방법: 전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용하여 파기하며, 종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각</p>
            </div>
            
            <h2>제8조 (고객의 권리와 그 행사 방법)</h2>
            <p>고객은 언제든지 자신의 개인정보 열람, 정정, 삭제, 처리 정지 요구 등의 권리를 행사할 수 있습니다. 이를 위해 고객센터를 통해 서면, 전화, 이메일 등의 방법으로 은행에 요청할 수 있습니다.</p>
            
            <h2>제9조 (개인정보의 안전성 확보 조치)</h2>
            <p>은행은 고객의 개인정보를 안전하게 처리하기 위하여 다음과 같은 조치를 취하고 있습니다:</p>
            <div class="definition">
                <p>- 관리적 조치: 내부관리계획 수립 및 시행, 정기적 직원 교육</p>
                <p>- 기술적 조치: 개인정보처리시스템 등의 접근권한 관리, 접근통제시스템 설치, 고유식별정보 등의 암호화</p>
                <p>- 물리적 조치: 전산실, 자료 보관실 등의 접근 통제</p>
            </div>
            
            <h2>제10조 (개인정보 보호책임자 및 담당자 연락처)</h2>
            <p>은행은 개인정보 처리에 관한 업무를 총괄해서 책임지고, 고객의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.</p>
            <div class="definition">
                <p>- 개인정보 보호책임자: [성명, 직책, 연락처]</p>
                <p>- 개인정보 보호담당자: [성명, 직책, 연락처]</p>
            </div>
            
            <h2>제11조 (개인정보 처리방침 변경)</h2>
            <p>이 개인정보 처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경 내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.</p>
            
            <p><span class="highlight">부칙</span></p>
            <p>- 이 개인정보 처리방침은 [2014.07.01]부터 시행됩니다.</p>
        </div>
        
        <!-- 하단 footer -->
        <div id="footer">
            <jsp:include page="/WEB-INF/views/footer_header.jsp"></jsp:include>
        </div>
        
    </body>
</html>
