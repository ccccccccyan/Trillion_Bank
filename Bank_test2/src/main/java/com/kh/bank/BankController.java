package com.kh.bank;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import common.Common;
import dao.RateDAO;
import service.BankService;
import vo.RateVO;

@Controller
public class BankController {
	RateDAO rate_dao;

	public BankController(RateDAO rate_dao) {
		this.rate_dao = rate_dao;
	}

	@RequestMapping(value = { "/", "list.do" })
	public String list(Model model) throws IOException {
		// 현재 날짜 가져오기
		LocalDate date = LocalDate.now();

		// 원하는 형식의 DateTimeFormatter 생성
		DateTimeFormatter fommat_date = DateTimeFormatter.ofPattern("yyyyMMdd");
	//야호	
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
}
