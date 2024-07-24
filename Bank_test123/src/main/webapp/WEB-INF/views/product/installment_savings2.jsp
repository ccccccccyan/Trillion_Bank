<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>

	<head>
    <meta charset="UTF-8">
    <title>일조은행 정기적금</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            justify-content: center;
            align-items: center;
            height: 100vh;
            margin: 0;
            padding: 0;
            background-color: #f3f3f3;
        }

        #header {
            position: relative;
            z-index: 1000;
            margin-bottom: 20px;
        }
		.link-all {
            text-decoration: none;
            width: 400px;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            color: white;
        }


        .bank-link {
            text-decoration: none;
            padding: 20px;
            box-shadow: 0 3px 3px #1993A8;
            border-radius: 10px;
            width: 400px;
            background-color: #0F67B1;
            margin: 0 auto;
            display: flex;
            flex-direction: column;
            color: white;
        }

        .product-info {
        	width: 420px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #e3e3e3;
            padding: 10px;
            border-radius: 10px;
            margin-top: 10px;
            color: black;
        }
        .product-tax {
        	width: 420px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            background-color: #e3e3e3;
            padding: 10px;
            border-radius: 10px;
            margin-top: 10px;
            color: black;
        }

        .bank-link a {
            font-weight: bold;
            font-size: 20px;
            color: white;
            text-decoration: none;
        }

        .product-description {
            font-size: 16px;
            margin-top: 10px;
        }

        .prduct-img {
            display: flex;
            flex-direction: row;
            justify-content: space-between;
            margin-top: 20px;
        }

        .prduct-img div {
            text-align: center;
            background-color: #38ADC1;
            padding: 10px;
            border-radius: 10px;
            box-shadow: 0 2px 5px #364F6B;
        }

        .prduct-img img {
            width: 50px;
            height: 50px;
        }

        .confirmation {
            margin-top: 20px;
            padding: 10px 20px;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            background-color: #7CB5BE;
            color: white;
            font-size: 16px;
        }

        .confirmation:hover {
            background-color: #8EC7D0;
        }
        .info-details {
        	color: black;
        }
		html {
    		scroll-behavior: smooth;
		}
		
    </style>
    <script>
    function scrollToSmoothly(element) {
        const elementPosition = element.getBoundingClientRect().top;
        const startingY = window.pageYOffset;
        const targetY = startingY + elementPosition;

        const totalScrollDistance = targetY - startingY;
        let currentScrollPosition = 0;

        function scrollStep() {
            currentScrollPosition += Math.ceil(totalScrollDistance / 30);
            window.scrollTo(0, startingY + currentScrollPosition);
            
            if (currentScrollPosition < totalScrollDistance) {
                requestAnimationFrame(scrollStep);
            }
        }

        scrollStep();
    }
    

    function toggleInfo(section) {
        let info = document.getElementById("product-info-details");
        let tax = document.getElementById("product-tax-details");

        if (section === 'info') {
            if (info.style.display === 'none' || info.style.display === '') {
                info.style.display = 'block';
                tax.style.display = 'none'; 
                document.getElementById('info-arrow').textContent = '▲';
                document.getElementById('tax-arrow').textContent = '▼';
                scrollToSmoothly(info);
                //info.scrollIntoView({ behavior: 'smooth', block: 'start' });
            } else {
                info.style.display = 'none';
                document.getElementById('info-arrow').textContent = '▼';
            }
        } else if (section === 'tax') {
            if (tax.style.display === 'none' || tax.style.display === '') {
                tax.style.display = 'block';
                info.style.display = 'none';
                document.getElementById('tax-arrow').textContent = '▲';
                document.getElementById('info-arrow').textContent = '▼';
                scrollToSmoothly(tax);
                //tax.scrollIntoView({ behavior: 'smooth', block: 'start' });
            } else {
                tax.style.display = 'none';
                document.getElementById('tax-arrow').textContent = '▼';
            }
        }
    }
	</script>
    
</head>

