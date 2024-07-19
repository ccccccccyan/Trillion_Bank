package com.kh.bank;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.RateDAO;
import dao.UserDAO;
import service.BankService;
import service.SmsService;
import vo.RateVO;
import vo.UserVO;

@Controller
public class BankController {

	@Autowired
	HttpSession session;
	
	
	@Autowired
	ServletContext app;

	@Autowired
	HttpServletRequest request;

	@Autowired
	RateDAO rate_dao;

	@Autowired
	UserDAO user_dao;

	public BankController() {
		// TODO Auto-generated constructor stub
	}

	public BankController(RateDAO rate_dao) {
		this.rate_dao = rate_dao;
	}

	@RequestMapping(value="/list.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public List<Map<String, Object>> list(Model model) throws IOException {
		List<Map<String, Object>> rate_data = new ArrayList<Map<String,Object>>();
		
	
		// 금일 데이터 있는지 확인 후 추가 ----------------------------
		LocalDate date = LocalDate.now();
//		LocalDate date = LocalDate.of(2024, 7, 15);
		DateTimeFormatter fommat_date = DateTimeFormatter.ofPattern("yyyyMMdd");
		String formattedDate = date.format(fommat_date);
		List<RateVO> list_ok = rate_dao.selectList_ok(formattedDate);
		
		
		System.out.println("list_ok.size() : " + list_ok.size());
		if (list_ok.size() == 0) {
			BankService bank = new BankService();
			List<RateVO> list = bank.bank_serv(formattedDate);
			
			if (list.get(0).getCur_nm() == null || list.get(0).getCur_nm().isEmpty()) {
				int res = rate_dao.no_insert(list.get(0));
			} else {
				for (int j = 0; j < list.size(); j++) {
					int res = rate_dao.data_insert(list.get(j));
				}
			}
		}
		
		String period = request.getParameter("period");
		String cur_nm_select = request.getParameter("cur_nm_select");
		
		LocalDate first_date = null; // 수정: 날짜 설정 변경;
		LocalDate last_date = LocalDate.now();
		
		
		if(period == null || period == "" || period.equals("1개월")) {
			// 현재 날짜 가져오기
			first_date = last_date.minusMonths(1); // 수정: 날짜 설정 변경
		}else if(period.equals("3개월")){
			first_date = last_date.minusMonths(3); // 수정: 날짜 설정 변경
		}else if(period.equals("6개월")){
			first_date = last_date.minusMonths(6); // 수정: 날짜 설정 변경
		}else if(period.equals("1년")){
			first_date = last_date.minusYears(1); // 수정: 날짜 설정 변경
		}
		
		String format_first_Date = first_date.format(fommat_date);
		String format_last_Date = last_date.format(fommat_date);
		
		// 조회할 나라 배열
		String[] cur_nm_box = { "인도네시아 루피아", "일본 옌", "쿠웨이트 디나르", "말레이지아 링기트", "노르웨이 크로네", "뉴질랜드 달러", "사우디 리얄", "스웨덴 크로나", "싱가포르 달러",
				"태국 바트", "미국 달러", "아랍에미리트 디르함", "호주 달러", "바레인 디나르", "브루나이 달러", "캐나다 달러", "스위스 프랑", "위안화", "덴마아크 크로네", "유로", "영국 파운드", "홍콩 달러" };
		List<String> cur_nm = new ArrayList<String>();
		if(cur_nm_select == null || cur_nm_select == "" || cur_nm_select.equals("all") ) {
			for(String str : cur_nm_box) {
				cur_nm.add(str);
			}
		}else {
			cur_nm.add(cur_nm_select);
		}
		Map<String, Object> db_data = new HashMap<String, Object>();
		db_data.put("first_day", format_first_Date);
		db_data.put("last_day", format_last_Date);
		
		for(int i = 0; i < cur_nm.size(); i++) {
			Map<String, Object> rate_list_data = new HashMap<String, Object>();
			
			db_data.put("cur_nm", cur_nm.get(i));
			
			// first_day에서 last_day 사이의 cur_nm 데이터를 조회
			List<RateVO> rate_list_cur = rate_dao.select_chart(db_data);
			
			// 최대 최소 구하기
			double max_data = Double.parseDouble(rate_list_cur.get(0).getTtb().replace(",", ""));
			double min_data = Double.parseDouble(rate_list_cur.get(0).getTtb().replace(",", ""));

			for (RateVO data : rate_list_cur) { // , 있으면 계산 안돼서 제거해주고 형변환했어요
				Double data_ttb = Double.parseDouble(data.getTtb().replace(",", ""));
				Double data_tts = Double.parseDouble(data.getTts().replace(",", ""));
				if (max_data < data_ttb) {
					max_data = data_ttb;
				}

				if (max_data < data_tts) {
					max_data = data_tts;
				}

				if (min_data > data_ttb) {
					min_data = data_ttb;
				}

				if (min_data > data_tts) {
					min_data = data_tts;
				}
			}
			
			// cur_nm과 max, min 값 담기
			rate_list_data.put("cur_nm", cur_nm.get(i));
			rate_list_data.put("max_data", max_data);
			rate_list_data.put("min_data", min_data);
			// 조회된 rateVO 객체 리스트 담기
			rate_list_data.put("rateVO_data", rate_list_cur);
			
			rate_data.add(rate_list_data);
		}
		
		return rate_data;
	}

