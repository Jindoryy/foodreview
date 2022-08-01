package dao;

import domain.QnaDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

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
        assertTrue(qnaDao.count()==0);

        // 2. 게시물을 집어넣고 조회수 증가 후 숫자 확인.
        QnaDto qnaDto = new QnaDto("title", "content", "jinkyu");
        assertTrue(qnaDao.insert(qnaDto)==1);
        Integer bno = qnaDao.selectAll().get(0).getBno();
        System.out.println("bno = " + bno);
        assertTrue(qnaDao.increaseViewCnt(bno)==1);
        assertTrue(qnaDao.increaseViewCnt(bno)==1);
        assertTrue(qnaDao.increaseViewCnt(bno)==1);

        QnaDto qnaDto2 = qnaDao.select(bno);
        System.out.println("qnaDto2 = " + qnaDto2);
        assertTrue(qnaDto2.getView_cnt()==3);

    }
}