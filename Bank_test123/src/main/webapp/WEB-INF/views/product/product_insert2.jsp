<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
		<script src="/bank/resources/js/httpRequest.js"></script>
     <style>
         body {
           display: flex;
           justify-content: center;
           align-items: center;
           height: 100vh;
           margin: 0;
           font-family: Arial, sans-serif;
           background-color: #f0f0f0;
        }
        #container, #form-container {
            background-color: white;
            padding: 20px;
            border-radius: 10px;
            width: 80%;
            max-width: 520px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        .modal {
            display: none;
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.5);
            justify-content: center;
            align-items: center;
        }
         .modal-content {
            background-color: white;
            padding: 20px;
            border-radius: 5px;
            max-width: 800px;
            width: 800px;
        }
        .modal-content p {
            max-height: 400px;
            overflow-y: auto;
            white-space: pre-line;
        }
        .options-tax {
            display: flex;
            justify-content: space-between;
        }
        .option {
            text-align: center;
            padding: 10px;
            border: 1px solid #ccc;
            cursor: pointer;
            position: relative;
            width: 30%;
            margin: 10px 0;
            border-radius: 5px;
        }
        .option:hover {
            background-color: #f0f0f0;
        }
        .option.active {
            background-color: #007bff;
            color: white;
        }
        .tooltip {
            font-size: 0.8em;
            color: red;
            cursor: pointer;
        }
        .tooltiptext {
            visibility: hidden;
            width: 290px;
            background-color: #555;
            color: #fff;
            text-align: center;
            border-radius: 5px;
            padding: 5px;
            position: absolute;
            z-index: 1;
            bottom: 125%;
            left: 50%;
            margin-left: -145px;
            opacity: 0;
            transition: opacity 0.3s;
        }
        .tooltiptext::after {
            content: "";
            position: absolute;
            top: 100%;
            left: 50%;
            margin-left: -5px;
            border-width: 5px;
            border-style: solid;
            border-color: #555 transparent transparent transparent;
        }
        .option:hover .tooltiptext {
            visibility: visible;
            opacity: 1;
        }
        h4 {
            margin-bottom: 10px;
        }
        select, input[type="text"], input[type="button"] {
            width: 100%;
            padding: 10px;
            margin: 5px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        input[type="password"]{
        	width: 497px;
        	padding: 10px;
            margin: 5px 0 15px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }
        .agree-button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        .submit_button:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }
        
        /* 비활성화되지 않은 상태일 때의 호버 효과 */
		.agree-button:not(:disabled):hover {
		    background-color: #45a049; /* 호버 시 배경색 변경 */
		}
        
        .submit_button:not(:disabled):hover {
		    background-color: #45a049; /* 호버 시 배경색 변경 */
		}
        
        input[type="button"] {
            background-color: #4CAF50;
            color: white;
            cursor: pointer;
        }
        input[type="button"][name="agreeButton"]:hover {
    		background-color: #cccccc; /* 호버 시 배경색 변경 */
		}
        
        
        input[type="button"][name="insert_product"]:hover {
            background-color: #45a049;
        }
        #limit_money, #rate_viewtable {
            display: none;
        }
        #
        #detail-tax {
            cursor: pointer;
            color: #007bff;
        }
        #account_nowmoney{
        	color: gray;
        }
    </style>
 	<script>
        const terms = {
            1: '<h2>예금거래 기본약관</h2><h3>제1장 총칙</h3><h3>&nbsp제1조 (목적)</h3>본 약관은 일조은행(이하 "본 은행"이라 한다)과 고객 간의 예금 거래에 관한 제반 사항을 규정함으로써, 거래의 명확성 및 투명성을 확보함을 목적으로 한다.<h3>&nbsp제2조 (용어의 정의)</h3>"예금"이라 함은 고객이 본 은행에 금전을 예치하고 본 은행이 이를 수취하는 것을 말한다.\n"고객"이라 함은 본 은행과 예금 거래를 하는 개인 또는 법인을 말한다.\n"본 은행"이라 함은 본 약관에 따라 예금 거래를 수행하는 금융기관을 말한다.<h3>&nbsp제3조 (약관의 효력 및 변경)</h3>본 약관은 본 은행과 고객 간의 예금 거래에 적용된다.\n본 은행은 필요한 경우 본 약관을 변경할 수 있으며, 변경된 약관은 본 은행의 영업점 및 인터넷 홈페이지에 게시함으로써 효력이 발생한다.고객이 변경된 약관에 동의하지 않는 경우, 고객은 예금을 해지할 수 있다.<h3>제2장 예금의 개설 및 관리</h3><h3>&nbsp제4조 (예금의 개설)</h3>예금을 개설하고자 하는 고객은 본 은행이 정한 절차에 따라 계좌 개설 신청서를 제출하여야 한다.\n본 은행은 필요 시 고객에게 신원 확인을 위한 서류를 요구할 수 있다.<h3>&nbsp제5조 (예금의 관리)</h3>고객은 본 은행의 지시에 따라 예금을 관리하여야 하며, 예금의 입출금 및 잔액 조회는 본 은행이 정한 방법에 따른다.\n본 은행은 고객의 예금을 안전하게 관리할 의무가 있으며, 고객의 요청에 따라 예금 관련 정보를 제공한다.<h3>제3장 예금의 입금 및 출금</h3><h3>&nbsp제6조 (입금)</h3>고객은 본 은행이 정한 방법에 따라 예금을 입금할 수 있다.\n입금된 금액은 본 은행이 확인한 시점부터 예금으로 인정된다.<h3>&nbsp제7조 (출금)</h3>고객은 본 은행이 정한 방법에 따라 예금을 출금할 수 있다.\n본 은행은 고객의 신원 확인을 위해 출금 시 필요한 서류를 요구할 수 있다.<h3>제4장 예금의 해지 및 정산</h3><h3>&nbsp제8조 (예금의 해지)</h3>고객은 본 은행이 정한 절차에 따라 예금을 해지할 수 있다.\n예금 해지 시 본 은행은 고객에게 예금 잔액을 지급한다.<h3>&nbsp제9조 (예금의 정산)</h3>예금이 해지된 경우, 본 은행은 해지일까지의 이자를 포함한 예금 잔액을 고객에게 지급한다.\n본 은행은 예금 해지 시 발생하는 수수료를 공제할 수 있다.<h3>제5장 기타</h3>\n<h3>&nbsp제10조 (면책사항)</h3>\n본 은행은 천재지변, 전쟁, 테러, 정부의 명령 등 불가항력적인 사유로 인한 예금 거래의 지연 또는 불이행에 대해 책임지지 않는다.<h3>&nbsp제11조 (분쟁 해결)</h3>\n본 은행과 고객 간의 예금 거래로 인한 분쟁은 본 은행의 본점 소재지를 관할하는 법원을 제1심 관할 법원으로 한다.',
            2: '<h2>제1장: 예금의 종류</h2><h3>제1조 (예금의 정의)</h3>\n일조은행은 다양한 종류의 예금을 제공합니다. 예금이란 고객이 일조은행에 자금을 예치하고 이를 일정 기간 동안 보관하며, 그에 따른 금융서비스를 제공받을 수 있는 금융상품을 말합니다.<h3>제2조 (예금의 종류)</h3>예금의 종류는 다음과 같습니다.가. 보통예금: 일조은행에 예치한 금액을 언제든지 인출할 수 있는 예금으로, 일반적인 금융거래에 사용됩니다.나. 적금: 정기적으로 일정 금액을 예치하고 이에 대해 정해진 기간 동안 일정한 이자를 지급받을 수 있는 예금으로, 장기적인 금융 계획에 유리합니다.다. 예적금: 일정 기간 동안 예치한 금액에 대해 미리 약정된 금리를 적용받는 예금으로, 안정적인 이자 수익을 추구하는 고객에게 적합합니다.<h3>제3조 (예금의 이자율)</h3>\n예금의 종류에 따라 적용되는 이자율은 일조은행의 정책에 따라 다를 수 있으며, 고객은 이를 언제든지 확인할 수 있습니다.<h3>제4조 (예금의 인출 및 해지)</h3>예금의 인출 및 해지는 일조은행의 영업점에서 신분증을 제시하여 가능합니다. 단, 일부 예금 상품에는 일정 기간 후에 해지할 수 있는 조건이 존재할 수 있습니다.<h3>제2장: 예금의 운용</h3><h3>제5조 (예금의 운용)</h3>예금의 운용은 고객의 요구에 따라 다양한 금융서비스를 제공합니다. 예금에 대한 잔액 조회, 이체, 자동이체 등의 서비스를 무료로 제공합니다.<h3>제6조 (예금의 보호)</h3>\n일조은행은 금융감독원의 지침에 따라 예금을 보호하고 있으며, 법적으로 정해진 보호대상에 포함됩니다.<h3>제3장: 기타</h3><h3>제7조 (약관의 변경)</h3>\n일조은행은 필요한 경우 본 약관을 변경할 수 있으며, 변경 사항은 고객에게 사전에 공지합니다.<h3>제8조 (분쟁의 해결)</h3>예금거래에 관한 분쟁이 발생할 경우, 일조은행과 고객은 상호 협의하여 원만히 해결하도록 합니다. 해결이 어려운 경우, 관련 법령과 일조은행의 내부규정에 따라 해결합니다.',
            3: '<h2>일조은행 상품설명서</h2><h3>예금거래 기본약관</h3><h3>제1장 총칙</h3><h3>제1조 (목적)</h3><p>본 약관은 일조은행(이하 "본 은행"이라 한다)과 고객 간의 예금 거래에 관한 제반 사항을 규정함으로써, 거래의 명확성 및 투명성을 확보함을 목적으로 한다.</p><h3>제2조 (용어의 정의)</h3><ul><li>"예금"이라 함은 고객이 본 은행에 금전을 예치하고 본 은행이 이를 수취하는 것을 말한다.</li><li>"고객"이라 함은 본 은행과 예금 거래를 하는 개인 또는 법인을 말한다.</li><li>"본 은행"이라 함은 본 약관에 따라 예금 거래를 수행하는 금융기관을 말한다.</li></ul><h3>제3조 (약관의 효력 및 변경)</h3><p>본 약관은 본 은행과 고객 간의 예금 거래에 적용된다. 본 은행은 필요한 경우 본 약관을 변경할 수 있으며, 변경된 약관은 본 은행의 영업점 및 인터넷 홈페이지에 게시함으로써 효력이 발생한다. 고객이 변경된 약관에 동의하지 않는 경우, 고객은 예금을 해지할 수 있다.</p><h3>제2장 예금의 개설 및 관리</h3><h3>제4조 (예금의 개설)</h3><p>예금을 개설하고자 하는 고객은 본 은행이 정한 절차에 따라 계좌 개설 신청서를 제출하여야 한다. 본 은행은 필요 시 고객에게 신원 확인을 위한 서류를 요구할 수 있다.</p><h3>제5조 (예금의 관리)</h3><p>고객은 본 은행의 지시에 따라 예금을 관리하여야 하며, 예금의 입출금 및 잔액 조회는 본 은행이 정한 방법에 따른다. 본 은행은 고객의 예금을 안전하게 관리할 의무가 있으며, 고객의 요청에 따라 예금 관련 정보를 제공한다.</p><h3>제3장 예금의 입금 및 출금</h3><h3>제6조 (입금)</h3><p>고객은 본 은행이 정한 방법에 따라 예금을 입금할 수 있다. 입금된 금액은 본 은행이 확인한 시점부터 예금으로 인정된다.</p><h3>제7조 (출금)</h3><p>고객은 본 은행이 정한 방법에 따라 예금을 출금할 수 있다. 본 은행은 고객의 신원 확인을 위해 출금 시 필요한 서류를 요구할 수 있다.</p><h3>제4장 예금의 해지 및 정산</h3><h3>제8조 (예금의 해지)</h3><p>고객은 본 은행이 정한 절차에 따라 예금을 해지할 수 있다. 예금 해지 시 본 은행은 고객에게 예금 잔액을 지급한다.</p><h3>제9조 (예금의 정산)</h3><p>예금이 해지된 경우, 본 은행은 해지일까지의 이자를 포함한 예금 잔액을 고객에게 지급한다. 본 은행은 예금 해지 시 발생하는 수수료를 공제할 수 있다.</p><h3>제5장 기타</h3><h3>제10조 (면책사항)</h3><p>본 은행은 천재지변, 전쟁, 테러, 정부의 명령 등 불가항력적인 사유로 인한 예금 거래의 지연 또는 불이행에 대해 책임지지 않는다.</p><h3>제11조 (분쟁 해결)</h3><p>본 은행과 고객 간의 예금 거래로 인한 분쟁은 본 은행의 본점 소재지를 관할하는 법원을 제1심 관할 법원으로 한다.</p>',
            4: '<h2>세금우대/비과세종합 저축 약관<h2><h3>1. 세금우대저축</h3><h3>가입한도</h3><p>일조은행 예적금 합산 3,000만원</p><h3>가입대상자</h3><p>만 19세 이상 회원 가입 가능</p><p><span style="color: #7CB5BE; font-weight: bold;">가입 직전 3개 과세기간 중 1회 이상 금융소득종합과세 대상자는 제외</span></p><h3>세율</h3><ul>    <li style="list-style: disc;">2028년 12월 31일까지 발생하는 이자소득: 5% (이자소득세 3.6%, 농특세 1.4%)</li>    <li style="list-style: disc;">2029년 1월 1일 이후 발생하는 이자소득: 9.5% (이자소득세 9%, 농특세 0.5%)</li></ul><h2>2. 비과세종합저축</h2><h3>가입한도</h3><p>전 금융기관 합산 5천만원. 2014년 12월 31일 이전에 개설한 세금우대종합저축, 생계형 저축 한도 합산</p><h3>가입대상자</h3><ul>    <li style="list-style: disc;">만 65세 이상 거주자 (2015년 만 61세부터 1세씩 상향)</li>    <li style="list-style: disc;"><span style="color: #7CB5BE; font-weight: bold;">장애인 / 독립유공자와 그 가족 또는 유족 / 국가유공상이자 / 기초생활수급자 / 고엽제후유의중환자 / 5.18민주화운동부상자에 해당하시는 분은 일조은행을 직접 방문하여 비과세종합저축으로 가입하시거나, 인터넷뱅킹에서 일반과세 가입 후 15일 이내 일조은행에 방문하여 (증빙서류 지참) 비과세종합저축으로 변경하시기 바랍니다.</span></li>    <li style="list-style: disc;"><span style="color: #7CB5BE; font-weight: bold;">가입 직전 3개 과세기간 중 1회 이상 금융소득 종합과세 대상자는 제외</span></li></ul><h3>세율</h3><p>2025년까지 가입하는 경우: 0%</p><p>단, 비과세종합저축 계약기간의 만료일 이후 발생하는 이자(만기후이자)는 일반과세(이자소득의 15.4%)됩니다.</p>',
        	5: '<h2>계좌간 자동이체/인터넷뱅킹 연결계좌 서비스 이용약관</h2><h3>1. 서비스 개요</h3><h3>1.1 서비스 내용</h3><p>계좌간 자동이체/인터넷뱅킹 연결계좌 서비스는 고객이 본인의 일조은행 예금 계좌와 다른 금융기관의 계좌 간에 자동 이체를 설정하거나 인터넷뱅킹을 통해 연결하는 서비스를 말합니다.</p><h3>1.2 서비스 장점</h3><p>고객은 본인의 일조은행 예금 계좌를 연결하여, 만기 시 해당 계좌로 이자를 자동 입금 받거나, 서비스 해제 시에도 본인의 일조은행 계좌로 자동 입금할 수 있습니다.</p><h2>2. 서비스 이용 방법</h2><h3>2.1 계좌 연결</h3><p>고객은 일조은행의 인터넷뱅킹 서비스를 통해 계좌간 자동이체/인터넷뱅킹 연결계좌 서비스를 신청할 수 있습니다. 신청 시 본인 확인 절차를 거치고 설정한 후 서비스를 이용할 수 있습니다.</p><h3>2.2 이용 범위</h3><p>본 서비스는 고객이 일조은행 예금 계좌와 다른 금융기관의 계좌 간 이체를 통해 예금 운용 편의성을 높이는 목적으로 제공됩니다.</p><h2>3. 서비스 종료 및 이체 처리</h2><h3>3.1 서비스 해제</h3><p>고객이 본 서비스를 해제하고자 할 경우, 일조은행의 인터넷뱅킹을 통해 해제 절차를 진행할 수 있습니다. 해제 시, 만기 시 입금했던 이자 및 예치금은 고객이 본인의 일조은행 예금 계좌로 반환됩니다.</p><h3>3.2 만기 이자 입금</h3><p>계좌간 자동이체 서비스를 설정한 고객은 예금의 만기 시점에 해당 계좌로 자동으로 이자를 입금 받을 수 있습니다. 이자 지급은 일조은행의 정책에 따라 처리됩니다.</p>',
        	6: '<h2>예금자 보호 안내</h2><h3>1. 예금자 보호 제도 소개</h3><h3>1.1 예금자 보호의 목적</h3><p>일조은행은 고객의 예금을 안전하게 보호하기 위해 예금자 보호제도를 운영하고 있습니다. 이는 예금자의 이해와 안전성을 최우선으로 하여 예금 거래를 보호하는 데에 목적이 있습니다.</p><h3>1.2 보호 대상</h3><p>예금자 보호 대상에는 일조은행에 예치된 모든 예금이 포함됩니다. 예금 보호 대상 금액은 1인당 최고 5천만원까지 일조은행 예금자 보호 준비금에 의해 보호됩니다.</p><h3>1.3 보호 범위</h3><p>일조은행 예금자 보호 제도는 법적으로 정해진 한도 내에서 예금자의 원금과 이자를 보호합니다. 다만, 보호 대상 금액을 초과하는 부분에 대해서는 보호되지 않을 수 있습니다.</p><h2>2. 예금자 보호 절차</h2><h3>2.1 보호 절차</h3><p>예금자 보호는 일조은행 예금자 보호 준비금에 의해 자동으로 이루어집니다. 이는 고객이 일조은행에 예금을 예치할 경우 자동으로 적용되며, 별도의 신청 절차가 필요하지 않습니다.</p><h3>2.2 보호 범위 외의 예외</h3><p>일조은행 예금자 보호 제도는 일부 예외 사항이 있을 수 있으며, 이는 일조은행의 내부 규정 및 관련 법령에 따라 결정될 수 있습니다. 예를 들어, 특정 금융상품이나 특정 조건을 충족하지 않는 예금은 보호 범위에서 제외될 수 있습니다.</p><h2>3. 추가 정보 및 문의</h2><h3>3.1 보다 자세한 정보</h3><p>예금자 보호에 관한 보다 자세한 정보는 일조은행의 고객센터를 통해 문의하실 수 있습니다. 보호 제도에 대한 이해를 높이고 고객의 안전한 금융 거래를 지원하기 위해 항상 준비되어 있습니다.</p>'
        };
		
        let currentTermId = null;
        const modals = document.getElementsByClassName("modal");
        const requiredTerms = [1, 2, 3, 4, 5, 6];  // 필수 약관 ID 배열

        function toggleAll() {
            const checkAll = document.getElementById('checkAll').checked;
            const checkboxes = document.querySelectorAll('.term-check');
            checkboxes.forEach(checkbox => checkbox.checked = checkAll);
            updateAgreeButton();
        }

        function showTerm(id) {
            currentTermId = id;
            document.getElementById('termContent').innerHTML = terms[id].replace(/\n/g, '<br>');
            document.getElementById('modal').style.display = 'flex';
        }

        function agreeTerm() {
            if (currentTermId !== null) {
                const checkbox = document.getElementById("term" + currentTermId);
                if (checkbox) {
                    checkbox.checked = true;
                }
                document.getElementById('modal').style.display = 'none';
                updateAgreeButton();
            }
        }

        function updateAgreeButton() {
        	
        	
            const agreeButton = document.getElementById('agreeButton');
            let allChecked = true;

            requiredTerms.forEach(id => {
                if (!document.getElementById('term' + id).checked) {
                    allChecked = false;
                }
            });

            agreeButton.disabled = !allChecked;
        }
        function showForm() {
            document.getElementById('container').style.display = 'none';
            document.getElementById('form-container').style.display = 'block';
            let currentDate = new Date();
            let year = currentDate.getFullYear();      // 연도
            let month = currentDate.getMonth() + 1;    // 월 (0부터 시작)
            let date = currentDate.getDate();          // 일
            let formattedDate = year + '.' + month + '.' + date;

         // 예시: HTML 요소의 innerHTML을 이용하여 날짜 출력
         document.getElementById('product_date').innerHTML = formattedDate;
            
        }
       
        function optionSelected(optionId) {
        	 document.querySelectorAll('.option').forEach(option => {
                 option.classList.remove('active');
             });
        	 let element = document.getElementById(optionId);
        	 
        	 
        	 
        	 
             if (element) {
                 element.classList.toggle('active');
             }
        	
             // 'tax-favored' 또는 'non-taxable' 옵션을 클릭할 때 limit_money를 보이게 함
             if (optionId == 'tax-favored' || optionId == 'non-taxable') {
                 document.getElementById('limit_money').style.display = 'block';
             } else {
                 document.getElementById('limit_money').style.display = 'none';
             }
        	// 모든 설명을 숨김
            document.querySelectorAll('.tooltiptext').forEach(tooltip => {
                tooltip.style.visibility = 'hidden';
                tooltip.style.opacity = '0';
                
            });

            // 클릭한 옵션의 설명을 보임
            const tooltipToShow = document.querySelector('#' + optionId + ' .tooltiptext');
            tooltipToShow.style.visibility = 'visible';
            tooltipToShow.style.opacity = '1';
        
            setTimeout(() => {
                tooltipToShow.style.visibility = 'hidden';
                tooltipToShow.style.opacity = '0';
            }, 3000); // 3000ms = 3초
        
        }

        function showTooltip(id) {
            document.querySelectorAll('.tooltiptext').forEach(tooltip => {
                tooltip.style.visibility = 'hidden';
                tooltip.style.opacity = '0';
            });

            const tooltip = document.querySelector('#' + id + ' .tooltiptext');
            tooltip.style.visibility = 'visible';
            tooltip.style.opacity = '1';
        }
        function showAccountDetails() {
        	let select = document.getElementById("accountSelect");
            let selectedOption = select.options[select.selectedIndex];
            let nowMoney = selectedOption.value;
            let bankName = selectedOption.getAttribute("data-bank-name");
            let accountNumber = selectedOption.getAttribute("data-account-number");

            // 예시: 선택된 계좌의 정보를 출력
            let account_nowmoney = document.getElementById("account_nowmoney");
            account_nowmoney.innerHTML = "현재 잔액: " + nowMoney + "원";
                    
        }
        function rate_view() {
        	let table = document.getElementById("rate_viewtable");
            if (table.style.display === "none") {
                table.style.display = "table"; // 테이블 요소를 보이도록 설정
            } else {
                table.style.display = "none"; // 테이블 요소를 숨기도록 설정
            }
		}
        function insert_product(f) {
        	let taxfavored = document.getElementById('tax-favored').classList.contains('active');
            let taxable = document.getElementById('taxable').classList.contains('active');
            let nontaxable = document.getElementById('non-taxable').classList.contains('active');
            let now_money = Number(f.accountSelect.value);
            let input_pwd = f.input_pwd.value;
            let product_period = f.product_period.value;
            let deal_money = Number(f.input_deal_money.value);
            let auto = f.maturity.value;
			let tax_type = "";
			let product = "정기예탁금";
			let limit_money = Number(f.limit_money.value);
			let selectElement = document.getElementById('accountSelect');
            // 선택된 option 요소를 가져옵니다.
            let selectedOption = selectElement.options[selectElement.selectedIndex];
            // 선택된 option의 id 속성을 가져옵니다.
            let account_number = selectedOption.id;
        	
            if(taxfavored){
            	tax_type = "세금우대";
            }else if(taxable){
            	tax_type = "과세";
            }else{
            	tax_type = "비과세";
            }
            
            let onlynumberdeal_money = /^[0-9]+$/;
            
            if (!onlynumberdeal_money.test(deal_money) || deal_money <= 0){
            	alert("유효한 금액을 입력해주세요.");
            	return;
            }
            
            //잔액이 부족한지 확인
            if(now_money < deal_money){
            	alert("잔액이 부족합니다.");
            	return;
            }
            //예적금 한도 금액 초과여부
            if(deal_money > limit_money){
            	alert("예적금 한도를 초과하셨습니다.");
            	return;
            }
            
            let onlynumberpwd = /^[0-9]{4}$/;
            
            if(!onlynumberpwd.test(input_pwd)){
            	alert("계좌비밀번호는 숫자 4자리입니다.");
            	return;
            }
            
            let url = "check_product_pwd2.do";
            let param = "account_number=" + account_number + "&account_pwd=" + encodeURIComponent(input_pwd) + "&tax_type=" + tax_type + "&product_period=" + product_period + "&deal_money=" + deal_money + "&auto=" + auto + "&product=" + product;
            	sendRequest(url, param,  function () { resultcheck_productpwd(f); }, "post");
        	
        }
        function resultcheck_productpwd(f) {
        	if (xhr.readyState == 4 && xhr.status == 200) {
		        let data = xhr.responseText;
		        let json = (new Function('return ' + data))();
		        if (json[0].account_lockcnt == '5') {
	                alert("계좌 비빌번호 5회 실패! 일조은행에 문의해주세요.");
	                location.href = "account_list.do";
	            }
		        
		        if (json[0].result == 'no') {
	                alert( json[0].account_lockcnt + "/5 비밀번호 불일치");
	                return;
	            }else {
	                location.href = "result_deposit_product.do?pd_idx=" + json[0].pd_idx;
	           }
	      }
	}
        function check_form() {
            let input_deal_money = document.getElementsByName("input_deal_money")[0].value;
            let input_pwd = document.getElementsByName("input_pwd")[0].value;
            let product_period = document.getElementById("product_period").value;
            let maturity = document.querySelector('input[name="maturity"]:checked');

            // 각 필수 항목이 입력되었는지 확인
            if (input_deal_money.trim() !== "" &&
                input_pwd.trim() !== "" &&
                product_period !== "" &&
                maturity !== null) {
                // 모든 필수 항목이 입력되었으면 버튼 활성화
                document.getElementById("submit_button").disabled = false;
            } else {
                // 하나라도 입력되지 않았으면 버튼 비활성화
                document.getElementById("submit_button").disabled = true;
            }
        }

        // 페이지 로드 후 초기 체크
        document.addEventListener("DOMContentLoaded", function() {
            // 초기 유효성 검사
            check_form();

            // 입력 필드와 선택 옵션의 이벤트 핸들러 설정
            let input_deal_money = document.getElementsByName("input_deal_money")[0];
            let input_pwd = document.getElementsByName("input_pwd")[0];
            let product_period = document.getElementById("product_period");
            let maturity_options = document.querySelectorAll('input[name="maturity"]');
            
            input_deal_money.addEventListener("input", check_form);
            input_pwd.addEventListener("input", check_form);
            product_period.addEventListener("change", check_form);
            maturity_options.forEach(function(option) {
                option.addEventListener("change", check_form);
            });
        }); 
        
    </script>	
