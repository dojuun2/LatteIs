package com.academy.latteis.board.service;

import com.academy.latteis.board.domain.Board;
import com.academy.latteis.board.dto.BoardConvertDTO;
import com.academy.latteis.board.repository.BoardMapper;
import com.academy.latteis.common.page.Page;
import com.academy.latteis.common.search.Search;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.web.util.WebUtils;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
@Log4j2
@RequiredArgsConstructor
public class BoardService {

    private final BoardMapper boardMapper;

    // 게시글 작성
    public boolean writeService(Board board) {
        log.info("save service start - {}", board);

        // 게시물 내용 DB에 저장
        boolean flag = boardMapper.write(board);

        return flag;
    }

    // 게시글 전체 조회
    public Map<String, Object> findAllService(Search search) {
        log.info("findAll service start");

        Map<String, Object> findDataMap = new HashMap<>();

        List<BoardConvertDTO> boardList = boardMapper.findAll(search);

        // 목록 중간 데이터 처리
        processConverting(boardList);

        findDataMap.put("boardList", boardList);
        findDataMap.put("totalCount", boardMapper.getTotalCount(search));
        return findDataMap;
    }

    private void processConverting(List<BoardConvertDTO> boardList) {
        for (BoardConvertDTO b : boardList) {
            convertDateFormat(b);
            substringTitle(b);
        }
    }

    // 날짜 형식 초기화 메소드
    private void convertDateFormat(BoardConvertDTO b){
        Date date = b.getRegdate();
        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd a hh:mm");
        b.setPrettierDate(sdf.format(date));
    }

    // 제목 단축 메소드
    private void substringTitle(BoardConvertDTO b){
        // 만약에 글제목이 10글자 이상이라면
        // 10글자만 보여주고 나머지는 ... 처리
        String title = b.getTitle();
        if (title.length()> 10){
            String subStr = title.substring(0, 10);
            b.setShortTitle(subStr + "...");
        }else {
            b.setShortTitle(title);
        }
    }

    // 게시글 상세보기
    public Board findOneService(Long boardNo, HttpServletResponse response, HttpServletRequest request) {
        log.info("findOne service start");

        Board board = boardMapper.findOne(boardNo);

        // 해당 게시물 번호에 해당하는 쿠키가 있는지 확인
        // 쿠키가 없으면 조회수를 상승시켜주고 쿠키를 만들어서 클라이언트에 전송
        makeHit(boardNo, response, request);

        return board;
    }

    // 조회수 상승 처리
    private void makeHit(Long boardNo, HttpServletResponse response, HttpServletRequest request){
        // 먼저 쿠키를 조회함 => 해당 이름의 쿠키가 있으면 쿠키가 들어올 것이고, 없다면 null이 들어올 것임
        Cookie foundCookie = WebUtils.getCookie(request, "b"+boardNo);

        if (foundCookie == null){   // 쿠키가 없다면~~
            boardMapper.upHit(boardNo); // 조회수 상승 시키고
            Cookie cookie = new Cookie("b"+boardNo, String.valueOf(boardNo));   // 쿠키 생성
            cookie.setMaxAge(60);   // 쿠키 수명을 1분으로 설정
            cookie.setPath("/freeboard/detail");   // 쿠키 작동 범위

            response.addCookie(cookie);   // 클라이언트에게 쿠키 전송
        }
    }

    // 게시글 삭제
    public boolean removeService(Long boardNo) {
        log.info("remove service start");
        boolean flag = boardMapper.remove(boardNo);
        return flag;
    }

    // 게시글 수정
    public boolean editService(Board board) {
        log.info("edit service start");
        boolean flag = boardMapper.edit(board);
        return flag;
    }


}
