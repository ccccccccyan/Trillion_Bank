	
	
	// Swiper 라이브러리가 로드된 후에 실행되어야 하는 코드
	document.addEventListener("DOMContentLoaded", function() {
		var swiper = new Swiper(".mySwiper", {
		    slidesPerView: 3,
	        centeredSlides: false, // 중앙 정렬 해제
		    spaceBetween: 30,
	        pagination: {
	            el: ".swiper-pagination",
	            type: "fraction",
	        },
	        navigation: {
	            nextEl: ".swiper-button-next",
	            prevEl: ".swiper-button-prev",
	        },
		});

		var swiper_product = new Swiper(".mySwiper_product", {
		    slidesPerView: 3,
	        centeredSlides: false, // 중앙 정렬 해제
		    spaceBetween: 30,
	        pagination: {
	            el: ".swiper-pagination",
	            type: "fraction",
	        },
	        navigation: {
	            nextEl: ".swiper-button-next",
	            prevEl: ".swiper-button-prev",
	        },
		});
	})