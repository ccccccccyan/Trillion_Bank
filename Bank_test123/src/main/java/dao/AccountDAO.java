package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import common.Common;
import vo.AccountVO;
import vo.AccountdetailVO;
import vo.RateVO;
import vo.UserVO;

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
	
	public AccountVO check(String account_number) {
		AccountVO vo = sqlSession.selectOne("ac.account_selectOne", account_number);
		return vo;
	}
	public AccountVO accountnum_selectOne(String account_number) {
		AccountVO vo = sqlSession.selectOne("ac.account_info", account_number);
		return vo;
	}
	public int lockcnt_update(AccountVO vo) {
		int res = sqlSession.update("ac.account_lock_update", vo);
		return res;	
	}
	
	public UserVO user_selectOne(String user_id) {
		UserVO vo = sqlSession.selectOne("ac.user_info", user_id);
		return vo;
	}
	public int insertremittance(AccountdetailVO vo) {
		int res = sqlSession.insert("ac.detail_insert", vo);
		return res;
	}

	public int updateremittance(AccountVO vo) {
		int res = sqlSession.update("ac.user_money", vo);
		return res;
	}
	
	public List<AccountdetailVO> detailaccount_list(AccountVO vo){
		List<AccountdetailVO> account_list = sqlSession.selectList("ac.accountdetail_list", vo);
		return account_list;
	}
	public int account_delete(String account_number) {
		int res = sqlSession.delete("ac.account_delete", account_number);
		return res;
	}
	
	public List<AccountdetailVO> search_detailaccountlist(Map<String, Object> map){
		List<AccountdetailVO> searchaccount_list = sqlSession.selectList("ac.searchdetailaccount_list", map);
		return searchaccount_list;
	}
	
	// 해당 숫자를 포함하는 계좌 번호 추가
	public List<AccountVO> search_userinfo_account(String search_account_number){
		List<AccountVO> search_account_unmber = sqlSession.selectList("search_userinfo_account", search_account_number);
		return search_account_unmber;
	}
	
	public int account_pwd_update(AccountVO vo) {
		int res = sqlSession.update("ac.account_pwd_update", vo);
		return res;
	}
	public int account_color_update(AccountVO vo) {
		int res = sqlSession.update("ac.account_color_update", vo);
		return res;
	}
}