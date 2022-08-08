package domain;

import org.springframework.web.util.UriComponentsBuilder;

public class SearchCondition {
    private Integer page = 1;
    private Integer pageSize = 10;
    private String keyword = ""; // 검색어
    private String option = ""; // option에 따라 검색범위 설정(제목을 검색어에 따라 검색할지, 작성자를 검색어에 따라 검색할지)

    public SearchCondition() {}
    public SearchCondition(Integer page, Integer pageSize, String keyword, String option) {
        this.page = page;
        this.pageSize = pageSize;
        this.keyword = keyword;
        this.option = option;
    }

    // 페이지를 지정해주면 해당 페이지를
    public String getQueryString(Integer page) { // ?page=1&pageSize=10&option="T"&keyword="title" 이렇게 반환할 수 있도록 하는 함수
        return UriComponentsBuilder.newInstance()
                .queryParam("page", page)
                .queryParam("pageSize", pageSize)
                .queryParam("option", option)
                .queryParam("keyword", keyword)
                .build().toString();

    }
    // 페이지를 지정해주지 않으면 검색 조건 페이지에서 페이지를
    public String getQueryString() { // ?page=1&pageSize=10&option="T"&keyword="title" 이렇게 반환할 수 있도록 하는 함수
        return getQueryString(page);
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public Integer getPageSize() {
        return pageSize;
    }

    public void setPageSize(Integer pageSize) {
        this.pageSize = pageSize;
    }

    public Integer getOffset() {
        return (page-1) * pageSize;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public String getOption() {
        return option;
    }

    public void setOption(String option) {
        this.option = option;
    }

    @Override
    public String toString() {
        return "SearchCondition{" +
                "page=" + page +
                ", pageSize=" + pageSize +
                ", offset=" + getOffset() +
                ", keyword='" + keyword + '\'' +
                ", option='" + option + '\'' +
                '}';
    }
}
