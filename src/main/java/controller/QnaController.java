package controller;

import domain.PageHandler;
import domain.QnaDto;
import domain.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.jdbc.support.incrementer.HsqlMaxValueIncrementer;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
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

    // 지정된 게시물 수정
    @PostMapping("/modify")
    public String modify(QnaDto qnaDto, HttpSession session, Model m, RedirectAttributes rattr) {
        String nickname = "jindoryy";
        qnaDto.setNickname(nickname); // 글 수정한 사람 이름 등록

        try {
            int res = qnaService.modify(qnaDto);

            if (res != 1)
                throw new Exception("modify fail");

            rattr.addFlashAttribute("msg","modify_yes");
        } catch (Exception e) { // 만약 게시물 수정에 실패하면 작성해놓았던 내용을 다시 써야 하니깐 모델에 담아줌
            m.addAttribute(qnaDto);
            m.addAttribute("msg", "modify_no");
            return "qna";
        }

        return "redirect:/qna/list";
    }

    // 게시물 쓴 내용 등록
    @PostMapping("/write")
    public String write(QnaDto qnaDto, HttpSession session, Model m, RedirectAttributes rattr) {
        String nickname = "jindoryy";
        qnaDto.setNickname(nickname); // 글 쓴사람 이름 등록

        try {
            int res = qnaService.write(qnaDto);

            if (res != 1)
                throw new Exception("write fail");

            rattr.addFlashAttribute("msg","write_yes");
        } catch (Exception e) { // 만약 게시물 등록에 실패하면 작성해놓았던 내용을 다시 써야 하니깐 모델에 담아줌
            m.addAttribute(qnaDto);
            m.addAttribute("msg", "write_no");
            return "qna";
        }

        return "redirect:/qna/list";
    }

    // 게시물 쓰기 화면 보여주기
    @GetMapping("/write")
    public String write(Model m) {
        m.addAttribute("mode","new");
        return "qna"; // mode가 new이면 "qna.jsp"는 쓰기 용도, 아니면 읽기 용도(readonly)
    }

    // 지정된 게시물 삭제
    @PostMapping("/remove")
    public String remove(Integer bno, Integer page, Integer pageSize, Model m, HttpSession session, RedirectAttributes rattr) {
//        String nickname = (String)session.getAttribute("id");
        String nickname = "jinkyu56";

        m.addAttribute("page", page);
        m.addAttribute("pageSize", pageSize);
        try {
            int res = qnaService.remove(bno, nickname);

            if (res != 1)
                throw new Exception("qna remove error");
            rattr.addFlashAttribute("msg", "remove_yes");

        } catch (Exception e) {
            rattr.addFlashAttribute("msg","remove_no");
        }

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
    public String list(SearchCondition sc, Model m, HttpServletRequest request) {

        try {
            int totalCnt = qnaService.getCount();
            PageHandler pageHandler = new PageHandler(totalCnt, sc);

            List<QnaDto> list = qnaService.getSearchResultPage(sc);
            m.addAttribute("list", list);
            m.addAttribute("ph", pageHandler);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return "qnaList";
    }
}
