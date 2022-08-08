package dao;

import domain.QnaDto;
import domain.SearchCondition;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:web/WEB-INF/applicationContext.xml"})
public class QnaDaoImplTest {

    @Autowired
    private QnaDao qnaDao;

    // 게시물 개수 불러오는 Test
    @Test
    public void countTest() throws Exception {

        // 1. 기존에 있는 게시물들을 전부 삭제 후 개수가 0개 인지 확인.
        qnaDao.deleteAll();
        assertTrue(qnaDao.count()==0);

        // 2. 게시물을 임의로 집어 넣어서 넣은 개수 만큼 정확히 개수를 불러오는지 확인.
        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        assertTrue(qnaDao.insert(qnaDto)==1);
        assertTrue(qnaDao.insert(qnaDto)==1);
        assertTrue(qnaDao.count()==2);
    }

    // 게시물 전체 삭제하는 Test
    @Test
    public void deleteAllTest() throws Exception {

        // 1. 기존에 있는 게시물들을 전부 삭제 후 개수가 0개 인지 확인.
        qnaDao.deleteAll();
        assertTrue(qnaDao.count()==0);

        // 2. 게시물을 임의로 집어 넣어서 deleteAll 실행시 전부 삭제가 되는지 확인.
        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        assertTrue(qnaDao.insert(qnaDto)==1);
        assertTrue(qnaDao.insert(qnaDto)==1);
        assertTrue(qnaDao.insert(qnaDto)==1);
        assertTrue(qnaDao.count()==3);
        assertTrue(qnaDao.deleteAll()==3);
    }

    // 게시물 삭제 Test
    @Test
    public void deleteTest() throws Exception {

        // 1. 기존에 있는 게시물들을 전부 삭제 후 개수가 0개 인지 확인.
        qnaDao.deleteAll();
        assertTrue(qnaDao.count()==0);

        // 2. 게시물을 집어 넣고 첫번째 게시물의 bno를 불러와서 nickname과 함께 넘겨주면 삭제가 되는지 확인.
        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        assertTrue(qnaDao.insert(qnaDto)==1);
        Integer bno = qnaDao.selectAll().get(0).getBno();
        assertTrue(qnaDao.delete(bno, qnaDto.getNickname())==1);
        assertTrue(qnaDao.count()==0);
    }

    // 게시물 등록 Test
    @Test
    public void insertTest() throws Exception {

        // 1. 기존에 있는 게시물들을 전부 삭제 후 개수가 0개 인지 확인.
        qnaDao.deleteAll();
        assertTrue(qnaDao.count()==0);

        // 2. 게시물을 집어 넣고 개수가 증가 되는지 확인.
        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        assertTrue(qnaDao.insert(qnaDto)==1);
        assertTrue(qnaDao.count()==1);
    }

    // 게시물 목록을 불러오는 Test
    @Test
    public void selectAllTest() throws Exception {

        // 1. 기존에 있는 게시물들을 전부 삭제 후 개수가 0개 인지 확인.
        qnaDao.deleteAll();
        assertTrue(qnaDao.count()==0);

        // 2. 게시물 목록을 가져올 list를 생성 후 게시물을 집어 넣고 selectAll() 진행 시 list의 size가 증가되는지 확인.
        List<QnaDto> list = qnaDao.selectAll();
        assertTrue(list.size()==0);

        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        assertTrue(qnaDao.insert(qnaDto)==1);
        assertTrue(qnaDao.insert(qnaDto)==1);
        list = qnaDao.selectAll();
        assertTrue(list.size()==2);
    }

    // 게시물 불러오는 Test
    @Test
    public void selectTest() throws Exception {

        // 1. 기존에 있는 게시물들을 전부 삭제 후 개수가 0개 인지 확인.
        qnaDao.deleteAll();
        assertTrue(qnaDao.count()==0);

        // 2. 게시물을 집어넣고 bno를 통해 다른 Dto에 select 한 경우 같은지 확인.
        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        assertTrue(qnaDao.insert(qnaDto)==1);

        Integer bno = qnaDao.selectAll().get(0).getBno();
        QnaDto qnaDto2 = qnaDao.select(bno);
        qnaDto.setBno(bno);
        assertTrue(qnaDto.equals(qnaDto2));
    }

    // 게시물 수정 Test
    @Test
    public void updateTest() throws Exception {

        // 1. 기존에 있는 게시물들을 전부 삭제 후 개수가 0개 인지 확인.
        qnaDao.deleteAll();
        assertTrue(qnaDao.count()==0);

        // 2. 게시물을 집어넣고 수정한다음 같은지 확인.
        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        qnaDao.insert(qnaDto);
        Integer bno = qnaDao.selectAll().get(0).getBno();
        qnaDto.setBno(bno);
        qnaDto.setTitle("second title");
        assertTrue(qnaDao.update(qnaDto)==1);

        QnaDto qnaDto2 = qnaDao.select(bno);
        assertTrue(qnaDto.equals(qnaDto2));
    }

