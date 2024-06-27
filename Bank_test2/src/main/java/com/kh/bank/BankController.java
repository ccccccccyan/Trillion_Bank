package com.kh.bank;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	
//	@RequestMapping("/cart_view.do")
//	@ResponseBody
//	public List<RateVO> showChart(Model model){
//		  // 현재 날짜 가져오기
//	    LocalDate first_date = LocalDate.of(2024, 5, 20); // 수정: 날짜 설정 변경
//	    LocalDate last_date = LocalDate.of(2024, 6, 20); // 수정: 날짜 설정 변경
//		// 원하는 형식의 DateTimeFormatter 생성
//		DateTimeFormatter fommat_date = DateTimeFormatter.ofPattern("yyyyMMdd");
//		// LocalDate를 문자열로 변환
//		String format_first_Date = first_date.format(fommat_date);
//		String format_last_Date = last_date.format(fommat_date);
//		
//		System.out.println(format_first_Date + " / " + format_last_Date);
//		
//		Map<String, String> day_map = new HashMap<String, String>();
//		
//		day_map.put("first_day", format_first_Date);
//		day_map.put("last_day", format_last_Date);
//		
//		List<RateVO> dataList =  rate_dao.select_chart(day_map);
//		model.addAttribute("data", dataList);
//
//		System.out.println(dataList.get(0) +" / "+ dataList.size());
//		
//		return dataList;
//	}
//	
}
