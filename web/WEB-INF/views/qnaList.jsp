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

<div style="text-align:center">
    <button type="button" id="writeBtn" onclick="location.href='<c:url value="/qna/write"/>'">글쓰기</button>
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
            <td><a href="<c:url value='/qna/read?bno=${qnaDto.bno}&page=${page}&pageSize=${pageSize}'/>">${qnaDto.title}</a></td>
            <td>${qnaDto.nickname}</td>
            <td>${qnaDto.reg_date}</td>
            <td>${qnaDto.view_cnt}</td>
        </tr>
        </c:forEach>
    </table>

    <br>
    <div>
        <c:if test="${ph.showPrev}">
            <a href="<c:url value='/qna/list?page=${ph.beginPage-1}&pageSize=${ph.pageSize}'/>">&lt;</a>
        </c:if>
        <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
            <a href="<c:url value='/qna/list?page=${i}&pageSize=${ph.pageSize}'/>">${i}</a>
        </c:forEach>
        <c:if test="${ph.showNext}">
            <a href="<c:url value='/qna/list?page=${ph.endPage+1}&pageSize=${ph.pageSize}'/>">&gt;</a>
        </c:if>
    </div>
</div>
</body>
</html>