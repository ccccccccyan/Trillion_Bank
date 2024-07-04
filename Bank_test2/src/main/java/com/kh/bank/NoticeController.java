package com.kh.bank;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.NoticeDAO;
import util.Common;
import util.Paging;
import vo.NoticeVO;

@Controller
public class NoticeController {
	
	@Autowired
	ServletRequest request;
	 
	@Autowired
	HttpSession session;
	
	@Autowired
	NoticeDAO notice_dao;
	
	public void setNotice_dao(NoticeDAO notice_dao) {
		this.notice_dao = notice_dao;
	}
	
	//전체 게시글 보기
	@RequestMapping("n_list.do")
	public String list(Model model, String page, String search, String search_text) {
		int nowPage = 1; //현재 페이지 1페이지부터 시작
		if (page != null && !page.isEmpty()) { // null 체크
			nowPage = Integer.parseInt(page);
		}

		// 한 페이지에 표시되는 게시물의 시작과 끝 번호를 계산
		// ?page=10 -> 끝 번호
		int start = (nowPage - 1) * Common.Notice.BLOCKLIST + 1;
		int end = start + Common.Notice.BLOCKLIST - 1;

		// start와 end변수를 Map에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start); // "start"라는 키값에 start를 저장. (시작 번호)
		map.put("end", end); // "end"라는 키값에 end를 저장. (끝 번호)

		// 검색어 관련 파라미터
		// list.do?search=name&search_text=abc&page=2

		// 검색할 내용이 있는 경우
		if (search != null && !search.equals("all")) {

			if (search.equals("name_subject_content")) {
				map.put("name", search_text);
				map.put("subject", search_text);
				map.put("content", search_text);

			} else if (search.equals("name")) {
				map.put("name", search_text);

			} else if (search.equals("subject")) {
				map.put("subject", search_text);

			} else if (search.equals("content")) {
				map.put("content", search_text);
			} // inner if

		} // if

		// 전체 목록 가져오기
		List<NoticeVO> list = notice_dao.selectList(map);

		// 전체 게시글 수 가져오기
		int row_total = notice_dao.getRowTotal(map); // 얘한테도 맵 주기

		// 이걸 페이징.자바에게 보냄.
		// 페이지 메뉴 생성
		String search_param = String.format("search=%s&search_text=%s", search, search_text);

		String pageMenu = Paging.getPaging("list.do", nowPage, row_total, search_param, Common.Notice.BLOCKLIST,
				Common.Notice.BLOCKPAGE);

		// list객체 바인딩 및 포워딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu); // 리스트 보내는 김에 페이지 메뉴도 같이 보냄.

		return Common.Notice.VIEW_PATH + "notice_list.jsp";
	}
	
	//공지사항 게시글 상세보기
	@RequestMapping("/n_view.do")
	public String view(Model model, int r_notice_idx) {
		//view.do?r_notice_idx=21 <- 21번 글을 상세보기
		
		//상세보기를 위한 게시글 조회
		NoticeVO vo = notice_dao.selectOne(r_notice_idx);
		
		model.addAttribute("vo", vo);
		return Common.Notice.VIEW_PATH + "notice_view.jsp";
	}
	
	//새 글 작성 폼
	@RequestMapping("/notice_write.do")
	public String insert_form() {
		return Common.Notice.VIEW_PATH + "notice_write.jsp";
	}
	
	//새 글 등록
	@RequestMapping("/n_insert.do")
	public String insert(NoticeVO vo) {
		notice_dao.insert(vo);
		return "redirect:list.do";
	}
	
	//수정
	@RequestMapping("/n_board_modify.do")
	public String board_modify(int r_notice_idx, Model model) {
		NoticeVO vo = notice_dao.selectOne(r_notice_idx);
		model.addAttribute("vo", vo);
		
		return Common.Notice.VIEW_PATH + "notice_modify.jsp";
	}
	
	//수정 제출
	@RequestMapping("/n_modify_fin.do")
	public String modify_fin(NoticeVO vo) {
		notice_dao.update(vo);
		return "redirect:list.do";
	}
	
	//글 삭제
	@RequestMapping("/n_del.do")
	public String del(int r_notice_idx) {
		notice_dao.del_update(r_notice_idx);
		return "redirect:list.do";
	}
	
	
	
	
}
