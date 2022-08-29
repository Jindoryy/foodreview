package controller;

import domain.AccountDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import service.AccountService;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;

@Controller
public class LoginController {

    @Autowired
    AccountService accountService;

    // 로그인 화면 보여주기
    @GetMapping("/login")
    public String login() {
        return "login";
    }

    // 세션 종료 후 로그아웃 후 홈으로 이동
    @GetMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }

    @PostMapping("login")
    public String login(String id, String password, Model m, String toURL, boolean rememberId,
                        HttpServletRequest request, HttpServletResponse response) throws Exception {

        // 1. id, password 확인 -> 만약 일치하지 않으면 메시지와 함께 로그인 화면으로 이동
        if (!loginCheck(id, password)) {

            String msg = URLEncoder.encode("아이디 또는 패스워드가 일치하지 않습니다.", "utf-8");
            return "redirect:/login?msg="+msg;
        }

        // 2. id, password 일치 하는 경우 세션 생성 및 jsp에서 사용하기 위해 세션에 닉네임 대입
        HttpSession session = request.getSession();
        session.setAttribute("id", id);

        AccountDto accountDto = null;
        try {
            accountDto = accountService.loginCheck(id);
        } catch (Exception e) {
        }
        String nickname = accountDto.getNickname();
        session.setAttribute("nickname", nickname);


        // 2-1. 아이디 기억 체크한 경우 쿠키에 세션을 담아 보내기
        if (rememberId) {
            Cookie cookie = new Cookie("id", id);
            response.addCookie(cookie);
        }
        else {
            Cookie cookie = new Cookie("id", id);
            cookie.setMaxAge(0); // 쿠키 삭제
            response.addCookie(cookie);
        }

        toURL = toURL == null || toURL.equals("") ? "/" : toURL;

        return "redirect:"+toURL;
    }

    // 로그인 체크
    private boolean loginCheck(String id, String password) {
        AccountDto accountDto = null;

        try {
            accountDto = accountService.loginCheck(id);
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("accountDto = " + accountDto);
            return false;
        }

        return accountDto != null && accountDto.getPassword().equals(password);
    }
}
