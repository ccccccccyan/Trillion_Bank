package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import common.Common;
import vo.AccountVO;
import vo.AccountdetailVO;
import vo.Foreign_exchangeVO;
import vo.ProductVO;
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
	
	public List<ProductVO> user_productList(String user_id){
		List<ProductVO> list = sqlSession.selectList("ac.user_productlist", user_id);
		return list;
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
	
	public List<AccountVO> bankname_List(Map<String, String> map){
		List<AccountVO> bankname_list = sqlSession.selectList("ac.bankname_list", map);
		return bankname_list;
	}
	
	// 해당 숫자를 포함하는 계좌 번호 추가
	public List<AccountVO> search_userinfo_account(String search_account_number){
		List<AccountVO> search_account_unmber = sqlSession.selectList("ac.search_userinfo_account", search_account_number);
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
	
	// 외환 계좌 -------------------
	public List<Foreign_exchangeVO> select_exchange(String user_id){
		List<Foreign_exchangeVO> exchange_list = sqlSession.selectList("ac.select_exchange_list", user_id);
		return exchange_list;
	}
	
	public int exchangeinsert(Foreign_exchangeVO vo) {
		int res = sqlSession.insert("ac.exchange_insert", vo);
		return res;
	}
	
	public Foreign_exchangeVO exchange_selectone(Foreign_exchangeVO vo) {
		Foreign_exchangeVO res_vo = sqlSession.selectOne("ac.exchange_selectone", vo);
		return res_vo;
	}
	
	public int exchange_update_sametype(Foreign_exchangeVO vo) {
		int res = sqlSession.update("ac.exchange_updateSametype", vo);
		return res;
	}
	public int exchange_del_type(Foreign_exchangeVO vo) {
		int res = sqlSession.delete("ac.exchange_del_type", vo);
		return res;
	}
}
