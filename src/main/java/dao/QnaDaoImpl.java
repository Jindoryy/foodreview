package dao;

import domain.QnaDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class QnaDaoImpl implements QnaDao {

    @Autowired
    private SqlSession session;
    private String namespace="dao.qnaMapper.";

    @Override
    public QnaDto select(int bno) throws Exception {
        return session.selectOne(namespace+"select", bno);
    }
}
