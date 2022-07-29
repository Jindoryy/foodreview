package dao;

import domain.QnaDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:web/WEB-INF/applicationContext.xml"})
public class QnaDaoImplTest {

    @Autowired
    QnaDao qnaDao;

    @Test
    public void select() throws Exception {
        assertTrue(qnaDao != null);
        System.out.println("qnaDao = " + qnaDao);

        QnaDto qnaDto = qnaDao.select(1);
        System.out.println("qnaDto = " + qnaDto);
        assertTrue(qnaDto.getBno().equals(1));
    }
}