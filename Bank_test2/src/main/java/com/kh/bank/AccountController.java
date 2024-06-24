package com.kh.bank;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.AccountDAO;
import vo.AccountVO;
@Controller
public class AccountController {

	AccountDAO account_dao;

	public AccountController( AccountDAO account_dao) {
		this.account_dao = account_dao;
	}
	
	@RequestMapping(value={"/", "/account_list.do"})
	public String account(Model model) {
		
//		String user_id = "abc123";
		String user_id = "aaa111";
		model.addAttribute("user_id", user_id);
		
		List<AccountVO> account_list = account_dao.selectList(user_id);
		System.out.println(account_list.size() + "sdasd");
		model.addAttribute("account_list", account_list);
		
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
		int res = account_dao.data_insert(vo);
		if(res > 0) {
			System.out.println("추가 성공");
		}
		return "redirect:account_list.do";
	}
	
}
