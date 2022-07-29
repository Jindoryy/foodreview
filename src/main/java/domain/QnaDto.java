package domain;

import java.util.Date;
import java.util.Objects;

public class QnaDto {
    private Integer bno;
    private String title;
    private String content;
    private String nickname;
    private int view_cnt;
    private int comment_cnt;
    private Date reg_date;
    private Date up_date;

    public QnaDto () {}
    public QnaDto(String title, String content, String nickname) {
        this.title = title;
        this.content = content;
        this.nickname = nickname;
    }

    @Override
    public String toString() {
        return "QnaDto{" +
                "bno=" + bno +
                ", title='" + title + '\'' +
                ", content='" + content + '\'' +
                ", nickname='" + nickname + '\'' +
                ", view_cnt=" + view_cnt +
                ", comment_cnt=" + comment_cnt +
                ", reg_date=" + reg_date +
                ", up_date=" + up_date +
                '}';
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        QnaDto qnaDto = (QnaDto) o;
        return view_cnt == qnaDto.view_cnt && comment_cnt == qnaDto.comment_cnt && Objects.equals(bno, qnaDto.bno) && Objects.equals(title, qnaDto.title) && Objects.equals(content, qnaDto.content) && Objects.equals(nickname, qnaDto.nickname) && Objects.equals(reg_date, qnaDto.reg_date) && Objects.equals(up_date, qnaDto.up_date);
    }

    @Override
    public int hashCode() {
        return Objects.hash(bno, title, content, nickname, view_cnt, comment_cnt, reg_date, up_date);
    }

    public Integer getBno() {
        return bno;
    }

    public void setBno(Integer bno) {
        this.bno = bno;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public int getView_cnt() {
        return view_cnt;
    }

    public void setView_cnt(int view_cnt) {
        this.view_cnt = view_cnt;
    }

    public int getComment_cnt() {
        return comment_cnt;
    }

    public void setComment_cnt(int comment_cnt) {
        this.comment_cnt = comment_cnt;
    }

    public Date getReg_date() {
        return reg_date;
    }

    public void setReg_date(Date reg_date) {
        this.reg_date = reg_date;
    }

    public Date getUp_date() {
        return up_date;
    }

    public void setUp_date(Date up_date) {
        this.up_date = up_date;
    }
}
