<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>foodreviews</title>
<%--    <link rel="stylesheet" type="text/css" href="/css/menu.css">--%>
</head>
<body>
<div id="menu">
    <ul>
        <li id="logo">FoodReviews</li>
        <li><a href="<c:url value='/'/>">FoodReviews Home</a></li>
        <li><a href="<c:url value='/qna/list'/>">Q&A</a></li>
        <li><a href="<c:url value='/review/list'/>">리뷰모음(미완성)</a></li>
        <li><a href="<c:url value='/login'/>">로그인(미완성)</a></li>
        <li><a href="<c:url value='/register/add'/>">회원가입(미완성)</a></li>
        <li><a href="<c:url value='/around/list'/>">내주변 음식점 리뷰 찾기(미완성)</a></li>
    </ul>
</div>

<script>
    let msg = "${msg}"
    if (msg=="write_yes") alert("등록 성공했습니다.")
    if (msg=="remove_yes") alert("삭제 성공했습니다.")
    if (msg=="remove_no") alert("삭제 실패했습니다.")
    if (msg=="modify_yes") alert("수정 성공했습니다.")
</script>

<div class="search-container">
    <form action="<c:url value="/qna/list"/>" class="search-form" method="get">
        <select class="search-option" name="option">
            <option value="A" ${ph.sc.option=='A' || ph.sc.option=='' ? "selected" : ""}>제목+내용</option>
            <option value="T" ${ph.sc.option=='T' ? "selected" : ""}>제목만</option>
            <option value="W" ${ph.sc.option=='W' ? "selected" : ""}>작성자</option>
        </select>

        <input type="text" name="keyword" class="search-input" type="text" value="${ph.sc.keyword}" placeholder="검색어를 입력해주세요">
        <input type="submit" class="search-button" value="검색">

        <button id="writeBtn" class="btn-write" onclick="location.href='<c:url value="/qna/write"/>'">글쓰기</button>
    </form>
</div>

<div style="text-align:center">
    <table border = "1">
        <tr>
            <th>번호</th>
            <th>제목</th>
            <th>작성자</th>
            <th>등록일</th>
            <th>조회수</th>
        </tr>

        <c:forEach var="qnaDto" items="${list}">
        <tr>
            <td>${qnaDto.bno}</td>
            <td><a href="<c:url value='/qna/read${ph.sc.queryString}&bno=${qnaDto.bno}'/>"><c:out value='${qnaDto.title}'/></a></td>
            <td>${qnaDto.nickname}</td>
            <td>${qnaDto.reg_date}</td>
            <td>${qnaDto.view_cnt}</td>
        </tr>
        </c:forEach>
    </table>

    <br>
    <div>
        <c:if test="${ph.showPrev}">
            <a href="<c:url value='/qna/list${ph.sc.getQueryString(ph.beginPage-1)}'/>">&lt;</a>
        </c:if>
        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
            <a href="<c:url value='/qna/list${ph.sc.getQueryString(i)}'/>">${i}</a>
        </c:forEach>
        <c:if test="${ph.showNext}">
            <a href="<c:url value='/qna/list${ph.sc.getQueryString(ph.endPage+1)}'/>">&gt;</a>
        </c:if>
    </div>
</div>
</body>
</html>