package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.NoticeVO;
import vo.QnaboardVO;
import vo.RateVO;

public class QnaDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<QnaboardVO> selectRank_List(){
		List<QnaboardVO> list = sqlSession.selectList("q.select_list_rank");
		return list;
	}

}