    // 게시물 조회수 증가 Test
    @Test
    public void increaseViewCntTest() throws Exception {

        // 1. 기존에 있는 게시물들을 전부 삭제 후 개수가 0개 인지 확인.
        qnaDao.deleteAll();
        assertTrue(qnaDao.count() == 0);

        // 2. 게시물을 집어넣고 조회수 증가 후 숫자 확인.
        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        assertTrue(qnaDao.insert(qnaDto) == 1);
        Integer bno = qnaDao.selectAll().get(0).getBno();
        System.out.println("bno = " + bno);
        assertTrue(qnaDao.increaseViewCnt(bno) == 1);
        assertTrue(qnaDao.increaseViewCnt(bno) == 1);
        assertTrue(qnaDao.increaseViewCnt(bno) == 1);

        QnaDto qnaDto2 = qnaDao.select(bno);
        assertTrue(qnaDto2.getView_cnt() == 3);
    }

    @Test
    public void selectPageTest() throws Exception {

        // 1. 게시물을 집어넣고 offset과 pageSize 값을 주어 페이지를 정확히 가지고 오는지 확인.
        qnaDao.deleteAll();

        for (int i = 1; i <= 10; i++) {
            QnaDto qnaDto = new QnaDto("title"+i, "content"+i, "jinkyu"+i);
            qnaDao.insert(qnaDto);
        }

        Map map = new HashMap();
        map.put("offset", 0);
        map.put("pageSize", 3);

        List<QnaDto> list = qnaDao.selectPage(map);
        System.out.println("list = " + list);
        assertTrue(list.get(0).getTitle().equals("title10"));
        assertTrue(list.get(1).getTitle().equals("title9"));
        assertTrue(list.get(2).getTitle().equals("title8"));
    }

    // 게시물 데이터 넣기위한 Test
    @Test
    public void insertTestData() throws Exception {
        qnaDao.deleteAll();
        for (int i = 1; i <= 220; i++) {
            QnaDto qnaDto = new QnaDto("title"+i, "content"+i,"jinkyu"+i);
            qnaDao.insert(qnaDto);
        }
    }

    // 검색 게시물 불러오는 Test
    @Test
    public void searchSelectPageTest() throws Exception {

        // 게시물을 다 지우기
        qnaDao.deleteAll();
        for (int i = 1; i <= 20; i++) {
            QnaDto qnaDto = new QnaDto("title"+i, "content"+i, "jinkyu"+i);
            qnaDao.insert(qnaDto);
        }

        // 제목 검색조건(여기서는 %title2% = title2, title20)에 맞는 게시물을 불러오는지 확인.
        SearchCondition sc = new SearchCondition(1, 10, "title2", "T");
        List<QnaDto> list = qnaDao.searchSelectPage(sc);
        System.out.println("list = " + list);
        assertTrue(list.size()==2);

        // 작성자 검색조건(여기서는 %jinkyu2% = jinkyu2, jinkyu20)에 맞는 게시물을 불러오는지 확인.
        sc = new SearchCondition(1, 10, "jinkyu2", "W");
        list = qnaDao.searchSelectPage(sc);
        System.out.println("list = " + list);
        assertTrue(list.size()==2);
    }

    // 검색 게시물 개수 불러오는 Test
    @Test
    public void searchResultCntTest() throws Exception {

        // 게시물을 다 지우기
        qnaDao.deleteAll();
        for (int i = 1; i <= 20; i++) {
            QnaDto qnaDto = new QnaDto("title"+i, "content"+i, "jinkyu"+i);
            qnaDao.insert(qnaDto);
        }
        // 제목 검색조건(여기서는 %title2% = title2, title20)에 맞는 게시물 개수를 정확히 불러오는지 확인.
        SearchCondition sc = new SearchCondition(1, 10, "title2", "T");
        int qnaCnt = qnaDao.searchResultCnt(sc);
        assertTrue(qnaCnt == 2);

        // 작성자 검색조건(여기서는 %jinkyu2% = jinkyu2, jinkyu20)에 맞는 게시물 개수를 정확히 불러오는지 확인.
        sc = new SearchCondition(1, 10, "jinkyu2", "W");
        qnaCnt = qnaDao.searchResultCnt(sc);
        assertTrue(qnaCnt==2);
    }
}