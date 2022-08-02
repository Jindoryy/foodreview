<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>foodreviews</title>
<%--    <link rel="stylesheet" type="text/css" href="/css/menu.css">--%>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
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

<div style="...">
    <h2>게시물 읽기</h2>
    <form action="" id="form">
        <input type="text" name="bno" value="${qnaDto.bno}" readonly="readonly">
        <input type="text" name="title" value="${qnaDto.title}" readonly="readonly">
        <textarea name="content" id="" cols="30" rows="10" readonly="readonly">${qnaDto.content}</textarea>
        <button type="button" id="writeBtn" class="btn">등록</button>
        <button type="button" id="modifyBtn" class="btn">수정</button>
        <button type="button" id="removeBtn" class="btn">삭제</button>
        <button type="button" id="listBtn" class="btn">목록</button>
    </form>
</div>

<script>
    $(document).ready(function() {
        $('#listBtn').on("click", function () {
            location.href = "<c:url value='/qna/list'/>?page=${page}&pageSize=${pageSize}";
        });
        $('#removeBtn').on("click", function () {
            let form = ${'#form'};
            form.attr("action", "<c:url value='qna/remove'/>?page=${page}&pageSize=${pageSize}");
            form.attr("method", "post");
            form.submit();
        });
    });
</script>

</body>
</html>