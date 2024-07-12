package com.kh.bank;

import java.net.http.HttpRequest;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import common.Common;
import dao.AccountDAO;
import dao.CommentDAO;
import dao.NoticeDAO;
import dao.QnaDAO;
import dao.RateBDAO;
import dao.UserDAO;
import service.SmsService;
import vo.AccountVO;
import vo.AccountdetailVO;
import vo.NoticeVO;
import vo.QnaVO;
import vo.RateboardVO;
import vo.UserVO;
@Controller
public class AccountController {

	@Autowired
	HttpServletRequest request;
	
	@Autowired
	HttpSession session;
	
	@Autowired
	UserDAO user_dao;	
	
	AccountDAO account_dao;
	CommentDAO comment_dao;
	RateBDAO rateb_dao;
	QnaDAO qna_dao;
	NoticeDAO notice_dao;
	
	public AccountController( AccountDAO account_dao, CommentDAO comment_dao, RateBDAO rateb_dao, QnaDAO qna_dao, NoticeDAO notice_dao) {
		this.account_dao = account_dao;
		this.comment_dao = comment_dao;
		this.rateb_dao = rateb_dao;
		this.qna_dao = qna_dao;
		this.notice_dao = notice_dao;
	}
	
	
	// 메인 페이지 조회-------------------------------------------------------
	@RequestMapping(value = { "/", "/account_list.do"})
	public String account(Model model) {
		// 이전 페이지에서 파라미터로 보내는 user_id가 있을 경우 받는다.
		String user_id = request.getParameter("user_id");
		// session에 user_id 데이터 저장 여부 확인
		String session_user_id = (String) session.getAttribute("user_id");
		
		// session에 user_id 데이터가 이미 있으면서, 다른 user_id가 파라미터로 보내지고 있는 경우
		if(user_id != null && session_user_id != null && !(user_id.equals(session_user_id))) {
			// 잘못된 정보 여부 모델에 저장
			String miss_info = "잘못된 접근입니다.";
			model.addAttribute("miss_info", miss_info);
			// 문제 원인 데이터들 모두 지우고 메인 페이지로 이동 
			session.removeAttribute("user_id");
			session.removeAttribute("manager");
			user_id = null;
			return Common.Account.VIEW_PATH_AC + "account.jsp";  
		}

		// 파라미터로 받아지는 user_id가 있으면서 DB에 해당 user_id가 있을 경우
		if(user_id != null) {
			// 해당 user_id의 계정 정보를 조회 
			UserVO vo_ok = user_dao.check(user_id);
			// session에 저장하고 그 사용자의 계좌 리스트를 조회한다.
			session.setAttribute("user_id", user_id);
			
			// 해당 사용자가 관리자일 경우 추가 정보를 세션에 저장
			if(vo_ok.getManager().equals("Y")) {
				session.setAttribute("manager", vo_ok.getManager());
			}
			
			List<AccountVO> account_list = account_dao.selectList(user_id);
			model.addAttribute("account_list", account_list);
	
			// session에 저장된 user_id가 있을 경우
		} else if(session_user_id != null) {
			// 저장된 user_id의 계좌 리스트를 조회한다.
			List<AccountVO> account_list = account_dao.selectList(session_user_id);
			model.addAttribute("account_list", account_list);
		}
		
		// 환율 게시판 리스트 조회 (최근 10개)
		List<RateboardVO> board_list = rateb_dao.selectRank_List();
		
		// 환율 게시판 별 댓글 수 조회 (댓글 수 카운트)
		for(RateboardVO vo : board_list) {
			vo.setComm_cnt(comment_dao.selectRow(vo.getR_board_idx())); // 환율 게시판 vo에 댓글수 확인하는 변수 생성했어요 
		}
		model.addAttribute("board_list", board_list);
		
		//공지 게시판 리스트 조회 (최근 10개)
		List<NoticeVO> notice_list = notice_dao.selectRank_List();
		model.addAttribute("notice_list", notice_list);
		
		//공지 게시판 리스트 조회 (최근 10개)
		List<QnaVO> qna_list = qna_dao.selectRank_List();
		model.addAttribute("qna_list", qna_list);
		
		
//		SmsService sms = new SmsService();
//		sms.push_smsService("010-3265-2508", "010-7157-4841");
		
		return Common.Account.VIEW_PATH_AC + "account.jsp"; 
//		return Common.Account.VIEW_PATH_AC + "openpage.jsp"; 
	}
	
	
	// 메인 페이지에서 로그아웃 -----------------------------------------
	@RequestMapping("/logout.do")
	public String logout() {
		// session에 담긴 user_id 데이터 제거
		session.removeAttribute("user_id");
		session.removeAttribute("manager");
		return "redirect:account_list.do";
	}
	
