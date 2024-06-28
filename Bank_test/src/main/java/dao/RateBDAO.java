package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.RateVO;
import vo.RateboardVO;

public class RateBDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<RateboardVO> selectRank_List(){
		List<RateboardVO> list = sqlSession.selectList("r.select_list_rank");
		return list;
	}
	
}