	// 메인 화면
	@RequestMapping("/home.do")
	public String Home() {
		return Common.Bank.VIEW_PATH + "home.jsp";
	}

	// 로그인 창
	@RequestMapping("/login.do" )
	public String login() {
		return Common.Bank.VIEW_PATH + "login.jsp";
	}

	// 회원가입 창
	@RequestMapping(value = "/signup.do", produces = "application/json;charset=UTF-8")
	public String signup() {
		return Common.Bank.VIEW_PATH + "signup.jsp";
	}

	// 아이디 비밀번호 체크
	@RequestMapping("/login_check.do")
	@ResponseBody
	public String login_check(UserVO vo, Model model) {

		UserVO X_User = user_dao.check(vo.getUser_id());
		boolean isValid = Common.Secure_userPwd.decodePwd(vo, user_dao);
		if (isValid) {
			if ("unknown".equals(X_User.getUser_name())) {
				return "[{'result':'freeze'}]";
			} else {
				String res = String.format("[{'result':'clear', 'User_id':'%s'}]", vo.getUser_id());
				return res;
			}
		} else {
			return "[{'result':'no'}]";
		}
	}

	// 회원가입 정보 삽입 1
	@RequestMapping(value = "/signup_ins.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String signup_ins(UserVO vo) {
		// 중복된 user_id 확인
		UserVO existingUser = user_dao.check(vo.getUser_id());
		if (existingUser != null) {
			return "[{'result':'duplicate'}]";
		}
		vo.setManager("N");
		String encode_pwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
		vo.setUser_pwd(encode_pwd);

		try {
			String res = String.format(
					"[{'result':'clear', 'User_id':'%s','User_name':'%s','User_pwd':'%s' ,'User_tel':'%s','User_addr':'%s','Manager':'%s'}]",
					vo.getUser_id(), vo.getUser_name(), vo.getUser_pwd(), vo.getUser_tel(), vo.getUser_addr(),
					vo.getManager());
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			return "[{'result':'error'}]";
		}
	}

