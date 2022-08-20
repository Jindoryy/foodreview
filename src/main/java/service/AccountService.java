package service;

import domain.AccountDto;

public interface AccountService {

    AccountDto loginCheck(String id) throws Exception;
}