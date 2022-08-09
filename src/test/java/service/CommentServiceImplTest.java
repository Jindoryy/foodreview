package service;

import dao.CommentDao;
import dao.QnaDao;
import domain.CommentDto;
import domain.QnaDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:web/WEB-INF/applicationContext.xml"})
public class CommentServiceImplTest {

    @Autowired
    CommentService commentService;
    @Autowired
    CommentDao commentDao;
    @Autowired
    QnaDao qnaDao;

    @Test
    public void remove() throws Exception {
        qnaDao.deleteAll();

        QnaDto qnaDto = new QnaDto("hello", "hello", "asdf");
        assertTrue(qnaDao.insert(qnaDto) == 1);
        Integer bno = qnaDao.selectAll().get(0).getBno();
        System.out.println("bno = " + bno);

        commentDao.deleteAll(bno);
        CommentDto commentDto = new CommentDto(bno, 0, "hi", "qwer");

        assertTrue(qnaDao.select(bno).getComment_cnt() == 0);
        assertTrue(commentService.write(commentDto) == 1);
        assertTrue(qnaDao.select(bno).getComment_cnt() == 1);

        Integer cno = commentDao.selectAll(bno).get(0).getCno();

        // 일부러 예외를 발생시키고 Tx가 취소되는지 확인해야.
        int rowCnt = commentService.remove(cno, bno, commentDto.getCommenter());
        assertTrue(rowCnt == 1);
        assertTrue(qnaDao.select(bno).getComment_cnt() == 0);
    }

    @Test
    public void write() throws Exception {
        qnaDao.deleteAll();

        QnaDto boardDto = new QnaDto("hello", "hello", "asdf");
        assertTrue(qnaDao.insert(boardDto) == 1);
        Integer bno = qnaDao.selectAll().get(0).getBno();
        System.out.println("bno = " + bno);

        commentDao.deleteAll(bno);
        CommentDto commentDto = new CommentDto(bno, 0, "hi", "qwer");

        assertTrue(qnaDao.select(bno).getComment_cnt() == 0);
        assertTrue(commentService.write(commentDto) == 1);

        Integer cno = commentDao.selectAll(bno).get(0).getCno();
        assertTrue(qnaDao.select(bno).getComment_cnt() == 1);
    }
}