	@RequestMapping(value = "/signup_ins_admin.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String signup_ins_admin(UserVO vo) {
		// 중복된 user_id 확인
		UserVO existingUser = user_dao.check(vo.getUser_id());
		if (existingUser != null) {
			return "[{'result':'duplicate'}]";
		}
		vo.setManager("Y");
		String encode_pwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
		vo.setUser_pwd(encode_pwd);

		try {
			String res = String.format(
					"[{'result':'clear', 'User_id':'%s','User_name':'%s','User_pwd':'%s' ,'User_tel':'%s','User_addr':'%s','Manager':'%s'}]",
					vo.getUser_id(), vo.getUser_name(), vo.getUser_pwd(), vo.getUser_tel(), vo.getUser_addr(),
					vo.getManager());
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			return "[{'result':'error'}]";
		}
	}

	// 회원가입 아이디 중복체크
	@RequestMapping(value = "/signup_ins_id.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String signup_ins_id(UserVO vo) {
		UserVO existingUser = user_dao.check_id(vo.getUser_id());
		if (existingUser != null) {
			return "[{'result':'duplicate'}]";
		}
		try {
			String res = String.format("[{'result':'clear', 'User_id':'%s'}]", vo.getUser_id());
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			return "[{'result':'error'}]";
		}
	}

	// 회원가입 전화번호 중복체크
	@RequestMapping(value = "/signup_ins_tel.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String signup_ins_tel(UserVO vo) {
		// 중복된 user_id 확인
		UserVO existingUser = user_dao.check_tel(vo.getUser_tel());
		if (existingUser != null) {
			return "[{'result':'duplicate'}]";
		}

		try {
			String res = String.format("[{'result':'clear', 'User_tel':'%s'}]", vo.getUser_tel());
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			return "[{'result':'error'}]";
		}
	}

	// 회원가입 정보 삽입 2
	@RequestMapping("/signup_final.do")
	public String signup_final(UserVO vo, Model model) {
		// 중복된 user_id 확인
		UserVO existingUser = user_dao.check(vo.getUser_id());
		if (existingUser != null) {
			model.addAttribute("error", "중복된 사용자 ID가 존재합니다.");
			return Common.Bank.VIEW_PATH + "signup.jsp";
		}

		// 비밀번호 암호화
		/*
		 * String encode_pwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
		 * vo.setUser_pwd(encode_pwd);
		 */

		// 사용자 데이터베이스에 삽입
		user_dao.insert(vo);

		return "redirect:/login.do";
	}

	// 관리자 정보 삽입 2
	@RequestMapping("/signup_final_admin.do")
	public String signup_final_admin(UserVO vo, Model model) {
		// 중복된 user_id 확인
		UserVO existingUser = user_dao.check(vo.getUser_id());
		if (existingUser != null) {
			model.addAttribute("error", "중복된 사용자 ID가 존재합니다.");
			return Common.Bank.VIEW_PATH + "signup.jsp";
		}

		// 비밀번호 암호화
		/*
		 * String encode_pwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
		 * vo.setUser_pwd(encode_pwd);
		 */

		// 사용자 데이터베이스에 삽입
		user_dao.insert(vo);

		return "redirect:/login.do";
	}

	// 아이디 찾기
	@RequestMapping("/search_id.do")
	public String search_id() {
		return Common.Bank.VIEW_PATH + "search_id.jsp";
	}

	// 비밀번호 찾기
	@RequestMapping("/search_pwd.do")
	public String search_pwd() {
		return Common.Bank.VIEW_PATH + "search_pwd.jsp";
	}

	// 아이디 찾기 2
	@RequestMapping(value = "/search_id2.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String search_id2(UserVO vo) {
		System.out.println(vo.getUser_tel() + " tel");
		
		// 중복된 user_id 확인
		UserVO existingUser = user_dao.check_tel(vo.getUser_tel());
		if (existingUser == null) {
			return "[{'result':'duplicate'}]";
		}
		

		try {
			String res = String.format("[{'result':'clear', 'User_id':'%s'}]", existingUser.getUser_id());
			return res;
		} catch (Exception e) {
			e.printStackTrace();
			return "[{'result':'error'}]";
		}
	}

