package com.kh.qnab;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import dao.QnaDAO;
import vo.QnaVO;
import util.Common;
import util.Paging;

@Controller
public class QnaController {

	@Autowired
	HttpServletRequest request;

	@Autowired
	HttpSession session;

	@Autowired
	QnaDAO qna_dao;

	public QnaController(QnaDAO qna_dao) {
		this.qna_dao = qna_dao;
	}

	@RequestMapping(value = { "/", "/list.do" })
	public String list(Model model, String page, String search, String search_text) {
		// list.do?page=2
		int nowPage = 1; // 현재 페이지는 1부터 시작함.
		if (page != null && !page.isEmpty()) { // null 체크
			nowPage = Integer.parseInt(page);
		}

		// 한 페이지에 표시되는 게시물의 시작과 끝 번호를 계산
		// ?page=2
		int start = (nowPage - 1) * Common.Qna.BLOCKLIST + 1;
		int end = start + Common.Qna.BLOCKLIST - 1;

		// start와 end변수를 Map에 저장
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start); // "start"라는 키값에 start를 저장. (시작 번호)
		map.put("end", end); // "end"라는 키값에 end를 저장. (끝 번호)

		// 검색어 관련 파라미터
		// list.do?search=user_id&search_text=abc&page=2

		// 검색할 내용이 있는 경우
		if (search != null && !search.equals("all")) {

			if (search.equals("user_id_subject_content")) {
				map.put("user_id", search_text);
				map.put("subject", search_text);
				map.put("content", search_text);

			} else if (search.equals("user_id")) {
				map.put("user_id", search_text);

			} else if (search.equals("subject")) {
				map.put("subject", search_text);

			} else if (search.equals("content")) {
				map.put("content", search_text);
			} // inner if

		} // if

		// 전체 목록 가져오기
		List<QnaVO> list = qna_dao.selectList(map);

		// 전체 게시글 수 가져오기
		int row_total = qna_dao.getRowTotal(map); // 얘한테도 맵 주기

		// 이걸 페이징.자바에게 보냄.
		// 페이지 메뉴 생성
		String search_param = String.format("search=%s&search_text=%s", search, search_text);

		String pageMenu = Paging.getPaging("list.do", nowPage, row_total, search_param, Common.Qna.BLOCKLIST,
				Common.Qna.BLOCKPAGE);

		// list객체 바인딩 및 포워딩
		model.addAttribute("list", list);
		model.addAttribute("pageMenu", pageMenu); // 리스트 보내는 김에 페이지 메뉴도 같이 보냄.

		// 조회수 증가를 위해서 기록되어있던 show 정보를 삭제
		session.removeAttribute("show");

		return Common.Qna.VIEW_PATH + "qna_list.jsp";
	}

	// 공지사항 게시글 상세보기
	@RequestMapping("/view.do")
	public String view(Model model, int q_board_idx) {
		// view.do?q_notice_idx=21 <- 21번 글을 상세보기

		// 상세보기를 위한 게시글 조회
		QnaVO vo = qna_dao.selectOne(q_board_idx);

		model.addAttribute("vo", vo);
		return Common.Qna.VIEW_PATH + "qna_view.jsp";
	}

	// 새 글 작성 폼
	@RequestMapping("/qna_write.do")
	public String insert_form() {
		return Common.Qna.VIEW_PATH + "qna_write.jsp";
	}

	// 새 글 등록
	@RequestMapping("/insert.do")
	public String insert(QnaVO vo) {
		qna_dao.insert(vo);
		return "redirect:list.do";
	}

	// 글 삭제
	@RequestMapping("/del.do")
	@ResponseBody // 이걸 넣어주어야 돌아간다.
	public String del(int q_board_idx) {
		// update, delete, insert 같은 애들은 int로 받는다고 하니 int
		// (이게 무슨 말인지 알겠으면 따로 주석 추가 부탁드립니다)
		int res = qna_dao.del_update(q_board_idx);

		String result = "no";
		if (res > 0) {
			result = "yes";
		}

		String resultStr = String.format("[{'result':'%s'}]", result);

		return resultStr;
	}

	// 답변 작성화면으로 이동
	@RequestMapping("/reply_form.do")
	public String replyForm(int q_board_idx, String page) {
		return Common.Qna.VIEW_PATH + "qna_reply.jsp?q_board_idx=" + q_board_idx + "&page=" + page;
	}

	// 답변 reply 작성
	@RequestMapping("/reply.do")
	public String reply(QnaVO vo, int q_board_idx, String page) {

		// 답변을 작성하고 싶은 게시글의 q_board_idx에 해당되는 상세 정보를 얻기
		QnaVO baseVO = qna_dao.selectOne(vo.getQ_board_idx());
		// vo안에 있는 idx를 가져온 거임.

		// 가져온 baseVO의 step보다 큰 값을 가진 데이터들의
		// step을 +1 처리.
		qna_dao.update_step(baseVO); // 새로운 댓글 들어갈테니 자리 확보하세요

		// 댓글이 들어갈 위치 설정
		vo.setQ_board_ref(baseVO.getQ_board_ref());
		vo.setDepth(baseVO.getDepth() + 1);

		qna_dao.reply(vo);
		// response.sendRedirect("list.do?page="+page);
		return "redirect:list.do?page=" + page;

	}

}
