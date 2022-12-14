<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>commentTest</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
</head>
<body>
<h2>comment Test</h2>
comment: <input type="text" name="comment"><br>
<button id="sendBtn" type="button">SEND</button>
<button id="modBtn" type="button">수정</button>
<div id="commentList"></div>
<div id="replyForm" style="display: none">
    <input type="text" name="replyComment">
    <button id="wrtRepBtn" type="button">등록</button>
</div>
<script>

    let bno = 870;

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
            if (comment.cno != comment.pcno) // 답글인 경우
                tmp += 'ㄴ'
            tmp += ' commenter=<span class="commenter">' + comment.commenter + '</span>' // 불러오기 쉽게 span으로 감쌈
            tmp += ' comment=<span class="comment">' + comment.comment + '</span>'
            tmp += ' up_date='+comment.up_date
            tmp += '<button class="delBtn">삭제</button>'
            tmp += '<button class="modBtn">수정</button>'
            tmp += '<button class="replyBtn">답글</button>'
            tmp += '</li>'
        })

        return tmp + "</ul>";
    }

    $(document).ready(function(){
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

        // 답글 폼을 댓글 밑의 위치로 옮기기
        $("#commentList").on("click", ".replyBtn", function() {
            // 위의 답글 폼을 해당 댓글위치 밑으로 옮기기
            $("#replyForm").appendTo($(this).parent()); // 답글 폼의 부모(li태그)에 붙이기
            // 답글 입력할 폼 보여주기
            $("#replyForm").css("display", "block");
        });

        // 답글 등록 전송
        $("#wrtRepBtn").click(function(){
            let comment = $("input[name=replyComment]").val();
            let pcno = $("#replyForm").parent().attr("data-pcno"); // 답글의 부모(댓글)의 pcno를 불러오기

            if (comment.trim()=='') {
                alert("답글 입력해주세요");
                $("input[name=replyComment]").focus()
                return;
            }

            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/comments?bno='+bno,  // 요청 URI
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({pcno:pcno, bno:bno, comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);
                    showList(bno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            });
            $("#replyForm").css("display", "none"); // 폼 다시 안보이게 만들기
            $("input[name=replyComment]").val('') // 폼 내용 비우기
            $("#replyForm").appendTo("body") // 원래 있던 자리로 되돌려 놓기
        });

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
    });
</script>
</body>
</html>