package dao;

import domain.QnaDto;
import domain.SearchCondition;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class QnaDaoImpl implements QnaDao {

    @Autowired
    private SqlSession session;
    private static String namespace="dao.qnaMapper.";

    // 게시물 번호를 주면 게시물 내용 불러오기
    @Override
    public QnaDto select(Integer bno) throws Exception {
        return session.selectOne(namespace+"select", bno);
    }

    // 게시물 개수 불러오기
    @Override
    public int count() throws Exception {
        return session.selectOne(namespace+"count");
    }

    // 게시판 목록 보여주기
    @Override
    public List<QnaDto> selectAll() throws Exception {
        return session.selectList(namespace+"selectAll");
    }

    // 페이징 처리
    @Override
    public List<QnaDto> selectPage(Map map) throws Exception {
        return session.selectList(namespace+"selectPage", map);
    }

    // 게시물 정보를 주면 게시글을 등록해주기
    @Override
    public int insert(QnaDto dto) throws Exception {
        return session.insert(namespace+"insert", dto);
    }

    // 게시물 수정 내용을 주면 게시글 수정해주기
    @Override
    public int update(QnaDto dto) throws Exception {
        return session.update(namespace+"update", dto);
    }

    // 게시물 번호를 주면 조회수 증가해주기
    @Override
    public int increaseViewCnt(Integer bno) throws Exception {
        return session.update(namespace+"increaseViewCnt", bno);
    }

    // 게시물 번호를 주면 등록자 확인 후 내용 삭제하기
    @Override
    public int delete(Integer bno, String nickname) throws Exception {
        Map map = new HashMap();
        map.put("bno", bno);
        map.put("nickname", nickname);
        return session.delete(namespace+"delete", map);
    }

    // 게시물 목록 전체 내용 삭제하기
    @Override
    public int deleteAll() {
        return session.delete(namespace+"deleteAll");
    }

    // 검색 페이지 불러오기
    @Override
    public List<QnaDto> searchSelectPage(SearchCondition sc) throws Exception {
        return session.selectList(namespace+"searchSelectPage", sc);
    }

    // 검색 게시물 개수 불러오기
    @Override
    public int searchResultCnt(SearchCondition sc) throws Exception {
        return session.selectOne(namespace+"searchResultCnt", sc);
    }

    @Override
    public int updateCommentCnt(Integer bno, int cnt) {
        Map map = new HashMap();
        map.put("cnt", cnt);
        map.put("bno", bno);
        return session.update(namespace+"updateCommentCnt", map);
    }
}
