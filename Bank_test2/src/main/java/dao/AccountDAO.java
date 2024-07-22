package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.AccountVO;
import vo.RateVO;

public class AccountDAO {
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	// 조회
	public List<AccountVO> selectList(String user_id) {
		List<AccountVO> list = sqlSession.selectList("ac.account_list", user_id);
		return list;
	}
	
	// 추가 
	public int data_insert(AccountVO vo) {
		int res = sqlSession.insert("ac.account_insert", vo);
		return res;
	}

}