	// 비밀번호 찾기 2
	@RequestMapping(value = "/search_pwd2.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String search_pwd2(UserVO vo) {
		UserVO existingUser = user_dao.check_id(vo.getUser_id());
		if (existingUser != null) {
			try {
				String res = String.format("[{'result':'clear', 'user_id':'%s', 'user_pwd':'%s'}]",
						existingUser.getUser_id(), existingUser.getUser_pwd());
				return res;
			} catch (Exception e) {
				e.printStackTrace();
				return "[{'result':'error'}]";
			}
		}
		return "[{'result':'duplicate'}]";
	}

	// 비밀번호 찾기 후 비밀번호 변경
	@RequestMapping("/change_pwd.do")
	public String change_pwd(@RequestParam("user_id") String user_id, Model model) {
		System.out.println(user_id);
		model.addAttribute("user_id", user_id);
		return Common.Bank.VIEW_PATH + "change_pwd.jsp";
	}

	// 비밀번호 찾기 후 변경 최종
	@RequestMapping("/change_pwd_final.do")
	public String change_pwd_final(UserVO vo) {
		String encode_pwd = Common.SecurePwd.encodePwd(vo.getUser_pwd());
		vo.setUser_pwd(encode_pwd);
		System.out.println(encode_pwd);
		user_dao.update(vo);
		return "redirect:/login.do";
	}

	@RequestMapping("/chart_view.do")
	@ResponseBody
	public List<Map<String, Object>> showChart(Model model) {
		// 현재 날짜 가져오기
		LocalDate first_date = LocalDate.of(2024, 5, 20); // 수정: 날짜 설정 변경
		LocalDate last_date = LocalDate.of(2024, 6, 20); // 수정: 날짜 설정 변경
		// 원하는 형식의 DateTimeFormatter 생성
		DateTimeFormatter fommat_date = DateTimeFormatter.ofPattern("yyyyMMdd");
		// LocalDate를 문자열로 변환
		String format_first_Date = first_date.format(fommat_date);
		String format_last_Date = last_date.format(fommat_date);

		// 조회할 나라 배열
		String[] cur_nm = { "CHF", "CNH", "DKK", "EUR", "GBP", "HKD", "IDR(100)", "JPY(100)", "KWD", "MYR", "NOK",
				"NZD", "SAR", "SEK", "SGD", "THB", "USD" };

		// 반환할 리스트 생성
		List<Map<String, Object>> day_map_list = new ArrayList<Map<String, Object>>();

		for (int i = 0; i < cur_nm.length; i++) {
			// 리스트에 조회한 데이터를 담을 map 변수
			Map<String, Object> day_map_data = new HashMap<String, Object>();
			// 나라별 데이터를 조회할 map 변수
			Map<String, Object> day_map = new HashMap<String, Object>();
			day_map.put("first_day", format_first_Date);
			day_map.put("last_day", format_last_Date);
			day_map.put("cur_nm", cur_nm[i]);
			// first_day에서 last_day 사이의 cur_nm 데이터를 조회
			List<RateVO> dataList = rate_dao.select_chart(day_map);

			// 최대 최소 구하기
			double max_data = Double.parseDouble(dataList.get(0).getTtb().replace(",", ""));
			double min_data = Double.parseDouble(dataList.get(0).getTtb().replace(",", ""));

			for (RateVO data : dataList) { // , 있으면 계산 안돼서 제거해주고 형변환했어요
				Double data_ttb = Double.parseDouble(data.getTtb().replace(",", ""));
				Double data_tts = Double.parseDouble(data.getTts().replace(",", ""));
				if (max_data < data_ttb) {
					max_data = data_ttb;
				}

				if (max_data < data_tts) {
					max_data = data_tts;
				}

				if (min_data > data_ttb) {
					min_data = data_ttb;
				}

				if (min_data > data_tts) {
					min_data = data_tts;
				}
			}

			// cur_nm과 max, min 값 담기
			day_map_data.put("cur_nm", cur_nm[i]);
			day_map_data.put("max_data", max_data);
			day_map_data.put("min_data", min_data);
			// 조회된 rateVO 객체 리스트 담기
			day_map_data.put("rateVO_data", dataList);
			day_map_list.add(day_map_data);
		}
		return day_map_list; // 최종적으로 리스트 반환
	}