	// 회원 탈퇴-------------------------------------------------------
	@RequestMapping("/user_remove.do")
	@ResponseBody
	public String user_remove(String user_id) {
		// 사용자명 unknown으로 변경
		int res = user_dao.update_user_del(user_id);
		
		if(res > 0 ) {
			//회원 탈퇴 완료 시 session에 저장된 user_id 정보 제거
			session.removeAttribute("user_id");
			session.removeAttribute("manager");
			return "[{'result':'clear'}]";
		}
		return "[{'result':'fail'}]";
	}
	
	// 회원 활성화 -----------------------------
	@RequestMapping("/user_name_open.do")
	@ResponseBody
	public String user_name_open(UserVO vo) {
		// 사용자명 unknown으로 변경
		int res = user_dao.update_user_active(vo);
		
		if(res > 0 ) {
			return "[{'result':'clear'}]";
		}
		return "[{'result':'fail'}]";
	}
	
	// 계좌 추가 폼 --------------------------------------------------
	@RequestMapping("/account_insert_form.do")
	public String account_insert_form(Model model) {
		return Common.Account.VIEW_PATH_AC + "account_insert_form.jsp"; 
	}
	
	// 계좌 추가 -------------------------------------------------------
	@RequestMapping("/account_insert.do")
	public String account_insert(AccountVO vo) {
		// session에 있는 user_id 값을 받아 vo로 셋팅
		String session_user_id = (String) session.getAttribute("user_id");
		vo.setUser_id(session_user_id);
		
		// 입력받은 비밀번호 암호화
		String encodePwd = Common.SecurePwd.encodePwd(vo.getAccount_pwd());
		vo.setAccount_pwd(encodePwd);
		int res = account_dao.data_insert(vo);
		if(res > 0) {
			System.out.println("추가 성공");
		}
		return "redirect:account_list.do"; // 다시 메인 페이지로 이동
	}
	
	// 계좌 번호 중복 체크 ----------------------------------------------
	@RequestMapping("/account_number_check.do")
	@ResponseBody
	public String account_number_check(String account_number) {
		// 해당 계좌가 이미 DB에 있는지 확인한다.
		AccountVO vo = account_dao.check(account_number); 
		
		if(vo != null) {
			return "[{'result':'fail'}]";
		}
		return "[{'result':'clear'}]";
	}
	
	
	@RequestMapping("/account_info.do")
	public String account_info(Model model, String account_number) { 
		 
		//account_number의 계좌 상세정보를 조회
		AccountVO vo = account_dao.accountnum_selectOne(account_number);
		//조회한 계좌 모든 거래내역을 조회하고 거래내역을 List<AccountdetailVO> detail_vo로 받아줌 
		List<AccountdetailVO> detail_vo = account_dao.detailaccount_list(vo);
		
		model.addAttribute("list", detail_vo);
		model.addAttribute("vo", vo);
		return Common.Account.VIEW_PATH_AC + "account_info.jsp";		
	}
	
	@RequestMapping("/remittance_form.do")
	public String remittance_form(Model model, String account_number) {
		AccountVO vo = account_dao.accountnum_selectOne(account_number);		
		model.addAttribute("vo", vo);
		return Common.Account.VIEW_PATH_AC + "remittance_form.jsp";
	}
	
	@RequestMapping(value = "/checkaccount.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String checkaccount(AccountVO vo, String target_account_number, Integer deal_money) {
		 // 계좌 번호 유효성 검사
		AccountVO targetaccount = account_dao.accountnum_selectOne(target_account_number);
	    if(targetaccount == null){
			return "[{'result':'no_account'}]";
		}else {
			UserVO targetusername = account_dao.user_selectOne(targetaccount.getUser_id());
			String target_user_name = targetusername.getUser_name();
			String target_bank_name = targetaccount.getBank_name();
			String resIdx = String.format(
		            "[{'result':'clear', 'account_number':'%s', 'target_account_number':'%s', 'target_user_name':'%s', 'deal_money':'%d', 'target_bank_name':'%s'}]",
		            vo.getAccount_number(), target_account_number, target_user_name, deal_money, target_bank_name);
		        return resIdx;
		}
		
	}
	
