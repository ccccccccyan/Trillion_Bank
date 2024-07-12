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
	} //생성자가 아니라 set으로 만들어주기
	
	//전체목록 조회
	public List<RateboardVO> selectList(Map<String, Object> map){
		List<RateboardVO> list = sqlSession.selectList("rb.rate_list", map);
		return list;
	}
		
	//전체 게시글의 수
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("rb.rate_count", map);
		return count;
	}
		
	//상세보기를 위한 게시글 조회
	public RateboardVO selectOne(int r_board_idx) { //조회하고 싶은 게시글의 번호
		RateboardVO vo = sqlSession.selectOne("rb.rate_one", r_board_idx);
		return vo;
	}
		
	//새 글 추가
	public int insert(RateboardVO vo) {
		int res = sqlSession.insert("rb.rate_insert", vo);
		return res;
	}
		
		
	//수정하기
	public int modify(RateboardVO vo) {
		int res = sqlSession.update("rb.rate_update", vo);
		return res;
	} //("r.rate_modify", vo) 였다. 
	
	
	//게시글 삭제
	public int delete(int r_board_idx) {
		//자식 레코드 먼저 삭제하기
		sqlSession.delete("rb.rate_n_comm_del", r_board_idx);
		
		int res = sqlSession.delete("rb.rate_del_upd", r_board_idx);
		return res;
	}
		
	//게시글 수정
	public int update(RateboardVO vo) {
		int res = sqlSession.update("rb.rate_update", vo);
		return res;
	}
	
	//비밀번호 일치 확인
	public RateboardVO Check(int r_board_idx) {
		RateboardVO vo = sqlSession.selectOne("rb.rate_one", r_board_idx);
		return vo;
	}
	
	//환율 게시판 최신순 10개 조회
	public List<RateboardVO> selectRank_List(){
		List<RateboardVO> list = sqlSession.selectList("rb.select_list_rank");
		return list;
	}
	
}
