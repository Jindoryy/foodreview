package controller;

import domain.PageHandler;
import domain.QnaDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.jdbc.support.incrementer.HsqlMaxValueIncrementer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import service.QnaService;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/qna")
public class QnaController {

    @Autowired
    QnaService qnaService;

    // 지정된 게시물 삭제
    @PostMapping("/remove")
    public String remove(Integer bno, Integer page, Integer pageSize, Model m, HttpSession session) {
        String nickname = (String)session.getAttribute("nickname");
        try {
            qnaService.remove(bno, nickname);
        } catch (Exception e) {
            e.printStackTrace();
        }

        m.addAttribute("page", page);
        m.addAttribute("pageSize", pageSize);
        return "redirect:/qna/list"; // 모델에 담아주면 redirect 뒤에 알아서 붙음
    }

    // 지정된 게시물 읽기
    @GetMapping("/read")
    public String read(Integer bno, Integer page, Integer pageSize, Model m) {

        try {
            QnaDto qnaDto = qnaService.read(bno);
            m.addAttribute(qnaDto);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "qna";
    }

    // 게시물 목록 가져오기
    @GetMapping("list")
    public String list(Integer page, Integer pageSize, Model m, HttpServletRequest request) {

        // offset과 pageSize를 넘겨주어 페이징 처리를 함.
        if (page == null) page = 1;
        if (pageSize == null) pageSize = 10;

        try {
            int totalCnt = qnaService.getCount();
            PageHandler pageHandler = new PageHandler(totalCnt, page, pageSize);
            Map map = new HashMap();
            map.put("offset", (page-1)*pageSize);
            map.put("pageSize", pageSize);

            List<QnaDto> list = qnaService.getPage(map);
            m.addAttribute("list", list);
            m.addAttribute("ph",pageHandler);
            m.addAttribute("page", page);
            m.addAttribute("pageSize", pageSize);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return "qnaList";
    }
}
