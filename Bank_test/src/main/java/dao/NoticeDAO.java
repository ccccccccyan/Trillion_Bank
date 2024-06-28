package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.NoticeVO;
import vo.RateVO;
import vo.RateboardVO;

public class NoticeDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public List<NoticeVO> selectRank_List(){
		List<NoticeVO> list = sqlSession.selectList("n.select_list_rank");
		return list;
	}
}
