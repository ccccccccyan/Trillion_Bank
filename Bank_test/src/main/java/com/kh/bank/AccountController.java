package com.kh.bank;

import java.util.List;

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
import vo.AccountVO;
import vo.AccountdetailVO;
import vo.NoticeVO;
import vo.QnaboardVO;
import vo.RateboardVO;
import vo.RateboardcommVO;
import vo.UserVO;
@Controller
public class AccountController {

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
	
	@RequestMapping(value={"/", "/account_list.do"})
	public String account(Model model) {
		
		String user_id = "abc123";
		model.addAttribute("user_id", user_id);
		
		List<AccountVO> account_list = account_dao.selectList(user_id);
		System.out.println(account_list.size() + "sdasd");
		model.addAttribute("account_list", account_list);
		
		
		List<RateboardVO> board_list = rateB_dao.selectRank_List();
		
		for(RateboardVO vo : board_list) {
			vo.setComm_cnt(comment_dao.selectRow(vo.getR_board_idx()));
		}

		model.addAttribute("board_list", board_list);
		
		List<NoticeVO> notice_list = notice_dao.selectRank_List();
		model.addAttribute("notice_list", notice_list);
		
		List<QnaboardVO> qna_list = qna_dao.selectRank_List();
		model.addAttribute("qna_list", qna_list);
		
		
		/*
		 * return Common.Account.VIEW_PATH_AC + "account.jsp";
		 */		
		return Common.Account.VIEW_PATH_AC + "account.jsp"; 
	}
	
	@RequestMapping("/account_insert_form.do")
	public String account_insert_form(Model model, String user_id) {
		model.addAttribute("user_id", user_id);
		return Common.Account.VIEW_PATH_AC + "account_insert_form.jsp"; 
	}
	
	@RequestMapping("/account_insert.do")
	public String account_insert(AccountVO vo, String user_id) {
		vo.setUser_id(user_id);
		vo.setNow_money(0);
		System.out.println(vo.getAccount_number() +" / "+vo.getBank_name() + " / " + vo.getUser_id() + " / " + vo.getAccount_color());
		String encodePwd = Common.SecurePwd.encodePwd(vo.getAccount_pwd());
		vo.setAccount_pwd(encodePwd);
		int res = account_dao.data_insert(vo);
		if(res > 0) {
			System.out.println("추가 성공");
		}
		return "redirect:account_list.do";
	}
	
	@RequestMapping("/account_number_check.do")
	@ResponseBody
	public String account_number_check(String account_number) {
		System.out.println(account_number);
		AccountVO vo = account_dao.check(account_number);
		
		if(vo != null) {
			System.out.println("실패");
			System.out.println(vo.getAccount_number());
			return "[{'result':'fail'}]";
		}
			System.out.println("성공");
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
