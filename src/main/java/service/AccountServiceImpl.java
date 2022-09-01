package service;

import dao.AccountDao;
import domain.AccountDto;
import domain.CommentDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class AccountServiceImpl implements AccountService {

    @Autowired
    AccountDao accountDao;

    @Override
    public AccountDto loginCheck(String id) throws Exception {
        return accountDao.loginCheck(id);
    }

    @Override
    public void singup(AccountDto accountDTO) throws Exception {

        System.out.println("accountDTO = " + accountDTO);
        accountDao.signup(accountDTO);

    }

    @Override
    public int idCheck(String accountID) throws Exception {

        int cnt = accountDao.idCheck(accountID);

        return cnt;
    }

    @Override
    public int nicknameCheck(String accountNickname) throws Exception {

        int cnt = accountDao.nicknameCheck(accountNickname);

        return cnt;
    }
}