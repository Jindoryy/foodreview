<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>
<c:set var="loginID" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login' : '/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? '로그인' : '로그아웃'}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>foodreviews</title>
<%--    <link rel="stylesheet" type="text/css" href="/css/menu.css">--%>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin : 0;
            padding: 0;
        }

        a { text-decoration: none;  }

        ul {
            list-style-type: none;
            height: 48px;
            width: 100%;
            background-color: #5F5F5F;
            display: flex;
        }

        ul > li {
            color: lightgray;
            height : 100%;
            width:90px;
            display:flex;
            align-items: center;
        }

        ul > li > a {
            color: lightgray;
            margin:auto;
            padding: 10px;
            font-size:16px;
            align-items: center;
        }

        ul > li > a:hover {
            color :white;
            border-bottom: 3px solid rgb(209, 209, 209);
        }

        #logo {
            color:white;
            font-size: 16px;
            padding-left:40px;
            margin-right:auto;
            display: flex;
        }

        <%-- 상단바 --%>

        .container {
            width : 50%;
            margin : auto;
        }

        .writing-header {
            position: relative;
            margin: 20px 0 0 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #323232;
            text-align: center;
        }

        input {
            width: 100%;
            height: 35px;
            margin: 20px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            padding: 8px;
            background: #f8f8f8;
            outline-color: #e6e6e6;
        }

        textarea {
            width: 100%;
            background: #f8f8f8;
            margin: 20px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            resize: none;
            padding: 8px;
            outline-color: #e6e6e6;
        }

        .frm {
            width:100%;
        }

        .btn {
            background-color: rgb(236, 236, 236);
            border: none;
            color: black;
            padding: 6px 12px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
        }

        .btn:hover {
            text-decoration: underline;
        }

        <%-- 글쓰기 화면 --%>
    </style>
</head>

<body>
<div id="menu">
    <ul>
        <li id="logo">REVIEW</li>
        <li><a href="<c:url value='/'/>">홈</a></li>
        <li><a href="<c:url value='/qna/list'/>">Q&A</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/register/add'/>">회원가입</a></li>
    </ul>
</div>

<script>
    let msg ="${msg}"
    if (msg == "write_no") alert("등록 실패했습니다.")
    if (msg == "modify_no") alert("수정 실패했습니다.")
</script>

<div class="container">
    <h2 class="writing-header">게시물 ${mode=="new" ? "쓰기" : "읽기"}</h2>
    <form action="" id="form" class="frm">
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