</head>
<body>
	
	<div id="container">
        <div><h2>약관 및 상품설명서</h2></div>
        <div>
            <input type="checkbox" id="checkAll" onclick="toggleAll()"> 전체 동의
        </div>
        <div>
            <input type="checkbox" class="term-check" id="term1" onclick="updateAgreeButton()"> [필수] 예금거래 기본약관 <button onclick="showTerm(1)">보기</button>
        </div>
        <div>
            <input type="checkbox" class="term-check" id="term2" onclick="updateAgreeButton()"> [필수] 예금거래종류 기본약관 <button onclick="showTerm(2)">보기</button>
        </div>
        <div>
            <input type="checkbox" class="term-check" id="term3" onclick="updateAgreeButton()"> [필수] 상품설명서 <button onclick="showTerm(3)">보기</button>
        </div>
        <div>
            <input type="checkbox" class="term-check" id="term4" onclick="updateAgreeButton()"> [필수] 세금우대/비과세종합 저축 약관 <button onclick="showTerm(4)">보기</button>
        </div>
        <div>
            <input type="checkbox" class="term-check" id="term5" onclick="updateAgreeButton()"> [필수] 계좌간 자동이체/인터넷뱅킹 연결계좌 서비스 이용약관 <button onclick="showTerm(5)">보기</button>
        </div>
        
        <div><h2>예금자 보호 안내</h2></div>
        <div>
            <input type="checkbox" class="term-check" id="term6" onclick="updateAgreeButton()"> 확인 [필수] <button onclick="showTerm(6)">보기</button>
        </div>
        <br><br>
        <input type="button" value="동의" id="agreeButton" class="agree-button" disabled onclick="showForm()">
    </div>

    <div id="form-container" style="display: none">
        <form>
            <h4>세금우대한도 조회 및 설정</h4>
            <div class="options options-tax">
                <div class="option" id="tax-favored" onclick="optionSelected('tax-favored')">
                    세금우대 <span class="tooltip">!</span>
                    <div class="tooltiptext">세금우대저축 조세특례 제한사항 안내                    	<hr>
                    	<p style="text-align: left; padding-left 5px;">&nbsp;조세특례제한법에 따라 직전 3개 과세기간 중 1회 이상 금융소득종합과세 대상에 해당하는 경우 가입대상에서 제외되며, 이후 부적격으로 판명될 경우 비과세에서
                    	일반과세로 전환 되거나 감면세액을 납부해야 합니다.<p>
                    	</div>
                </div>
                <div class="option" id="taxable" onclick="optionSelected('taxable')">
                    과세<span class="tooltip">!</span>
                    <div class="tooltiptext"><h4 style="text-align: left; padding-left: 5px;">과세</h4>
                    	<p style="text-align: left; padding-left: 5px;">·제한없음</p>
                    	<h4 style="text-align: left; padding-left: 5px;">세율</h4>
                    	<p style="text-align: left; padding-left: 5px;">·이자소득에 대하여 15.4% 과세(이자소득세 14%, 지방소득세 1.4%)</p>
                    </div>
                </div>
                <div class="option" id="non-taxable" onclick="optionSelected('non-taxable')">
                    비과세<span class="tooltip">!</span>
                    <div class="tooltiptext">비과세종합저축 조세특례 제한사항 안내
                    	<hr>
                    	<p style="text-align: left; padding: 5px;">&nbsp;조세특례제한법에 따라 직전 3개 과세기간 중 1회 이상 금융소득종합과세 대상에 해당하는 경우 가입대상에서 제외되며, 이후 부적격으로 판명될 경우 비과세에서
                    	일반과세로 전환 되거나 감면세액을 납부해야 합니다.<p>
                    	</div>
                </div>
            </div>
            <div id="limit_money" style="display: none">
	            <h3>우대한도 설정</h3>
	            <p> ·총한도 : 50000000원 / 가입가능한도: ${limit_money}원</p>	
            </div>
            
            <h4>출금계좌정보</h4>
            <select id="accountSelect" onchange="showAccountDetails()" onchange="check_form()">
                <option value="">계좌를 선택하세요</option>
                <c:forEach var="vo" items="${list}">
                    <option value="${vo.now_money}" id="${vo.account_number}">
                        ${vo.bank_name} ${vo.account_number}
                    </option>
                </c:forEach>
            </select>     
                <div id="account_nowmoney"></div>
                
                <h4>출금계좌 비밀번호</h4>
                <input type="password" name="input_pwd" maxlength="4" placeholder="숫자 4자리 입력">
                <h4>계약일자</h4>
                <div id="product_date"></div>
                <h4>계약기간</h4>
                <select id="product_period" onchange="showAccountDetails()" onchange="check_form()">
                	<option value="">선택하세요</option>
                	<option>3개월</option>
                	<option>6개월</option>
                	<option>12개월</option>
                	<option>24개월</option>
                	<option>36개월</option>
                </select>
                
                <h4>약정이율</h4>
                <div>약정이율 = 기본이율(%) + 우대이율(%)</div>
                <div id="detail-tax" onclick="rate_view();">기본이율 자세히 보기</div>
                <div><table id="rate_viewtable" border="1" style="border-collapse: collapse; display: none">
                	<tr>
                		<td>계약기간</td>
                		<td>만기지급식<br>기본이율</td>                		
                	</tr>
                	<tr>
                		<td>3개월</td>
                		<td>연 2.7%</td>
                	</tr>
                	<tr>
                		<td>6개월</td>
                		<td>연 2.9%</td>
                	</tr>
                	<tr>
                		<td>12개월</td>
                		<td>연 3.6%</td>
                	</tr>
                	<tr>
                		<td>24개월</td>
                		<td>연 3.6%</td>
                	</tr>
                	<tr>
                		<td>36개월</td>
                		<td>연 3.6%</td>
                	</tr>
                	
                </table></div>
                <input type="hidden" value="${limit_money}" name="limit_money">
                <h4>계약금액</h4>
                <input name="input_deal_money" placeholder="금액 입력(숫자입력)" onchange="check_form()">원
                <h4>만기시 자동해지 설정</h4>
                <input type="radio" id="no-auto-maturity" name="maturity" value="자동해지설정안함" onchange="check_form()">
			    <label for="no-auto-maturity">설정안함</label>
			    
			    <input type="radio" id="auto-maturity" name="maturity" value="자동해지설정" onchange="check_form()">
			    <label for="auto-maturity">설정</label><br>
                <input type="button" id="submit_button" class="submit_button" value="가입하기" disabled="disabled" onclick="insert_product(this.form);">
        </form>
    </div>

    <div class="modal" id="modal">
        <div class="modal-content">
            <p id="termContent"></p>
            <button onclick="agreeTerm()">동의하기</button>
        </div>
    </div>
    
</body>
</html>