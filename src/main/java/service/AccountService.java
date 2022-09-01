package service;

import domain.AccountDto;

public interface AccountService {

    AccountDto loginCheck(String id) throws Exception;

    void singup(AccountDto accountDTO) throws Exception;

    int idCheck(String accountID) throws Exception;

    int nicknameCheck(String accountNickname) throws Exception;
}