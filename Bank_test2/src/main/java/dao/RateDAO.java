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
		List<RateVO> list = sqlSession.selectList("r.bank_list");
		return list;
	}
	
	public List<RateVO> selectList_ok(String rate_date) {
		List<RateVO> vo = sqlSession.selectList("r.select_list_ok", rate_date);
		return vo;
	}
	
	// 추가 
	public int data_insert(RateVO vo) {
		int res = sqlSession.insert("r.data_insert", vo);
		return res;
	}
	
	// 추가 (공휴일)
	public int no_insert(RateVO vo) {
		int res = sqlSession.insert("r.no_insert", vo);
		return res;
	}
	
	public List<RateVO> select_chart(Map<String, Object> day_map){
		List<RateVO> day_list = sqlSession.selectList("r.day_list", day_map);
		return day_list;
	}
}
