package com.kh.bank;

import java.net.http.HttpRequest;
import java.util.List;

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
import vo.AccountVO;
import vo.AccountdetailVO;
import vo.NoticeVO;
import vo.QnaboardVO;
import vo.RateboardVO;
import vo.RateboardcommVO;
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
	RateBDAO rateB_dao;
	QnaDAO qna_dao;
	NoticeDAO notice_dao;
	
	public AccountController( AccountDAO account_dao, CommentDAO comment_dao, RateBDAO rateB_dao, QnaDAO qna_dao, NoticeDAO notice_dao) {
		this.account_dao = account_dao;
		this.comment_dao = comment_dao;
		this.rateB_dao = rateB_dao;
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
			user_id = null;
			return Common.Account.VIEW_PATH_AC + "account.jsp"; 
		}

		// 파라미터로 받아지는 user_id가 있으면서 DB에 해당 user_id가 있을 경우
		if(user_id != null) {
			// 해당 user_id의 계정 정보를 조회 
			UserVO vo_ok = user_dao.check(user_id);
			// session에 저장하고 그 사용자의 계좌 리스트를 조회한다.
			session.setAttribute("user_id", user_id);
			List<AccountVO> account_list = account_dao.selectList(user_id);
			model.addAttribute("account_list", account_list);
	
			// session에 저장된 user_id가 있을 경우
		} else if(session_user_id != null) {
			// 저장된 user_id의 계좌 리스트를 조회한다.
			List<AccountVO> account_list = account_dao.selectList(session_user_id);
			model.addAttribute("account_list", account_list);
		}
		
		// 환율 게시판 리스트 조회 (최근 10개)
		List<RateboardVO> board_list = rateB_dao.selectRank_List();
		
		// 환율 게시판 별 댓글 수 조회 (댓글 수 카운트)
		for(RateboardVO vo : board_list) {
			vo.setComm_cnt(comment_dao.selectRow(vo.getR_board_idx())); // 환율 게시판 vo에 댓글수 확인하는 변수 생성했어요 
		}
		model.addAttribute("board_list", board_list);
		
		//공지 게시판 리스트 조회 (최근 10개)
		List<NoticeVO> notice_list = notice_dao.selectRank_List();
		model.addAttribute("notice_list", notice_list);
		
		//공지 게시판 리스트 조회 (최근 10개)
		List<QnaboardVO> qna_list = qna_dao.selectRank_List();
		model.addAttribute("qna_list", qna_list);
		
		return Common.Account.VIEW_PATH_AC + "account.jsp"; 
	}
	
	
	// 메인 페이지에서 로그아웃 -----------------------------------------
	@RequestMapping("/logout.do")
	public String logout() {
		// session에 담긴 user_id 데이터 제거
		session.removeAttribute("user_id");
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
	//송금을 위한 비밀번호 확인
	@RequestMapping(value="/remittance_pwd_chk.do", produces = "application/json;charset=UTF-8")
	@ResponseBody
	public String account_pwd_chk( AccountVO vo, String target_account_number, int deal_money ){
		
		boolean isValid = Common.SecurePwd.decodePwd(vo, account_dao);
		AccountVO account = account_dao.accountnum_selectOne(target_account_number);
		if(account != null) {
		 
		UserVO targetusername = account_dao.user_selectOne(account_dao.accountnum_selectOne(target_account_number).getUser_id());
		String target_user_name = targetusername.getUser_name();
		if(isValid) {
		//비밀번호가 일치하므로, 수정 form으로 이동
			String resIdx = 
			String.format("[{'result':'clear', 'account_number':'%s', 'target_account_number':'%s', 'target_user_name':'%s', 'deal_money':'%d'}]", vo.getAccount_number(), target_account_number, target_user_name, deal_money);
			System.out.println(resIdx);
			return resIdx;
			}else {
				//비밀번호 불일치
				return "[{'result':'no'}]";
			}
		}else {
			return "[{'result':'no_account'}]";
		}
	}
	
	@Transactional
	@RequestMapping("/remittance.do")
	public String remittance(String account_number, String target_account_number, int deal_money){
		//user_id 접속한 사람의 id / account_number 내가 송금한 계좌번호 / deal_money 송금할 금액
		
		
		System.out.println(account_number+"/"+target_account_number);	
		AccountVO user = account_dao.accountnum_selectOne(account_number); // userid의 계좌상세정보를 조회
		AccountVO target = account_dao.accountnum_selectOne(target_account_number);//내가 송금할 계좌번호의 계좌 상세정보를 조회
		
		if(deal_money > 100000) {
			System.out.println("아오 서영시치");
			throw new RuntimeException("아오 서영시치");
		}
		
		
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
		
		return "redirect:account_info.do?account_number="+user.getAccount_number();
	}
	@RequestMapping("delete_form.do")
	public String delete_form(Model model, String account_number) {
		AccountVO vo = account_dao.accountnum_selectOne(account_number);
		model.addAttribute("vo", vo);
		return Common.Account.VIEW_PATH_AC + "delete_form.jsp";
	}

	@RequestMapping("del_accountpwd_chk.do")
	@ResponseBody
	public String accountpwd_chk(AccountVO vo) {
		boolean isValid = Common.SecurePwd.decodePwd(vo, account_dao);	
		if(isValid) {
		//비밀번호가 일치하므로, 삭제 form으로 이동
			String resIdx = 
			String.format("[{'result':'clear', 'account_number':'%s'}]", vo.getAccount_number());
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
}
