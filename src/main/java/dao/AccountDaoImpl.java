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

    @Override
    public void signup(AccountDto accountDTO) throws Exception {
        session.insert(namespace + "insertAccount", accountDTO);
    }


    @Override
    public int idCheck(String accountID) throws Exception {

        int id_result = 0;

        System.out.print("DAO 작동 \n");
        System.out.print(accountID);
        System.out.print("\n");
        id_result = session.selectOne(namespace + "CheckID", accountID);
        System.out.print("결과값 \n");
        System.out.print(id_result);
        System.out.print("\n");

        return id_result;
    }

    @Override
    public int nicknameCheck(String accountNickname) throws Exception {

        int nn_result = 0;

        nn_result = session.selectOne(namespace + "CheckNickname", accountNickname);


        return nn_result;
    }
}