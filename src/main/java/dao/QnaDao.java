package dao;

import domain.QnaDto;

public interface QnaDao {
    QnaDto select(int bno) throws Exception;
}
