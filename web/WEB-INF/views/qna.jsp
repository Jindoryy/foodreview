<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="loginID" value="${sessionScope.id}"/>
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

<script>
    let msg ="${msg}"
    if (msg == "write_no") alert("등록 실패했습니다.")
    if (msg == "modify_no") alert("수정 실패했습니다.")
</script>

<div style="...">
    <h2>게시물 ${mode=="new" ? "쓰기" : "읽기"}</h2>
    <form action="" id="form">
        <input type="hidden" name="bno" value="${qnaDto.bno}" readonly="readonly">
        <input type="text" name="title" value="<c:out value='${qnaDto.title}'/>" ${mode == "new" ? '' : 'readonly="readonly"'}>
        <textarea name="content" id="" cols="30" rows="10" ${mode == "new" ? '' : 'readonly="readonly"'}><c:out value='${qnaDto.content}'/></textarea>

        <c:if test="${mode eq 'new'}">
            <button type="button" id="writeBtn" class="btn">등록</button>
        </c:if>
        <c:if test="${mode ne 'new'}">
            <button type="button" id="writeNewBtn" class="btn">글쓰기</button>
        </c:if>

        <c:if test="${qnaDto.nickname eq loginID}">
        <button type="button" id="modifyBtn" class="btn">수정</button>
        <button type="button" id="removeBtn" class="btn">삭제</button>
        </c:if>

        <button type="button" id="listBtn" class="btn">목록</button>
    </form>
</div>

<script>
    $(document).ready(function() {

        let formCheck = function() { // 글을 작성하거나 수정할 때 제목이나 내용에 빈 부분이 있는지 확인.
            let form = document.getElementById("form");
            if(form.title.value=="") {
                alert("제목을 입력해 주세요.");
                form.title.focus();
                return false;
            }
            if(form.content.value=="") {
                alert("내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            return true;
        }

        $('#listBtn').on("click", function () {
            location.href = "<c:url value='/qna/list'/>?page=${page}&pageSize=${pageSize}";
        });

        $('#modifyBtn').on("click", function () {
            // 1. 게시물이 읽기 상태이면 수정 상태로 변경
            let form = $('#form');
            let isReadOnly = $("input[name=title]").attr('readonly');

            if (isReadOnly=='readonly') {
                $("input[name=title]").attr('readonly', false); // 제목
                $("textarea").attr('readonly', false); // 내용
                $("h2").html("게시물 수정");
                $("#modifyBtn").html("등록")
                return;
            }

            // 2. 게시물이 수정 상태이면 수정된 내용을 서버로 전송
            form.attr("action", "<c:url value='/qna/modify${ph.sc.queryString}'/>");
            form.attr("method", "post");
            if (formCheck())
                form.submit();
        });

        // 글쓰기가 아닌 '글수정'과 같은 다른 작업이 진행 중 일때
        $('#writeNewBtn').on("click", function (){
            location.href="<c:url value='/qna/write'/>";
        });

        // 글쓰기가 진행 중 일때
        $('#writeBtn').on("click", function () {
            let form = $('#form');
            form.attr("action", "<c:url value='/qna/write'/>");
            form.attr("method", "post");

            if (formCheck())
                form.submit();
        });

        $('#removeBtn').on("click", function () {
            if(!confirm("정말로 삭제하시겠습니까?")) return;
            let form = $('#form');
            form.attr("action", "<c:url value='/qna/remove'/>?page=${page}&pageSize=${pageSize}");
            form.attr("method", "post");
            form.submit();
        });
    });
</script>

</body>
</html>