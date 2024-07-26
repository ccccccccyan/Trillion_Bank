### 🖥 프로젝트 소개

환율 조회, 환율 토론, 예금, 적금이 가능한 은행 사이트 입니다.


### 📅 개발 기간

- 2024.06.17 ~ 2024.07.26


### ⚙ 개발 환경
    
<table>
    <thead>
        <tr>
            <th>구분</th>
            <th>상세 Skill</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td>Front End</td>
            <td>JavaScript, HTML5, CSS3, Ajax</td>
        </tr>
        <tr>
            <td>Back End</td>
            <td>Java, JSP & Servlet, MyBatis</td>
        </tr>
        <tr>
            <td>Framework</td>
            <td>Spring</td>
        </tr>
        <tr>
            <td>Open API/Library</td>
            <td>Daum Address API, Kakao Maps API, Coolsms API / Swiper.js, Chart.js, Boxicons</td>
        </tr>
        <tr>
            <td>Database</td>
            <td>Oracle</td>
        </tr>
        <tr>
            <td>Tool</td>
            <td>Oracle</td>
        </tr>
        <tr>
            <td>Environment</td>
            <td>Windows 10, Tomcat</td>
        </tr>
        <tr>
            <td>Collaboration</td>
            <td>GitHub</td>
        </tr>
    </tbody>
</table>
  
<hr>


### 👩‍💻 팀원 구성 👨‍💻

- 조장 장민경 👩‍💻
    - 메인 페이지 일반회원 (본인 계좌 리스트 및 예적금 상품 리스트 조회, 예적금 만기시 해지 및 적금 출금 기능 구현)
    - 관리자 (일반 회원의 계좌 번호로 사용자 정보 조회 및 수정 , coolsms api를 활용한 본인인증 구현)
    - 비회원과 그 외 기능들 (환율 토론, QNA, 공지 게시판 최신 글 10개 조회, 최근 한 달간의 나라별 환율 그래프 조회)
    - 환율 계산
    - 외화 원화 환전 ( 계좌 비밀번호 5회 불일치시 계좌 잠금 기능 구현 )
    - fetch와 chart.js 라이브러리를 활용한 환율 그래프 구현
    - swiper.js 라이브러리를 활용한 통장 및 예적금 스와이프 기능 구현
    - 계좌 개설(추가) (은행 선택, 계좌번호 입력, 통장 색 선택)
    - head 헤더 (로고 클릭시 메인 페이지 이동, 세부 카테고리, 로그아웃 등)
    - 개인 정보 수정 (수정 페이지로 이동시 계정 비밀번호 입력)
    - 회원 탈퇴 (회원 비활성화)



- 기획 김서영 👩‍💻
    - 기획 단계에서 페이지 구성 스토리보드 제작
    - 환율 토론 게시판(CRUD)
    - Q&A 게시판 (CRUD)
    - Notice 공지사항 게시판 (CRUD)
    - PPT 제작
    - 발표 대본 제작
    - readme 제작
    - footer 헤더 제작
    - 비밀번호 유효성 체크(환율 조회 페이지, 3개의 게시판 페이지, 3개의 게시글 페이지)
    - 기타 페이지 제작 (자주 묻는 질문, 개인정보 처리방침, 보안 공지사항, 이용약관, 법적 고지)




- 팀원 오종하 👨‍💻
    - 예금 가입 기능 (세금 우대, 과세, 비과세)
    - 계좌 상세 내역 (거래 대상, 거래 금액, 거래 일시 조회 등 입출금 내역 조회)
    - 계좌 거래 내역 검색 기능 (조회 기간별, 유형별, 정렬 순서)
    - 계좌 삭제
    - 계좌 송금 (송금할 계좌 유효성 체크 및, 추가 이체 기능 구현)
    - 송금 비밀번호 유효성 체크 (비밀번호 5회 불일치시 계좌 잠금)




