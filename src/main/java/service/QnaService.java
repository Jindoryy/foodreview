package service;

import domain.QnaDto;
import domain.SearchCondition;

import java.util.List;
import java.util.Map;

public interface QnaService {
    int getCount() throws Exception;

    int remove(Integer bno, String nickname) throws Exception;

    int write(QnaDto qnaDto) throws Exception;

    int modify(QnaDto qnaDto) throws Exception;

    List<QnaDto> getList() throws Exception;

    QnaDto read(Integer bno) throws Exception;

    List<QnaDto> getPage(Map map) throws Exception;

    List<QnaDto> getSearchResultPage(SearchCondition sc) throws Exception;

    int getSearchResultCnt(SearchCondition sc) throws Exception;
}
