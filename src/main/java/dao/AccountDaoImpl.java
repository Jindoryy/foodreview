package dao;

import domain.AccountDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class AccountDaoImpl implements AccountDao {

    @Autowired
    private SqlSession session;
    private static String namespace="dao.accountMapper.";

    @Override
    public AccountDto loginCheck(String id) throws Exception {
        return session.selectOne(namespace+"select", id);
    }
}