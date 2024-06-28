package com.kh.bank;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
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
		
		System.out.println(format_first_Date + " / " + format_last_Date);
		
		String[] CUR_UNIT = {"CHF", "CNH", "DKK", "EUR", "GBP", "HKD",
							"IDR(100)", "JPY(100)", "KRW", "KWD", "MYR",
							"NOK", "NZD", "SAR", "SEK", "SGD", "THB", "USD"};
		
		List<Map<String, Object>> day_map_list = new ArrayList<Map<String,Object>>();
		for(int i = 0; i < CUR_UNIT.length; i++) {
			Map<String, Object> day_map_data = new HashMap<String, Object>();
			Map<String, Object> day_map = new HashMap<String, Object>();
			day_map.put("first_day", format_first_Date);
			day_map.put("last_day", format_last_Date);
			day_map.put("CUR_UNIT", CUR_UNIT[i]);

			List<RateVO> dataList =  rate_dao.select_chart(day_map);
			double max_data_ttb = Double.parseDouble(dataList.get(0).getTtb().replace(",", ""));
			double min_data_ttb = Double.parseDouble(dataList.get(0).getTts().replace(",", ""));

			double max_data_tts = Double.parseDouble(dataList.get(0).getTts().replace(",", ""));
			double min_data_tts = Double.parseDouble(dataList.get(0).getTtb().replace(",", ""));
				for(RateVO data : dataList) {
					Double data_ttb = Double.parseDouble(data.getTtb().replace(",", ""));
					Double data_tts = Double.parseDouble(data.getTts().replace(",", ""));
					if(max_data_ttb < data_ttb) {
						max_data_ttb = data_ttb;
					}
					
					if(min_data_ttb > data_ttb ) {
						min_data_ttb = data_ttb;
					}
	
					if(max_data_tts < data_tts) {
						max_data_tts = data_tts;
					}
					
					if(min_data_tts > data_tts ) {
						min_data_tts = data_tts;
					}
				}

			day_map_data.put("cur_unit", CUR_UNIT[i]);
			day_map_data.put("max_data_ttb", max_data_ttb);
			day_map_data.put("min_data_ttb", min_data_ttb);
			day_map_data.put("max_data_tts", max_data_tts);
			day_map_data.put("min_data_tts", min_data_tts);
			day_map_data.put("rateVO_data", dataList);
			day_map_list.add(day_map_data);
			System.out.println(day_map_list.get(i).get("cur_unit"));
			System.out.println(day_map_list.get(i).size());
		}
		
		return day_map_list;
	}
	
}
