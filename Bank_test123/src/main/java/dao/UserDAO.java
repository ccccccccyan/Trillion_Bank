package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import vo.RateVO;
import vo.UserVO;

@Repository
public class UserDAO {
	SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 비밀번호 일치 확인
	public UserVO check(String user_id) {
		UserVO vo = sqlSession.selectOne("u.select_one", user_id);
		return vo;
	}

	// 아이디로 회원정보 찾기
	public UserVO check_id(String user_tel) {
		UserVO vo = sqlSession.selectOne("u.select_one_2", user_tel);
		return vo;
	}

	// 전화번호로 회원 정보 찾기
	public UserVO check_tel(String user_tel) {
		UserVO vo = sqlSession.selectOne("u.select_tel", user_tel);
		return vo;
	}

	// 왜 만들었는지 저도 모르겠어요
	public String check_sign(String user_id) {
		String res = sqlSession.selectOne("u.select_sign", user_id);
		return res;
	}

	// 회원가입
	public int insert(UserVO vo) {
		int cnt = sqlSession.insert("u.user_ins", vo);
		return cnt;
	}

	// 비밀번호 변경
	public int update(UserVO vo) {
		int cnt = sqlSession.insert("u.user_upd", vo);
		return cnt;
	}
	
	public int update_user_del(String user_id) {
		int res = sqlSession.update("u.user_del_update", user_id);
		return res;
	}
	
	public int update_info(UserVO vo) {
		int res = sqlSession.update("u.user_info_update", vo);
		return res;
	}

	public int update_user_active(UserVO vo) {
		int res = sqlSession.update("u.update_user_active", vo);
		return res;
	}
	
	public int user_pwd_update(UserVO vo) {
		int res = sqlSession.update("u.user_pwd_update", vo);
		return res;
	}
	
	public int user_tel_update(UserVO vo) {
		int res = sqlSession.update("u.user_tel_update", vo);
		return res;
	}
}
