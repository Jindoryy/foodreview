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
}