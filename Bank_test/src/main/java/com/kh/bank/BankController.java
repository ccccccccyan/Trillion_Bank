package com.kh.bank;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

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
import vo.RateVO;
import vo.UserVO;

@Controller
public class BankController {

	@Autowired
	ServletContext app;

	@Autowired
	HttpServletRequest request;
	
	@Autowired
	UserDAO user_dao;	
	
	RateDAO rate_dao;

	public BankController(RateDAO rate_dao) {
		this.rate_dao = rate_dao;
	}

	@RequestMapping("/list.do")
	public String list(Model model) throws IOException {
		// 현재 날짜 가져오기
		LocalDate date = LocalDate.now();
		// 원하는 형식의 DateTimeFormatter 생성
		DateTimeFormatter fommat_date = DateTimeFormatter.ofPattern("yyyyMMdd");
		// LocalDate를 문자열로 변환
		String formattedDate = date.format(fommat_date);

		List<RateVO> list_ok = rate_dao.selectList_ok(formattedDate);
			
			if(list_ok.size() == 0) { // DB에 데이터 없을 경우
				BankService bank = new BankService();
				List<RateVO> list = bank.bank_serv(formattedDate); // api로 vo 리스트를 받아온다.
			
				if(list.get(0).getCur_nm() == null || list.get(0).getCur_nm() == "") {
					int res = rate_dao.no_insert(list.get(0));
				}else {
					for (int j = 0; j < list.size(); j++) {
						int res = rate_dao.data_insert(list.get(j));
					}
				}
			}
		List<RateVO> selectlist = rate_dao.selectList();

		model.addAttribute("list", selectlist);
		return Common.Bank.VIEW_PATH + "bank_list.jsp"; 
	}
	
	@RequestMapping("/cart_view.do")
	@ResponseBody
	public List<Map<String, Object>> showChart(Model model){
		  // 현재 날짜 가져오기
	    LocalDate first_date = LocalDate.of(2024, 5, 20); // 수정: 날짜 설정 변경
	    LocalDate last_date = LocalDate.of(2024, 6, 20); // 수정: 날짜 설정 변경
		// 원하는 형식의 DateTimeFormatter 생성
		DateTimeFormatter fommat_date = DateTimeFormatter.ofPattern("yyyyMMdd");
		// LocalDate를 문자열로 변환
		String format_first_Date = first_date.format(fommat_date);
		String format_last_Date = last_date.format(fommat_date);
		
		String[] CUR_UNIT = {"CHF", "CNH", "DKK", "EUR", "GBP", "HKD",
							"IDR(100)", "JPY(100)", "KWD", "MYR",
							"NOK", "NZD", "SAR", "SEK", "SGD", "THB", "USD"};
		
		List<Map<String, Object>> day_map_list = new ArrayList<Map<String,Object>>();
		for(int i = 0; i < CUR_UNIT.length; i++) {
			Map<String, Object> day_map_data = new HashMap<String, Object>();
			Map<String, Object> day_map = new HashMap<String, Object>();
			day_map.put("first_day", format_first_Date);
			day_map.put("last_day", format_last_Date);
			day_map.put("CUR_UNIT", CUR_UNIT[i]);

			List<RateVO> dataList =  rate_dao.select_chart(day_map);
			double max_data = Double.parseDouble(dataList.get(0).getTtb().replace(",", ""));
			double min_data = Double.parseDouble(dataList.get(0).getTtb().replace(",", ""));

				for(RateVO data : dataList) {
					Double data_ttb = Double.parseDouble(data.getTtb().replace(",", ""));
					Double data_tts = Double.parseDouble(data.getTts().replace(",", ""));
					if(max_data < data_ttb) {
						max_data = data_ttb;
					}
					
					if(max_data < data_tts) {
						max_data = data_tts;
					}
					
					if(min_data > data_ttb ) {
						min_data = data_ttb;
					}
	
					
					if(min_data > data_tts ) {
						min_data = data_tts;
					}
				}

			day_map_data.put("cur_unit", CUR_UNIT[i]);
			day_map_data.put("max_data", max_data);
			day_map_data.put("min_data", min_data);

			day_map_data.put("rateVO_data", dataList);
			day_map_list.add(day_map_data);
		}
		
		return day_map_list;
	}
	
	
	// 메인 화면 -----------------------------------
		@RequestMapping("/home.do" )
		public String Home() {
			return Common.Bank.VIEW_PATH + "home.jsp";
		}
		
		// 로그인 창
		@RequestMapping("/login.do")
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
		public String login_check(UserVO vo) {
			boolean isValid = Common.Secure_userPwd.decodePwd(vo, user_dao);
			
			if (isValid) {
				String res = String.format("[{'result':'clear', 'User_id':'%s'}]", vo.getUser_id());
				return res;
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

			if (vo.getUser_id().contains("admin")) {
				vo.setManager("Y");
			} else {
				vo.setManager("N");
			}
//			if (vo.getUser_id().toLowerCase().contains("admin")) {
//				vo.setManager("Y");
//			} else {
//				vo.setManager("N");
//			}

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
		
		//아이디 찾기
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

		@RequestMapping("/user_infocheck.do") // 수정중
		@ResponseBody
		public String user_info_check(UserVO vo, Model model) {
			
			boolean decode_pwd_check = Common.Secure_userPwd.decodePwd(vo, user_dao);	
			if(decode_pwd_check) {
				return "[{'result':'clear']";
			}else {
				return "[{'result':'no'}]";
			}
		}
		
	}

	
