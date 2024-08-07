<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>찾아오시는 길</title>
     <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }
       
        #map-container {
            width: 80%;
            margin: 40px auto;
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
        }
        #map {
            width: 80%;
            height: 600px;
            margin: auto;
            border: 1px solid #ddd;
            border-radius: 10px;
        }
        #controls {
            text-align: center;
            margin-bottom: 20px;
        }
        select {
            padding: 10px;
            margin-top: 60px;
            margin-right:30px;
            font-size: 16px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #fff;
            width: 60%;
            max-width: 300px;
        }
        option {
            font-size: 16px;
        }
    </style>
</head>
<body>
	<div id="header">
		<jsp:include page="/WEB-INF/views/bank_header.jsp"></jsp:include>
	</div>
	
    <div id="controls">
        <label for="locationSelect">지점 선택:</label>
        <select id="locationSelect">
            <option value="">지점을 선택하세요</option>
            <option value="0">일조은행 강남점</option>
            <option value="1">일조은행 역삼점</option>
            <option value="2">일조은행 배곧점</option>
            <option value="3">일조은행 인천서구점</option>
        </select>
    </div>
    <div id="map"></div>

    <script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${kakao_api_key}&libraries=services"></script>
    <script>
        var mapContainer = document.getElementById('map');
        var mapOption = {
            center: new kakao.maps.LatLng(37.49855051423377, 127.0326455149649),
            level: 2
        };

        var map = new kakao.maps.Map(mapContainer, mapOption);
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소와 설명을 배열로 저장
        var locations = [
            { address: '서울특별시 강남구 테헤란로10길 9', content: '일조은행 강남점' },
            { address: '서울특별시 강남구 역삼동 736-1', content: '일조은행 역삼점' },
            { address: '경기 시흥시 서울대학로278번길 61', content: '일조은행 배곧점' },
            { address: '인천 서구 건지로 401', content: '일조은행 인천서구점' }
        ];

        var markers = new Array(locations.length);
        var infowindows = new Array(locations.length);

        // 주소로 좌표 변환 후 마커와 정보창 생성
        locations.forEach(function(location, index) {
            geocoder.addressSearch(location.address, function(result, status) {
                if (status === kakao.maps.services.Status.OK) {
                    var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
                    var marker = new kakao.maps.Marker({
                        map: map,
                        position: coords
                    });
                    var infowindow = new kakao.maps.InfoWindow({
                        content: '<div style="width:150px;text-align:center;padding:6px 0;">' + location.content + '</div>'
                    });

                    // 인덱스를 사용하여 배열에 저장
                    markers[index] = marker;
                    infowindows[index] = infowindow;
                }
            });
        });

        // select 요소의 change 이벤트 리스너
        document.getElementById('locationSelect').addEventListener('change', function() {
            var index = parseInt(this.value); // 인덱스를 숫자로 변환
            if (!isNaN(index)) {
                var selectedMarker = markers[index];
                var selectedInfowindow = infowindows[index];

                if (selectedMarker && selectedInfowindow) {
                    map.setCenter(selectedMarker.getPosition());
                    infowindows.forEach(function(infowindow) {
                        if (infowindow) infowindow.close();
                    });
                    selectedInfowindow.open(map, selectedMarker);
                }
            }
        });
    </script>
</body>
</html>
