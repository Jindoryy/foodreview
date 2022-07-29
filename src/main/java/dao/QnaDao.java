package dao;

import domain.QnaDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;

public class QnaDao {

    @Autowired
    SqlSession session;

    QnaDto select(int bno) {
        return session.selectOne("select", bno);
    }
}
