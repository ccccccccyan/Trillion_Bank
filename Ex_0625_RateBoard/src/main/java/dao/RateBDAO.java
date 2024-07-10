package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.RateVO;

public class RateBDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	} //생성자가 아니라 set으로 만들어주기
	
	//전체목록 조회
	public List<RateVO> selectList(Map<String, Object> map){
		List<RateVO> list = sqlSession.selectList("r.rate_list", map);
		return list;
	}
		
	//전체 게시글의 수
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("r.rate_count", map);
		return count;
	}
		
	//상세보기를 위한 게시글 조회
	public RateVO selectOne(int r_board_idx) { //조회하고 싶은 게시글의 번호
		RateVO vo = sqlSession.selectOne("r.rate_one", r_board_idx);
		return vo;
	}
		
	//새 글 추가
	public int insert(RateVO vo) {
		int res = sqlSession.insert("r.rate_insert", vo);
		return res;
	}
		
		
	//수정하기
	public int modify(RateVO vo) {
		int res = sqlSession.update("r.rate_update", vo);
		return res;
	} //("r.rate_modify", vo) 였다. 
	
	
	//게시글 삭제
	public int delete(int r_board_idx) {
		//자식 레코드 먼저 삭제하기
		sqlSession.delete("r.rate_n_comm_del", r_board_idx);
		
		//그 뒤에 부모 레코드 삭제!
		int res = sqlSession.delete("r.rate_delete", r_board_idx);
		return res;
	}
		
	//게시글 수정
	public int update(RateVO vo) {
		int res = sqlSession.update("r.rate_update", vo);
		return res;
	}
	
	//비밀번호 암호화 및 복호화?? 과정
	
	//비밀번호 일치 확인
	public RateVO Check(int r_board_idx) {
		RateVO vo = sqlSession.selectOne("r.rate_one", r_board_idx);
		return vo;
	}

}
