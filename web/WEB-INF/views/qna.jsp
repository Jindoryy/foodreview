<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="true"%>
<c:set var="loginID" value="${sessionScope.nickname}"/>
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
        }

        ul > li {
            height : 100%;
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

        .comment {
            width : 50%;
            margin : auto;
        }

        #btn {
            background-color: rgb(236, 236, 236);
            border: none;
            color: black;
            padding: 6px 12px;
            font-size: 12px;
            cursor: pointer;
            border-radius: 5px;
        }

    </style>
</head>

<body>
<div id="menu">
    <ul style="background-color: #5F5F5F; display:flex;" >
        <li id="logo">REVIEW</li>
        <li><a href="<c:url value='/'/>">홈</a></li>
        <li><a href="<c:url value='/qna/list'/>">Q&A</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/signup'/>">회원가입</a></li>
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

<div class="comment">
    <div id="commentList"></div>
<%--    <div id="replyForm" style="display: none">--%>
<%--        <input type="text" name="replyComment">--%>
<%--        <button id="wrtRepBtn" type="button">등록</button>--%>
<%--    </div>--%>

    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <br>
    <input type="text" name="comment"><br>
    <button id="sendBtn" type="button" class="btn">댓글 작성</button>
    <button id="modBtn" type="button" class="btn">수정</button>
</div>
<script>
    let bno = 1776;

    let showList = function (bno) { // 댓글 목록을 가져오는 함수
        $.ajax({
            type:'GET',       // 요청 메서드
            url: '/comments?bno='+bno,  // 요청 URI
            success : function(result){
                $("#commentList").html(toHTML(result)); // 서버로 부터 응답이 도착하면, 호출될 함수
            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        });
    }

    let toHTML = function (comments) { // 댓글 리스트가 들어오면 HTML로 바꿔서 넣어주는 함수
        let tmp = "<ul>";

        comments.forEach(function (comment) {
            tmp += '<li data-cno='+ comment.cno
            tmp += ' data-pcno=' + comment.pcno
            tmp += ' data-bno=' + comment.bno + '>'
            // if (comment.cno != comment.pcno) // 답글인 경우
            //     tmp += 'ㄴ'
            tmp += ' <span class="commenter">' + comment.commenter + '</span>' // 불러오기 쉽게 span으로 감쌈
            tmp += ' <span class="comment">' + comment.comment + '</span>'
            // tmp +=  comment.up_date
            tmp += '<button id="btn" class="delBtn">삭제</button>'
            tmp += '<button id="btn" class="modBtn">수정</button>'
            // tmp += '<button class="replyBtn">답글</button>'
            tmp += '</li>'

        })

        return tmp + "</ul>";
    }

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
                $("#modifyBtn").html("수정 등록")
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


    showList(bno);

    // 댓글 등록 전송
    $("#sendBtn").click(function(){
        let comment = $("input[name=comment]").val();

        if (comment.trim()=='') {
            alert("댓글 입력해주세요");
            $("input[name=comment]").focus()
            return;
        }

        $.ajax({
            type:'POST',       // 요청 메서드
            url: '/comments?bno='+bno,  // 요청 URI
            headers : { "content-type": "application/json"}, // 요청 헤더
            data : JSON.stringify({bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
            success : function(result){
                alert(result);
                showList(bno);
            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        });

    });

    // // 답글 폼을 댓글 밑의 위치로 옮기기
    // $("#commentList").on("click", ".replyBtn", function() {
    //     // 위의 답글 폼을 해당 댓글위치 밑으로 옮기기
    //     $("#replyForm").appendTo($(this).parent()); // 답글 폼의 부모(li태그)에 붙이기
    //     // 답글 입력할 폼 보여주기
    //     $("#replyForm").css("display", "block");
    // });

    // // 답글 등록 전송
    // $("#wrtRepBtn").click(function(){
    //     let comment = $("input[name=replyComment]").val();
    //     let pcno = $("#replyForm").parent().attr("data-pcno"); // 답글의 부모(댓글)의 pcno를 불러오기
    //
    //     if (comment.trim()=='') {
    //         alert("답글 입력해주세요");
    //         $("input[name=replyComment]").focus()
    //         return;
    //     }
    //
    //     $.ajax({
    //         type:'POST',       // 요청 메서드
    //         url: '/comments?bno='+bno,  // 요청 URI
    //         headers : { "content-type": "application/json"}, // 요청 헤더
    //         data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
    //         success : function(result){
    //             alert(result);
    //             showList(bno);
    //         },
    //         error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
    //     });
    //     $("#replyForm").css("display", "none"); // 폼 다시 안보이게 만들기
    //     $("input[name=replyComment]").val('') // 폼 내용 비우기
    //     $("#replyForm").appendTo("body") // 원래 있던 자리로 되돌려 놓기
    // });

    // 댓글 삭제 전송
    $("#commentList").on("click", ".delBtn", function(){ // 동적으로 생성되는 요소에 이벤트 처리
        let cno = $(this).parent().attr("data-cno"); // 부모한테서 값 불러오기
        let bno = $(this).parent().attr("data-bno");

        $.ajax({
            type:'DELETE',       // 요청 메서드
            url: '/comments/'+cno+'?bno='+bno,  // 요청 URI
            success : function(result){
                alert("삭제 되었습니다.")
                showList(bno);
            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        });
    });

    // 댓글 수정 전송 1
    $("#commentList").on("click", ".modBtn", function(){ // 동적으로 생성되는 요소에 이벤트 처리
        let cno = $(this).parent().attr("data-cno"); // 부모한테서 값 불러오기

        let comment = $("span.comment", $(this).parent()).text(); // 버튼을 누른 부모의 span.comment만 가져오기

        // 1. comment내용을 input에 뿌려주기
        $("input[name=comment]").val(comment);

        // 2. cno전달하기
        $("#modBtn").attr("data-cno", cno);
    });

    // 댓글 수정 전송 2
    $("#modBtn").click(function(){
        let cno = $(this).attr("data-cno");
        let comment = $("input[name=comment]").val();

        if (comment.trim()=='') {
            alert("댓글 입력해주세요");
            $("input[name=comment]").focus()
            return;
        }

        $.ajax({
            type:'PATCH',       // 요청 메서드
            url: '/comments/'+cno,  // 요청 URI
            headers : { "content-type": "application/json"}, // 요청 헤더
            data : JSON.stringify({cno:cno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
            success : function(result){
                alert(result);
                showList(bno);
            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        });

    });
</script>

</body>
</html>