<body>
    <div id="header">
        <jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
    </div>

    <div class="link-all">
        <div class="bank-link">
        <div class="title">
            <h2>정기적금</h2>
        </div>
        <div class="product-description">매월 일정액을 납입하는 적금</div><br>
        <div class="prduct-img">
            <div>
                <img width="50px" height="50px" src="/bank/resources/img/목돈.png"><br>
                목돈굴리기
            </div>
            <div>
                <img width="50px" height="50px" src="/bank/resources/img/기간.png"><br>
                1개월~3년
            </div>
            <div>
                <img width="50px" height="50px" src="/bank/resources/img/금액제한없음.png"><br>
                금액제한5000만원
            </div>
        </div>
        <br><br>
        <button class="confirmation" onclick="location.href='product_insert2.do'">상품가입</button>
        </div>
         <div class="product-info" onclick="toggleInfo('info')">
            <span>상품정보</span>
            <span id="info-arrow">▼</span>
        </div>
        <div id="product-info-details" class="info-details" style="display:none;">
            <h2>상품정보</h2>
            <p>일정기간 동안 일정금액을 은행에 예치하고 그 기간이 만료한때에 이자와 원금을 지급하는 적금</p>
            <h2>가입대상</h2>
            <p>제한없음</p>
            <h2>가입금액</h2>
            <p>5000만원</p>
            <h2>계약기간</h2>
            <p>1개월 이상 3년 이내(연,월단위)</p>
            <h2>이자지급</h2>
            <p>은행에서 정한 방식(월지급,만기지급) 중 선택</p>
            <h2>이율</h2>
            <p>일조은행은 상품가입시 이율이 기간이나 정책에 따라 다를 수 있으니 가입하실때 확인해주시기 바랍니다.</p>
            <h2>세제관련</h2>
            <p>세금우대저축 및 비과세종합저축 가능</p>
            <h2>유의사항</h2>
            <ul><li style="list-style: disc;">이 적금은 일조은행법에 따라, 본 일조은행에 있는 귀하의 모든 적금보호 대상 금융상품의 원금과 소정의
            이자를 합하여 1인당 "최고 5천만원까지" 일조은행 적금자보호준비금에 의해 보호되며, 5천만원 초과 금액에 대해서는 보호되지 않습니다.</li>
            <li style="list-style: disc;">일조은행의 취급상품에 따라 상품가입이 제한될 수 있습니다.</li>
            </ul>
        </div>
        <div class="product-tax" onclick="toggleInfo('tax')">
            <span>세금우대안내</span>
            <span id="tax-arrow">▼</span>
        </div>
        <div id="product-tax-details" class="info-details" style="display:none;">
            <h1>1.세금우대저축</h1>
            <h3>가입한도</h3>
            <p>일조은행 예적금 합산 3,000만원</p>
            <h3>가입대상자</h3>
            <p>만 19세 이상 회원 가입가능</p>
            <span style="color: #7CB5BE; font-weight: bold;">가입 직전 3개 과세기간 중 1회 이상 금융소득종합과세 대상자는 제외</span>
            <h3>세율</h3>
            <ul>
            	<li style="list-style: disc;">2028년 12월 31일까지 발생하는 이자소득:5%<br>(이자소득세 3.6%, 농특세1.4%)</li>           	
            	<li style="list-style: disc;">2029년 1월 1일 이후 발생하는 이자소득:9.5%<br>(이자소득세 9%, 농특세0.5%)</li>           	
            </ul>
            <h2>2.비과세종합저축</h2>
            <h3>가입한도</h3>
            <p>전 금융기관 합산 5천만원 2014년 12월 31일 이전에 개설한 세금우대종합저축,<br>생계형 저축 한도 합산</p>
            <h3>가입대상자</h3>
            <ul>
            	<li style="list-style: disc;">만 65세 이상 거주자(2015년 만61세부터 1세씩 상향)<br>
            	 								2015년(만 61세), 2016년(만 62세), 2017년(만 63세),
            	 								2018년(만 64세), 2019년 이후(만65세)</li> <br>
            	<li style="list-style: disc;"><span style="color: #7CB5BE; font-weight: bold;">장애인 / 독립유공자와 그 가족 또는 유족 /<br>
            								  국가유공상이자 / 기초생활수급자 /<br> 고엽제후유의중환자 /
            								  5.18민주화운동부상자에 해당하시는 분은 일조은행을 직접 방문하여 비과세종합저축으로 가입하시거나,
            								  인터넷뱅킹에서 일반과세 가입 후 15일이내
            								  일조은행에 방문하여(증빙서류 지참)
            								  비과세종합저축으로 변경하시기 바랍니다.</span></li><br>
            	<li style="list-style: disc;"><span style="color: #7CB5BE; font-weight: bold;">가입 직전 3개 과세기간 중 1회 이상 금융소득 종합과세 대상자는 제외</span></li>
            </ul>
            <h3>세율</h3>
            <p>2025년까지 가입하는 경우:0%<br>
            단, 비과세종합저축 계약기간의 만료일 이후 발생하는 이자(만기후이자)는 일반과세(이자소득의 15.4%)됩니다.</p>
        </div>
</div>


</body>

</html>