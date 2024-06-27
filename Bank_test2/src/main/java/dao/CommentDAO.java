package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.RateVO;
import vo.RateboardcommVO;

public class CommentDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public int selectRow(int r_board_idx) {
		int res = sqlSession.selectOne("c.select_Row", r_board_idx);
		return res;
	}
}
