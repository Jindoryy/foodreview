package service;

import dao.QnaDao;
import domain.QnaDto;
import domain.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public class QnaServiceImpl implements QnaService {

    @Autowired
    private QnaDao qnaDao;

    @Override
    public int getCount() throws Exception {
        return qnaDao.count();
    }

    @Override
    public int remove(Integer bno, String nickname) throws Exception {
        return qnaDao.delete(bno, nickname);
    }

    @Override
    public int write(QnaDto qnaDto) throws Exception {
        return qnaDao.insert(qnaDto);
    }

    @Override
    public List<QnaDto> getList() throws Exception {
        return qnaDao.selectAll();
    }

    @Override
    public QnaDto read(Integer bno) throws Exception {
        QnaDto qnaDto = qnaDao.select(bno);
        qnaDao.increaseViewCnt(bno);
        return qnaDto;
    }

    @Override
    public List<QnaDto> getPage(Map map) throws Exception {
        return qnaDao.selectPage(map);
    }

    @Override
    public int modify(QnaDto qnaDto) throws Exception {
        return qnaDao.update(qnaDto);
    }

    @Override
    public List<QnaDto> getSearchResultPage(SearchCondition sc) throws Exception {
        return qnaDao.searchSelectPage(sc);
    }

    @Override
    public int getSearchResultCnt(SearchCondition sc) throws Exception {
        return qnaDao.searchResultCnt(sc);
    }
}
