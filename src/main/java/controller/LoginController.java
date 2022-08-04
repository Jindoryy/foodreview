package controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
public class LoginController {

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
    public String login(String id, String password, String nickname,
                        HttpServletRequest request, HttpServletResponse response) {

        // 1. id, password 확인
        if (!loginCheck(id, password)) {
            return "redirect:/login";
        }

        // 2. id, password 일치 하는 경우 세션 생성
        HttpSession session = request.getSession();
        session.setAttribute("id", id);

        // 2-1. 아이디 기억 체크한 경우 쿠키에 세션을 담아 보내기(미완성)
        return "redirect:/login";
    }

    // 미완성
    private boolean loginCheck(String id, String password) {
        return true;
    }
}
