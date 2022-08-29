package controller;

import domain.AccountDto;
import domain.CommentDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.*;
import service.AccountService;
import service.CommentService;

import javax.servlet.http.HttpSession;
import java.util.List;

// @Controller = @ResponseBody + @Controller
// @ResponseBody 안 붙이면 문자열 return을 jsp 이름으로 앎
//@ResponseBody
//@Controller
@RestController
public class CommentController {

    @Autowired
    CommentService service;

    @Autowired
    AccountService accountService;

    // 해당 게시물에 댓글 수정하기
    @PatchMapping("/comments/{cno}")
    public ResponseEntity<String> modify(@PathVariable Integer cno, @RequestBody CommentDto dto, HttpSession session){
        // @RequestBody = json으로 온걸 자바 객체로 변환
        String id = (String) session.getAttribute("id");
        AccountDto accountDto = null;
        try {
            accountDto = accountService.loginCheck(id);
        } catch (Exception e) {
        }
        String commenter = accountDto.getNickname();
        dto.setCommenter(commenter);
        dto.setCno(cno);

        try {
            int resCnt = service.modify(dto);
            System.out.println("resCnt = " + resCnt);
            if (resCnt != 1)
                throw new Exception("modify_no");

            return new ResponseEntity<>("modify_yes", HttpStatus.OK);
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<>("modify_no", HttpStatus.BAD_REQUEST);
        }
    }

    // 해당 게시물에 댓글 저장하기
    @PostMapping("/comments")
    public ResponseEntity<String> write(@RequestBody CommentDto dto, Integer bno, HttpSession session){
        // @RequestBody = json으로 온걸 자바 객체로 변환
        String id = (String) session.getAttribute("id");
        AccountDto accountDto = null;
        try {
            accountDto = accountService.loginCheck(id);
        } catch (Exception e) {
        }
        String commenter = accountDto.getNickname();
        dto.setCommenter(commenter);
        dto.setBno(bno);

        try {
            int resCnt = service.write(dto);

            if (resCnt != 1)
                throw new Exception("write_no");

            return new ResponseEntity<>("write_yes", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("write_no", HttpStatus.BAD_REQUEST);
        }
    }


    // 해당 게시물에 댓글 삭제하기
    @DeleteMapping("/comments/{cno}") // /comments/1?bno=숫자 <- 1은 삭제할 댓글 번호
    public ResponseEntity<String> remove(@PathVariable Integer cno, Integer bno, HttpSession session) {

        String id = (String) session.getAttribute("id");
        AccountDto accountDto = null;
        try {
            accountDto = accountService.loginCheck(id);
        } catch (Exception e) {
        }
        String commenter = accountDto.getNickname();

        try {
            int resCnt = service.remove(cno, bno, commenter);

            if (resCnt != 1)
                throw new Exception("delete_no");

            return new ResponseEntity<>("delete_yes", HttpStatus.OK);
        } catch (Exception e) {
            return new ResponseEntity<>("delete_no", HttpStatus.BAD_REQUEST);
        }
    }

    // 해당 게시물에 모든 댓글 가져오기
    @GetMapping("/comments")
    public ResponseEntity<List<CommentDto>> list(Integer bno) {

        List<CommentDto> list = null;

        try {
            list = service.getList(bno);
            return new ResponseEntity<List<CommentDto>>(list, HttpStatus.OK); // 200
        } catch (Exception e) {
            return new ResponseEntity<List<CommentDto>>(HttpStatus.BAD_REQUEST); // 400
        }
    }
}
