package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.RateVO;

public class RateDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	// 조회
	public List<RateVO> selectList() {
		List<RateVO> list = sqlSession.selectList("rate.bank_list");
		return list;
	}
	
	public List<RateVO> selectList_ok(String rate_date) {
		List<RateVO> vo = sqlSession.selectList("rate.select_list_ok", rate_date);
		return vo;
	}
	
	// 추가 
	public int data_insert(RateVO vo) {
		int res = sqlSession.insert("rate.data_insert", vo);
		return res;
	}
	
	// 추가 (공휴일)
	public int no_insert(RateVO vo) {
		int res = sqlSession.insert("rate.no_insert", vo);
		return res;
	}
	
	public List<RateVO> select_chart(Map<String, String> day_map){
		List<RateVO> day_list = sqlSession.selectList("rate.day_list", day_map);
		return day_list;
	}
}