	@RequestMapping("/user_infocheck.do")
	@ResponseBody
	public String user_info_check(UserVO vo, Model model) {

		boolean decode_pwd_check = Common.Secure_userPwd.decodePwd(vo, user_dao);
		System.out.println("비밀번호 일치 결과 :" + decode_pwd_check);

		if (decode_pwd_check) {
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'no'}]";
		}
	}

	@RequestMapping("/user_info_modify_form.do") // 수정중
	public String user_info_modify_form(Model model) {
		String session_user_id = (String) session.getAttribute("user_id");

		UserVO vo = user_dao.check(session_user_id);

		model.addAttribute("vo", vo);

		return Common.Bank.VIEW_PATH + "user_info_modify_form.jsp";
	}

	@RequestMapping("/modify_ins_tel.do")
	@ResponseBody
	public String user_tel_check_modify(UserVO vo) {
		UserVO db_vo = user_dao.check_tel(vo.getUser_tel());

		if (db_vo == null) {
			return "[{'result':'clear'}]";
		} else if (vo.getUser_id().equals(db_vo.getUser_id()) && !(db_vo == null)) {
			System.out.println(vo.getUser_id() + " 1 " + db_vo.getUser_id());
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}

	@RequestMapping("modify_ins_user.do")
	@ResponseBody
	public String modify_ins_user(UserVO vo) {
		UserVO db_user = user_dao.check_id(vo.getUser_id());
		
		int res;
		
		if(vo.getUser_pwd().equals(db_user.getUser_pwd())) {
			res = user_dao.update_info(vo);
			
		}else {
			vo.setUser_pwd(Common.SecurePwd.encodePwd(vo.getUser_pwd()));
			res = user_dao.update_info(vo);
		}

		if (res > 0) {
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}

	@RequestMapping("/user_id_update.do")
	@ResponseBody
	public String user_id_update( UserVO vo ) {
		int res = user_dao.update_user_active(vo);
		
		if (res > 0) {
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}
	
	@RequestMapping("/user_pwd_update.do")
	@ResponseBody
	public String user_pwd_update( UserVO vo ) {
		vo.setUser_pwd(Common.SecurePwd.encodePwd(vo.getUser_pwd()));
		int res = user_dao.user_pwd_update(vo);
		
		if (res > 0) {
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}
	
	@RequestMapping("/user_tel_update.do")
	@ResponseBody
	public String user_tel_update( UserVO vo ) {
		int res = user_dao.user_tel_update(vo);
		
		if (res > 0) {
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}

	@RequestMapping("/user_self_check.do")
	@ResponseBody
	public String user_self_check( String user_tel ) {
		System.out.println("user_tel : " + user_tel);
		
        // 100000 이상 999999 이하의 6자리 숫자 생성
        int sixNumber = new Random().nextInt(900000) + 100000;
        System.out.println("인증 번호: " + sixNumber);
        
	//	SmsService sms = new SmsService("01032652508", user_tel, sixNumber); // 이거 넣으면 인증 완료
		
		return "[{'result':'clear', 'sixNumber': "+sixNumber+"}]";
	}
	
	
	@RequestMapping("/user_tel_check.do")
	@ResponseBody
	public String user_tel_check( String user_tel, String search_user_id ) {
		
		System.out.println("user_tel : " + user_tel);
		System.out.println("search_user_id : " + search_user_id);
		UserVO vo = user_dao.check(search_user_id);
		
		if (vo.getUser_tel().equals(user_tel)) {
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}
}
