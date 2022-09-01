package dao;

import domain.AccountDto;

public interface AccountDao {

    AccountDto loginCheck(String id) throws Exception;

    void signup(AccountDto accountDTO) throws Exception;

    int idCheck(String accountID) throws Exception;

    int nicknameCheck(String accountNickname) throws Exception;
}