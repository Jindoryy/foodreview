package dao;

import domain.QnaDto;
import domain.SearchCondition;

import java.util.List;
import java.util.Map;

public interface QnaDao {
    // 게시물 번호를 주면 게시물 내용 불러오기
    QnaDto select(Integer bno) throws Exception;

    // 게시물 개수 불러오기
    int count() throws Exception;

    // 게시판 목록 보여주기
    List<QnaDto> selectAll() throws Exception;

    // 페이징 처리
    List<QnaDto> selectPage(Map map) throws Exception;

    // 게시물 정보를 주면 게시글을 등록해주기
    int insert(QnaDto dto) throws Exception;

    // 게시물 수정 내용을 주면 게시글 수정해주기
    int update(QnaDto dto) throws Exception;

    // 게시물 번호를 주면 조회수 증가해주기
    int increaseViewCnt(Integer bno) throws Exception;

    // 게시물 번호를 주면 등록자 확인 후 내용 삭제하기
    int delete(Integer bno, String nickname) throws Exception;

    // 게시물 목록 전체 내용 삭제하기
    int deleteAll();

    // 검색 페이지 불러오기
    List<QnaDto> searchSelectPage(SearchCondition sc) throws Exception;

    // 검색 게시물 개수 불러오기
    int searchResultCnt(SearchCondition sc) throws Exception;

    // 댓글이 달리거나 지워지면 댓글 개수를 바꿔주는 함수
    int updateCommentCnt(Integer bno, int cnt);
}
