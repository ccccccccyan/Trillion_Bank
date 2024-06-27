package com.kh.bank;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.AccountDAO;
import dao.CommentDAO;
import dao.NoticeDAO;
import dao.QnaDAO;
import dao.RateBDAO;
import vo.AccountVO;
import vo.NoticeVO;
import vo.QnaboardVO;
import vo.RateboardVO;
import vo.RateboardcommVO;
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
		
//		String user_id = "abc123";
		String user_id = "aaa111";
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
		System.out.println(vo.getAccount_number() +" / "+vo.getBank_name() + " / " + vo.getUser_id());
		String encodePwd = Common.SecurePwd.encodePwd(vo.getAccount_pwd());
		vo.setAccount_pwd(encodePwd);
		int res = account_dao.data_insert(vo);
		if(res > 0) {
			System.out.println("추가 성공");
		}
		return "redirect:account_list.do";
	}
	
}
