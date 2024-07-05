<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Insert title here</title>
        <style>
            /* 기본 스타일 설정 */
            .container {
                margin: 0 auto;
                width: 400px;
                border: 1px solid #ccc;
                border-radius: 15px;
                padding: 30px;
                background-color: #f0f0f0;
                display: flex; /* Flex 컨테이너로 설정 */
                flex-direction: column; /* 세로 방향으로 요소들을 배치 */
                align-items: center; /* 세로 방향으로 중앙 정렬 */
            }

            .title {
                font-size: 18px;
                margin-bottom: 10px;
            }

            .options {
                display: flex; /* 옵션들을 가로로 정렬하기 위해 Flex로 설정 */
                gap: 10px;
                margin-bottom: 15px;
                width: 300px;
                justify-content: center; /* 옵션들 가로 방향 중앙 정렬 */
            }

            .options div, .options select, .options input {
                padding: 10px;
                cursor: pointer;
                background-color: white;
                border: 1px solid #ccc;
                border-radius: 10px;
            }

            .options div.selected, .options select.selected, .options input.selected {
                font-weight: bold;
                color: blue;
            }

            .search-button {
                margin-top: 20px;
                padding: 10px 0;
                width: 100%;
                border: none;
                border-radius: 15px;
                cursor: pointer;
                background-color: #23212b;
                color: white;
                font-size: 16px;
            }

            .search-button:hover {
                background-color: #23212b;
                opacity: 0.9;
            }

            .hidden {
                display: none;
            }
        </style>

        <script>
            document.addEventListener('DOMContentLoaded', function() {//생성자or 싱글톤기능처럼 바디부분의 파라미터들을 선언해줌. 
                let optionsPeriod = document.querySelectorAll('.options-period div');//querySelectorAll로 css형식으로 파라미터를 받을수있음. 
                let optionsType = document.querySelectorAll('.options-type div');
                let optionsSorting = document.querySelectorAll('.options-sorting div');
                let optionsAdditional = document.querySelectorAll('.options-additional div');
                let yearSelect = document.getElementById('year-select');
                let monthSelect = document.getElementById('month-select');
                let additionalOptionsContainer = document.getElementById('additional-options');
                let dateInputsContainer = document.getElementById('date-inputs');
                let startDateInput = document.getElementById('start-date');
                let endDateInput = document.getElementById('end-date');
                let form = document.getElementById('search-form');
				let account_number = document.getElementById('account');
                // 초기 선택 설정
                let defaultPeriod = '1개월';
                let defaultType = '전체';
                let defaultSorting = '최신순';

                setSelectedOption(optionsPeriod, defaultPeriod); // div의 optionsPeriod의 요소중 디폴트로 1개월의 값이 선택되게 해주는것! 
                setSelectedOption(optionsType, defaultType);
                setSelectedOption(optionsSorting, defaultSorting);

                // 연도 및 월 옵션 생성
                populateYearOptions();
                yearSelect.addEventListener('change', populateMonthOptions);

                // 오늘 날짜로 설정
                setTodayDate(startDateInput);
                setTodayDate(endDateInput);

                // 클릭 이벤트 추가 - 조회 기간
                optionsPeriod.forEach(function(option) {
                    option.addEventListener('click', function() {
                        setSelectedOption(optionsPeriod, option.textContent.trim());
                        setSelectedOption(optionsAdditional, ''); // 월별, 직접입력 초기화
                        additionalOptionsContainer.classList.add('hidden');
                        dateInputsContainer.classList.add('hidden');
                    });
                });

                // 클릭 이벤트 추가 - 월별, 직접입력
                optionsAdditional.forEach(function(option) {
                    option.addEventListener('click', function() {
                        setSelectedOption(optionsAdditional, option.textContent.trim());
                        setSelectedOption(optionsPeriod, ''); // 조회 기간 초기화
                        if (option.textContent.trim() === '월별') {
                            additionalOptionsContainer.classList.remove('hidden');
                            dateInputsContainer.classList.add('hidden');
                        } else if (option.textContent.trim() === '직접입력') {
                            additionalOptionsContainer.classList.add('hidden');
                            dateInputsContainer.classList.remove('hidden');
                        }
                    });
                });

                // 클릭 이벤트 추가 - 유형
                optionsType.forEach(function(option) {
                    option.addEventListener('click', function() {
                        setSelectedOption(optionsType, option.textContent.trim());
                    });
                });

                // 클릭 이벤트 추가 - 정렬
                optionsSorting.forEach(function(option) {
                    option.addEventListener('click', function() {
                        setSelectedOption(optionsSorting, option.textContent.trim());
                    });
                });

                // 선택된 옵션을 설정하는 함수
                function setSelectedOption(options, selectedText) {
                    options.forEach(function(option) {
                        if (option.textContent.trim() === selectedText) {
                            option.classList.add('selected');
                        } else {
                            option.classList.remove('selected');
                        }
                    });
                }

                // 연도 옵션 생성 함수
                function populateYearOptions() {
                    var currentYear = new Date().getFullYear();
                    var startYear = 2015;
                    for (var year = currentYear; year >= startYear; year--) {
                        var option = document.createElement('option');
                        option.value = year;
                        option.textContent = year + '년';
                        yearSelect.appendChild(option);
                    }
                    populateMonthOptions();
                }

                // 월 옵션 생성 함수
                function populateMonthOptions() {
                    var currentYear = new Date().getFullYear();
                    var currentMonth = new Date().getMonth() + 1;
                    var selectedYear = parseInt(yearSelect.value);

                    // 기존 월 옵션 초기화
                    monthSelect.innerHTML = '';

                    // 월 옵션 추가
                    for (var month = 1; month <= 12; month++) {
                        var option = document.createElement('option');
                        option.value = month;
                        option.textContent = month + '월';

                        // 현재 연도에서는 현재 달까지만 선택 가능
                        if (selectedYear === currentYear && month > currentMonth) {
                            option.disabled = true;
                        }

                        monthSelect.appendChild(option);
                    }
                }

                // 오늘 날짜 설정 함수
                function setTodayDate(input) {
                    var today = new Date();
                    var day = String(today.getDate()).padStart(2, '0');
                    var month = String(today.getMonth() + 1).padStart(2, '0'); // 월은 0부터 시작하므로 +1
                    var year = today.getFullYear();
                    input.value = year + '-' + month + '-' + day;
                    input.max = year + '-' + month + '-' + day; // 오늘 날짜까지 선택 가능하도록 설정
                }

                // 시작 날짜 변경 시 종료 날짜의 최소 날짜 설정
                startDateInput.addEventListener('change', function() {
                    endDateInput.min = startDateInput.value;
                });

                // 종료 날짜 변경 시 시작 날짜의 최대 날짜 설정
                endDateInput.addEventListener('change', function() {
                    startDateInput.max = endDateInput.value;
                });

                // 조회 버튼 클릭 시 search 함수 호출
                document.querySelector('.search-button').addEventListener('click', function() {
                    search();
                });


                // 선택된 옵션 텍스트 가져오기 함수
                function getSelectedOptionText(options) {
                    var selectedOption = Array.from(options).find(option => option.classList.contains('selected'));
                    return selectedOption ? selectedOption.textContent.trim() : '';
                }
                function search() {
                	

                    // 선택된 옵션을 숨겨진 필드에 설정
                  	form.period.value = getSelectedOptionText(optionsPeriod);
                    form.type.value = getSelectedOptionText(optionsType);
                    form.sorting.value = getSelectedOptionText(optionsSorting);
                    form.additional.value = getSelectedOptionText(optionsAdditional); 
                    form.year.value = yearSelect.value;
                    form.month.value = monthSelect.value;
                    form.startDate.value = startDateInput.value;
                    form.endDate.value = endDateInput.value;
					form.account_number.value;
                    // 폼 전송
        
                    form.action = "detail_search.do";
                    form.method = "POST";
                    form.submit();
                }
            });
        </script>

    </head>
    <body>
        <form id="search-form">
            <div class="container">
                <div class="title">조회 기간</div>
                <div class="options options-period">
                    <div>1주일</div>
                    <div>1개월</div>
                    <div>3개월</div>
                </div>

                <div class="options options-additional">
                    <div>월별</div>
                    <div>직접입력</div>
                </div>

                <div id="additional-options" class="hidden">
                    <select id="year-select"></select>
                    <select id="month-select"></select>
                </div>

                <div id="date-inputs" class="hidden">
                    <input type="date" id="start-date">
                    <input type="date" id="end-date">
                </div>

                <div class="title">유형</div>
                <div class="options options-type">
                    <div>전체</div>
                    <div>입금</div>
                    <div>출금</div>
                </div>

                <div class="title">정렬</div>
                <div class="options options-sorting">
                    <div>최신순</div>
                    <div>과거순</div>
                </div>
				<input type="hidden" id="account" name="account_number" value="${vo.account_number}">
                <input type="hidden" id="selected-period" name="period">
                <input type="hidden" id="selected-type" name="type">
                <input type="hidden" id="selected-sorting" name="sorting">
                <input type="hidden" id="selected-additional" name="additional">
                <input type="hidden" id="selected-year" name="year">
                <input type="hidden" id="selected-month" name="month">
                <input type="hidden" id="selected-start-date" name="startDate">
                <input type="hidden" id="selected-end-date" name="endDate">
                <input type="button" class="search-button" value="조회하기" onclick="search();">
            </div>
        </form>
    </body>
</html>