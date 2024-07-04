package dao;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;

import vo.NoticeVO;

public class NoticeDAO {
	
	SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	} //생성자가 아니라 set으로 만들어주기
	
	//전체목록 조회
	public List<NoticeVO> selectList(Map<String, Object> map){
		List<NoticeVO> list = sqlSession.selectList("n.notice_list", map);
		return list;
	}
	
	//전체 게시글의 수
	public int getRowTotal(Map<String, Object> map) {
		int count = sqlSession.selectOne("n.notice_count", map);
		return count;
	}
	
	//상세보기를 위한 게시글 조회
	public NoticeVO selectOne(int r_notice_idx) { //조회하고 싶은 게시글의 번호
		NoticeVO vo = sqlSession.selectOne("n.notice_one", r_notice_idx);
		return vo;
	}
	
	//새 글 추가
	public int insert(NoticeVO vo) {
		int res = sqlSession.insert("n.notice_insert", vo);
		return res;
	}
	
	
	//수정하기
	public int modify(NoticeVO vo) {
		int res = sqlSession.update("n.notice_modify", vo);
		return res;
	}
	
	
	//게시글 삭제
	public int del_update(int r_notice_idx) {
		int res = sqlSession.update("n.notice_del_upd", r_notice_idx);
		return res;
	}
	
	//게시글 수정
	public int update(NoticeVO vo) {
		int res = sqlSession.update("n.notice_update", vo);
		return res;
	}
	
	public List<NoticeVO> selectRank_List(){
		List<NoticeVO> list = sqlSession.selectList("n.select_list_rank");
		return list;
	}
	
	
}
