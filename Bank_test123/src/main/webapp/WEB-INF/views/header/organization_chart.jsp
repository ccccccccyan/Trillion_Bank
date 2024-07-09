<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>조직도</title>
<link rel="stylesheet"
    href="https://cdnjs.cloudflare.com/ajax/libs/boxicons/2.0.7/css/boxicons.min.css">
<style>
body {
    font-family: 'Arial', sans-serif;
    background-color: #f4f4f9;
    display: flex;
    flex-direction: column;
    align-items: center;
    margin: 0;
    padding: 0;
}

#header {
    width: 100%;
}

.org-chart-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    margin-top: 20px;
    padding: 20px;
    box-sizing: border-box;
}

.org-chart {
    display: flex;
    flex-direction: column;
    align-items: center;
}

.level {
    display: flex;
    justify-content: center;
    margin: 20px 0;
}

.person-container {
    display: flex;
    flex-direction: column;
    align-items: center;
    text-align: center;
    position: relative; /* 추가: 포지션 설정 */
     z-index: 1; /* person 요소 위로 올리기 */
}

.person {
    width: 150px;
    height: 360px;
    background: linear-gradient(to bottom, #6799FF 33.33%, #fff 0%);
    color: #fff;
    padding: 20px 60px;
    margin: 15px 30px;
    border-radius: 60px;
    box-shadow: 0 6px 12px rgba(0, 0, 0, 0.2);
    cursor: pointer;
    transition: transform 0.2s, box-shadow 0.2s;
    font-size: 1.25em;
    position: relative; /* 추가: 포지션 설정 */
}

.person#jyh {
    width: 150px;
    height: 50px;
    background:#6799FF;
    border-radius: 60px;
}

.person:hover {
    transform: translateY(-5px);
    box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
}

.city-container {
    width: 100%;
    height: 40px;
    background-color: #999;
    padding: 10px;
    border-radius: 8px;
    margin-top: 40px;
    display: inline-block;
}

.city {
    font-size: 1.2em;
    color: #333;
    display: inline-block;
    margin-top: 10px;
}

.y-line {
    border-left: 3px solid #23212b;
    height: 40px;
    margin: -35px 0 0 0;
}

.y-line2 {
    border-left: 3px solid #23212b;
    height: 50px;
    margin: -43px 0 -15px 0;
}

.x-line {
    width: 75%;
    border-top: 3px solid #23212b;
    margin-top: -3px;
    margin-bottom: 20px;
}

/* 아이콘 스타일 */
i {
    font-size: 1em; /* 아이콘 크기 설정 */
    margin-bottom: -23px;
    z-index: 2; /* person 요소 위로 올리기 */
}
</style>

</head>
<body>

    <div id="header">
        <jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
    </div>

    <div class="org-chart-container">
        <div class="org-chart">
            <div class="level">
                <div class="person-container">
                    <div class="person" id="jyh">대주주 정용훈</div>
                </div>
            </div>
            <div class='y-line'></div>
            <hr class='x-line'></hr>
            <div class="level">
                <div class="person-container">
                    <div class='y-line2'></div>
                    <i class='bx bxs-circle' ></i>
                    <div class="person" id="ojh">
                        CEO 오종하
                        <div class="city-container">
                            <div class="city">강남점</div>
                        </div>
                    </div>
                    <div class='y-line3'></div>
                </div>
                <div class="person-container">
                    <div class='y-line2'></div>
                    <i class='bx bxs-circle' ></i>
                    <div class="person" id="ksy">
                        전무이사 김서영
                        <div class="city-container">
                            <div class="city">인천 서구점</div>
                        </div>
                    </div>
                    <div class='y-line3'></div>
                </div>
                <div class="person-container">
                    <div class='y-line2'></div>
                    <i class='bx bxs-circle' ></i>
                    <div class="person" id="jmk">
                        상무이사 장민경
                        <div class="city-container">
                            <div class="city">역삼점</div>
                        </div>
                    </div>
                    <div class='y-line3'></div>
                </div>
                <div class="person-container">
                    <div class='y-line2'></div>
                    <i class='bx bxs-circle' ></i>
                    <div class="person" id="kjh">
                        인턴 김지환
                        <div class="city-container">
                            <div class="city">배곧점</div>
                        </div>
                    </div>
                    <div class='y-line3'></div>
                </div>
            </div>
        </div>
    </div>

</body>
</html>