	@Transactional
	@RequestMapping(value = "/remittance_pwd_chk.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String account_pwd_chk(AccountVO vo, String account_number, String target_account_number, int deal_money) {

	    // 비밀번호 유효성 검사
	    boolean isValid = Common.SecurePwd.decodePwd(vo, account_dao);
	    AccountVO myaccount = account_dao.accountnum_selectOne(vo.getAccount_number());
	    int myaccount_lockcnt = myaccount.getAccount_lockcnt();
	    
	    if (isValid) {
	    	AccountVO user = account_dao.accountnum_selectOne(account_number); // userid의 계좌상세정보를 조회
			AccountVO target = account_dao.accountnum_selectOne(target_account_number);//내가 송금할 계좌번호의 계좌 상세정보를 조회
			
			int usermoney = user.getNow_money() - deal_money; //user의 계좌에서 빠져나간만큼의 금액을 빼줌
			int targetmoney = target.getNow_money() + deal_money;//상대 계좌의 송금받은 만큼의 금액을 더함
			
			//계산한 금액을 계좌 상세보기 VO에 넣어줌 
			user.setNow_money(usermoney);
			target.setNow_money(targetmoney);
			//그 금액을 각각 유저계좌와 상대계좌 db에 업데이트로 갱신함
			account_dao.updateremittance(user);
			account_dao.updateremittance(target);
			
			
			// 접속한 사람의 계좌주의 이름과 상대 계좌주의 이름을 얻기위해 uservo로 조회함  
			UserVO myusername = account_dao.user_selectOne(user.getUser_id());
			UserVO targetusername = account_dao.user_selectOne(target.getUser_id()); 
			
			//거래내역 정보를 detail_vo에 담음
			AccountdetailVO detail_vo = new AccountdetailVO();
			detail_vo.setAccount_number(user.getAccount_number());
			detail_vo.setUser_name(myusername.getUser_name());//조회한 유저 이름을 저장
			detail_vo.setDepo_username(targetusername.getUser_name());//조회한 상대 계좌주의 이름을 저장
			detail_vo.setDepo_account(target.getAccount_number());
			detail_vo.setDeal_money(deal_money);
			System.out.println(myusername.getUser_name()+"/"+targetusername.getUser_name());
			//거래내역을 담은 vo를 insert해줌
			account_dao.insertremittance(detail_vo);
	   
	    	// 비밀번호가 일치하므로, 수정 form으로 이동
	        myaccount.setAccount_lockcnt(0);
	        account_dao.lockcnt_update(myaccount);

	        String resIdx = String.format(
	            "[{'result':'yes', 'account_number':'%s', 'myaccount_lockcnt':'%d', 'target_user_name':'%s', 'deal_money':'%d', 'target_bank_name':'%s', 'target_account_number':'%s', 'now_money':'%d'}]",
	            vo.getAccount_number(), myaccount_lockcnt, targetusername.getUser_name(), deal_money, target.getBank_name(), target.getAccount_number(), user.getNow_money());
	        return resIdx;
	    } else {
	        // 비밀번호 불일치
	        myaccount.setAccount_lockcnt(myaccount.getAccount_lockcnt() + 1);

	        if (myaccount.getAccount_lockcnt() <= 5) {
	            account_dao.lockcnt_update(myaccount);
	        }
	        
	        String res = String.format("[{'result':'no', 'account_lockcnt':'%d'}]", myaccount.getAccount_lockcnt());
	        return res;
	    }
	}
	
	
	@RequestMapping("delete_form.do")
	public String delete_form(Model model, String account_number) {
		AccountVO vo = account_dao.accountnum_selectOne(account_number);
		model.addAttribute("vo", vo);
		return Common.Account.VIEW_PATH_AC + "delete_form.jsp";
	}

