package service;

import java.io.BufferedReader;

import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.kh.bank.BankController;

import vo.RateVO;

public class BankService {

	public List<RateVO> bank_serv(String formattedDate, String bank_api_key) throws IOException{
		//open api 주소
		String urlStr = "https://www.koreaexim.go.kr/site/program/financial/exchangeJSON?authkey="+bank_api_key+"&searchdate="+formattedDate+"&data=AP01";
		
		//api 링크
		URL url = new URL(urlStr);
		
		// 실제로 접근하는 변수 connection
		HttpURLConnection connection = (HttpURLConnection)url.openConnection();
		
		// 연결 시간 늘림
		connection.setConnectTimeout(10000); // 10초
		connection.setReadTimeout(10000); // 10초
		connection.setInstanceFollowRedirects(false); // 리디렉션 비활성화 ++
		
		BufferedReader br = null;
		
		try {
			// connection을 통해 요청한 검색 결과를 읽어오자
			br = new BufferedReader(new InputStreamReader(connection.getInputStream()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		
		String line = "";
		String resultJson = "";
		

		while((line = br.readLine()) != null) {
			resultJson += line;
		}
		
		// 데이터 없을 때 바로 반환
		//resultJson == null || resultJson.isEmpty() || resultJson.equals("[]")
		if(resultJson == null || resultJson.equals("[]") || resultJson.isEmpty()) {
			List<RateVO> no_vo = new ArrayList<RateVO>(); // 받을 리스트
			
			RateVO vo = new RateVO();
			
			vo.setRate_date(formattedDate);
			no_vo.add(vo);
			
			return no_vo;
		}
		
		br.close();
		connection.disconnect();
		
		//가져온 Json 형식의 문자열을 실제 Json으로 변경

		//JSON 배열 구조를 가져오는 객체 (처음은 배열 구조로 되어 있다)
		JSONArray json_arr = null;
		
		// 각 배열 구조를 Object(json 구조)로 변환해야 값을 불러올 수 있다.
		JSONObject json_obj_in = null;
		
		List<RateVO> bank_vo = new ArrayList<RateVO>(); // 받을 리스트
		
		try {
			JSONParser jsonParser = new JSONParser();
			json_arr = (JSONArray)jsonParser.parse(resultJson);

			//담은 결과 정보를 각 vo 위치에 set 후 해당 vo를 리스트에 담는다.
			for(int i = 0; i < json_arr.size(); i++) {
				RateVO vo = new RateVO();
				json_obj_in = (JSONObject) json_arr.get(i);
				
				vo.setTtb((String) json_obj_in.get("ttb"));
				vo.setTts((String) json_obj_in.get("tts"));
				vo.setCur_nm((String) json_obj_in.get("cur_nm"));
				vo.setCur_unit((String) json_obj_in.get("cur_unit"));
				vo.setRate_date(formattedDate);
				bank_vo.add(vo);
			}
			 
		} catch (Exception e) {
			e.printStackTrace();
		}
		return bank_vo; // 최종적으로 담은 vo 리스트를 반환
	}
}
