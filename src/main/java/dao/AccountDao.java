package dao;

import domain.AccountDto;

public interface AccountDao {

    AccountDto loginCheck(String id) throws Exception;
}