	@RequestMapping(value="/del_accountpwd_chk.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String accountpwd_chk(AccountVO vo) {
		boolean isValid = Common.SecurePwd.decodePwd(vo, account_dao);
		AccountVO one = account_dao.accountnum_selectOne(vo.getAccount_number());
		int now_money = one.getNow_money();
		String bank_name = one.getBank_name();
		if(isValid) {
		//비밀번호가 일치하므로, 삭제 form으로 이동
			String resIdx = 
				String.format("[{'result':'clear', 'account_number':'%s', 'now_money':'%d', 'bank_name':'%s'}]", vo.getAccount_number(), now_money, bank_name);
				return resIdx;
		}else {
		//비밀번호 불일치
				return "[{'result':'no'}]";
		}
	}
	
	@RequestMapping("account_delete.do")
	public String account_delete(String account_number) {
		account_dao.account_delete(account_number);
		return "redirect:account_list.do";
	}
	
	@RequestMapping("accountdetail_Searchform.do")
	public String accountdetail_Searchform(Model model, String account_number) {
		AccountVO vo = account_dao.accountnum_selectOne(account_number);
		model.addAttribute("vo", vo);
		return Common.Account.VIEW_PATH_AC + "detail_searchform.jsp";
	}
	@RequestMapping("detail_search.do")
	public String detail_search(Model model, String account_number, String period, String type, String sorting, String additional, String year, String month, String startDate, String endDate) {
	    Map<String, Object> map = new HashMap<String, Object>();

	    if (sorting.equals("최신순")) {
	        String order = "bank_date desc";
	        map.put("order", order);
	    } else if (sorting.equals("과거순")) {
	        String order = "bank_date";
	        map.put("order", order);
	    }

	    LocalDate nowdate = LocalDate.now();
	    nowdate = nowdate.plusDays(1);
	    map.put("account_number", account_number);

	    if (period != null && !period.equals("")) {
	        map.put("end", nowdate);
	        if (period.equals("1주일")) {
	            LocalDate weekago = nowdate.minusDays(7);
	            map.put("begin", weekago);
	        } else if (period.equals("1개월")) {
	            LocalDate monthago = nowdate.minusMonths(1);
	            map.put("begin", monthago);
	        } else if (period.equals("3개월")) {
	            LocalDate monthago3 = nowdate.minusMonths(3);
	            map.put("begin", monthago3);
	        }
	    }
	    
	    if ("월별".equals(additional)) {
	        map.put("begin", LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), 1));
	        map.put("end", LocalDate.of(Integer.parseInt(year), Integer.parseInt(month), 1).plusMonths(1).minusDays(1));
	    } else if ("직접입력".equals(additional)) {
	        map.put("begin", LocalDate.parse(startDate));
	        map.put("end", LocalDate.parse(endDate).plusDays(1));
	    }
	   
	    List<AccountdetailVO> list = account_dao.search_detailaccountlist(map);
	    model.addAttribute("type", type);
	    AccountVO vo = account_dao.accountnum_selectOne(account_number);
	    model.addAttribute("vo", vo);
	    model.addAttribute("list", list);

	    return Common.Account.VIEW_PATH_AC + "search_account_list.jsp";
	}

	
	// 계좌 번호로 사용자 정보 조회
	@RequestMapping("/search_userinfo_account.do")
	@ResponseBody
	public Map<String, Object> search_userinfo_account(String search_account_number) {
		Map<String, Object> search_result_vo = new HashMap<String, Object>();
		List<UserVO> search_user_vo = new ArrayList<UserVO>();
		
		// 계좌 정보 조회
		List<AccountVO> search_account_vo = account_dao.search_userinfo_account(search_account_number);
	
		if(search_account_vo.size() == 0){
			search_result_vo.put("search_result", "no"); // 데이터 여부
			return search_result_vo;
		}
		
		search_result_vo.put("search_result", "yes");
		search_result_vo.put("account_result", search_account_vo);
		
		for(AccountVO account_vo : search_account_vo) {
			search_user_vo.add(user_dao.check_id(account_vo.getUser_id()));
		}
		search_result_vo.put("userinfo_result", search_user_vo);
		
		return search_result_vo;
	}
	
	// 선택한 계좌 번호로 최종 사용자 정보 조회
	@RequestMapping("/change_searchinfo_account.do")
	@ResponseBody
	public Map<String, Object> change_searchinfo_account(String account_number) {
		Map<String, Object> search_result_vo = new HashMap<String, Object>();
		
		// 계좌 정보 조회
		AccountVO search_account_vo = account_dao.check(account_number);
		
		if(search_account_vo == null){
			search_result_vo.put("search_result", "no"); // 데이터 여부
			return search_result_vo;
		}
		
		// 검색 결과 저장
		search_result_vo.put("search_result", "yes");
		// 계좌 정보 저장
		search_result_vo.put("account_result", search_account_vo);
		
		// 사용자 정보 저장
		UserVO search_user_vo = user_dao.check_id(search_account_vo.getUser_id());

		search_result_vo.put("userinfo_result", search_user_vo);
		
		return search_result_vo;
	}
	
	@RequestMapping("organization_chart.do")
	public String organization_chart() {
		return Common.Header.VIEW_PATH_HD + "organization_chart.jsp";
	}

	@RequestMapping("ceo_greeting.do")
	public String ceo_greeting() {
		return Common.Header.VIEW_PATH_HD + "ceo_greeting.jsp";
	}

	@RequestMapping("guide.do")
	public String guide() {
		return Common.Header.VIEW_PATH_HD + "guide.jsp";
	}

	@RequestMapping("ideal_talent.do")
	public String ideal_talent() {
		return Common.Header.VIEW_PATH_HD + "ideal_talent.jsp";
	}

	@RequestMapping("pr_center.do")
	public String pr_center() {
		return Common.Header.VIEW_PATH_HD + "pr_center.jsp";
	}

	@RequestMapping("rate_inquiry.do")
	public String rate_inquiry() {
		return Common.Header.VIEW_PATH_HD + "rate_inquiry.jsp";
	}

	@RequestMapping("recruitment_information.do")
	public String recruitment_information() {
		return Common.Header.VIEW_PATH_HD + "recruitment_information.jsp";
	}

	@RequestMapping("schedule_all.do")
	public String schedule_all() {
		return Common.Header.VIEW_PATH_HD + "schedule_all.jsp";
	}

	@RequestMapping("schedule_ksy.do")
	public String schedule_ksy() {
		return Common.Header.VIEW_PATH_HD + "schedule_ksy.jsp";
	}

	@RequestMapping("schedule_kjh.do")
	public String schedule_kjh() {
		return Common.Header.VIEW_PATH_HD + "schedule_kjh.jsp";
	}

	@RequestMapping("schedule_ojh.do")
	public String schedule_ojh() {
		return Common.Header.VIEW_PATH_HD + "schedule_ojh.jsp";
	}

	@RequestMapping("schedule_mkj.do")
	public String schedule_mkj() {
		return Common.Header.VIEW_PATH_HD + "schedule_mkj.jsp";
	}

	@RequestMapping("vision.do")
	public String vision() {
		return Common.Header.VIEW_PATH_HD + "vision.jsp";
	}
	@RequestMapping("product.do")
	public String product() {
		return Common.Account.VIEW_PATH_AC + "product.jsp";
	}
	
	@RequestMapping("/account_pwd_update.do")
	@ResponseBody
	public String account_pwd_update(AccountVO vo) {
		vo.setAccount_pwd(Common.SecurePwd.encodePwd(vo.getAccount_pwd()));
		int res = account_dao.account_pwd_update(vo);
		
		if (res > 0) {
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}
	
	@RequestMapping("/account_color_update.do")
	@ResponseBody
	public String account_color_update(AccountVO vo) {
		int res = account_dao.account_color_update(vo);
		
		if (res > 0) {
			return "[{'result':'clear'}]";
		} else {
			return "[{'result':'fail'}]";
		}
	}
	
	@RequestMapping("chart_ojh.do")
	public String chart_ojh() {
		return Common.Header.VIEW_PATH_HD + "schedule_ojh.jsp";
	}
	@RequestMapping("chart_ksy.do")
	public String chart_ksy() {
		return Common.Header.VIEW_PATH_HD + "schedule_ksy.jsp";
	}
	@RequestMapping("chart_mkj.do")
	public String chart_mkj() {
		return Common.Header.VIEW_PATH_HD + "schedule_mkj.jsp";
	}
	@RequestMapping("chart_kjh.do")
	public String chart_kjh() {
		return Common.Header.VIEW_PATH_HD + "schedule_kjh.jsp";
	}
	@RequestMapping("chart_all.do")
	public String chart_all() {
		return Common.Header.VIEW_PATH_HD + "schedule_all.jsp";
	}
}
