package controller;

import domain.AccountDto;
import service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class SignupController {

    @Autowired
    private AccountService accountService;


    @RequestMapping(value = "/signup", method = RequestMethod.GET)
    public String signGET() throws Exception {
        return "signup";
    }

    @RequestMapping(value = "/signup", method = RequestMethod.POST)
    public String signPOST(AccountDto accountDTO, RedirectAttributes redirectAttributes) throws Exception {

        accountService.singup(accountDTO);
        redirectAttributes.addFlashAttribute("msg", "SIGNUP");

        return "login";
    }

    @ResponseBody
    @RequestMapping(value = "/idCheck", method = RequestMethod.GET)
    public int idCheck(@RequestParam("accountId") String accountID) throws Exception {

        int cnt = accountService.idCheck(accountID);

        return cnt;
    }

    @ResponseBody
    @RequestMapping(value = "/nicknameCheck", method = RequestMethod.GET)
    public int nicknameCheck(@RequestParam("accountNickname") String accountNickname) throws Exception {

        int cnt = accountService.nicknameCheck(accountNickname);

        return cnt;
    }


}