- 팀원 김지환 👨‍💻
    - 적금 가입 (정기적금, 청년정기적금 추가 기능 구현)
    - 영업점 안내 페이지 (카카오맵 api 활용 지점마다 핀포인트 부여)
    - 로그인 (쿠키를 활용하여 로그인 정보 기억하기, 동결계정 차단)
    - 회원가입 ( 관리자 pwd를 통한 일반 사용자와 관리자 회원 가입 구분 기능 구현)
    - 회원가입시 (coolsms api를 활용한 본인인증, DAUM 주소 API 활용 유저 정보 저장)
    - 아이디/비밀번호 찾기 시 전화번호 본인인증 ( coolsms api를 활용 )
    - 비밀번호 변경
    - 기타 페이지 제작 (채용정보, 조직도, 연혁, 금융상품 수정)
    - 발표



👩‍💻👨‍💻👩‍💻👨‍💻
- 환율 api를 통한 데이터 수집
- chart.js를 활용한 그래프 구현 (데이터 시각화)
- Git Hub 활용 (코드 공유)


<hr>


[PPT로 주요 기능 보기](https://www.miricanvas.com/v/13fjuxm)


### 📌 주요 기능

- 메인 페이지 (Main Page)
    - 회원가입 및 로그인 (Sign Up, Log in)
    - 내 계좌 보기 (My Account)
    - 내 예금/적금 보기 (My Deposits/My Installment savings)
    - 환율 조회 (Exchange rate check)
    - 환율 토론 게시판 (댓글 comment 기능)
    - Q&A 게시판 (답변 reply 기능)
    - Notice 공지사항 게시판




- 회원가입 및 로그인 (Sign Up, Log in)
    - 아이디 저장(Remember ID), 아이디 찾기(Find ID), 비밀번호 찾기(Find Password)
    - ID, 전화번호 중복체크
        - 전화번호 인증 (SMS 문자 인증)




- 내 계좌 보기 💳
    - 새로운 계좌 개설(추가)
        - 은행 선택
        - 통장 색 선택
        - 계좌 번호 입력
        - 비밀번호 입력 (숫자 4자리)




- 송금 (Remittance)
    - 송금하기
    - 거래 내역 보기
    - 현재 잔액 확인
    - 계좌 번호 확인




- 내 예금/적금 보기 (My Deposits/My Installment savings)
    - 예금 (Deposits)
          - 예금 가입
          - 가입한 예금 해지 (자동해지 / 수동해지)


    - 적금 (Installment savings)
         - 적금 가입
           - 가입한 적금 해지 (자동해지 / 수동해지)




- 환율 조회 (Exchange rate check)
    - 비회원 / 관리자
        - 환율 계산하기
        - 전일 대비 환율
        - 최소 1개월 ~ 최대 1년 환율 조회
    - 회원
        - 환율 계산하기
        - 원화 환전
        - 외화 환전
        - 나의 외화 목록



- 환율 토론 게시판 (댓글 comment 기능)
    - 비회원
        - 게시글을 볼 수 있습니다.
        - 비밀번호를 입력하여 게시글을 삭제할 수 있습니다.
        - 비밀번호를 입력하여 게시글을 수정할 수 있습니다.
        - 댓글을 작성할 수 있습니다.
        - 비밀번호를 입력하여 댓글을 삭제할 수 있습니다.
    - 회원 / 관리자
        - 게시글을 작성할 수 있습니다.
        - 비밀번호를 입력하여 게시글을 삭제할 수 있습니다.
        - 비밀번호를 입력하여 게시글을 수정할 수 있습니다.
        - 댓글을 작성할 수 있습니다.
        - 비밀번호를 입력하여 댓글을 삭제할 수 있습니다.



- Q&A 게시판 (답변 reply 기능)
    - 비회원
        - 게시글을 볼 수 있습니다.
    - 회원
        - 게시글을 작성할 수 있습니다.
    - 관리자
        - 게시글에 답변할 수 있습니다.
        - 게시글을 삭제할 수 있습니다.



- Notice 공지사항 게시판
    - 비회원 / 회원
        - 게시글을 볼 수 있습니다.
    - 관리자
        - 게시글을 작성할 수 있습니다.
        - 게시글을 수정할 수 있습니다.
        - 게시글을 삭제할 수 있습니다.




- 관리자 메인 페이지
    - 사용자의 계정을 찾아 관리할 수 있습니다.
        - 사용자의 전화번호 인증을 받은 후 계정에 접근이 가능합니다.
        - 사용자의 정보를 관리할 수 있습니다.
![image (4)](https://github.com/user-attachments/assets/51b2021a-0196-467f-b07e-a70192b61ccc)
