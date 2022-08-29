<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login' : '/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? '로그인' : '로그아웃'}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>foodreviews</title>
<%--    <link rel="stylesheet" type="text/css" href="/css/menu.css">--%>
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

        .search-container {
            background-color: rgb(253, 253, 250);
            width: 100%;
            height: 110px;
            border: 1px solid #ddd;
            margin-top : 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        .search-form {
            height: 37px;
            display: flex;
        }
        .search-option {
            width: 100px;
            height: 100%;
            outline: none;
            margin-right: 5px;
            border: 1px solid #ccc;
            color: gray;
        }
        .search-option > option {
            text-align: center;
        }
        .search-input {
            color: gray;
            background-color: white;
            border: 1px solid #ccc;
            height: 100%;
            width: 300px;
            font-size: 15px;
            padding: 5px 7px;
        }
        .search-input::placeholder {
            color: gray;
        }
        .search-button {
            width: 20%;
            height: 100%;
            background-color: rgb(22, 22, 22);
            color: rgb(209, 209, 209);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 15px;
        }
        .search-button:hover {
            color: rgb(165, 165, 165);
        }

        .btn-write {
            background-color: rgb(236, 236, 236);
            border: none;
            color: black;
            padding: 6px 12px;
            font-size: 16px;
            cursor: pointer;
            border-radius: 5px;
            margin-left: 30px;
        }

        .btn-write:hover {
            text-decoration: underline;
        }

        <%-- 검색바 --%>

        table {
            border-collapse: collapse;
            width: 50%;
            margin: auto;
            border-top: 2px solid rgb(39, 39, 39);
            border-bottom: 2px solid rgb(39, 39, 39);
        }
        tr:nth-child(even) {
            background-color: #f0f0f070;
        }
        th,
        td {
            width:300px;
            text-align: center;
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        td {
            color: rgb(53, 53, 53);
        }

        .no      { width:150px;}
        .title   { width:50%;  }
        td.title   { text-align: left;  }
        td.writer  { text-align: center;  }
        td.viewcnt { text-align: center; }
        td.title:hover {
            text-decoration: underline;
        }

        <%-- 테이블 --%>

        .paging-con {
            width:100%;
            height: 70px;
            display: flex;
            margin-top: 50px;
            margin : auto;
        }

        .paging {
            color: black;
            width: 100%;
            align-items: center;
        }

        .page {
            color: black;
            padding: 6px;
            margin-right: 10px;
        }

        .paging-active {
            background-color: rgb(216, 216, 216);
            border-radius: 5px;
            color: rgb(24, 24, 24);
        }

        <%-- 페이징 --%>

    </style>
</head>
<body>
<div>
    <ul style="background-color: #5F5F5F; display:flex;" >
        <li id="logo">REVIEW</li>
        <li><a href="<c:url value='/'/>">홈</a></li>
        <li><a href="<c:url value='/qna/list'/>">Q&A</a></li>
        <li><a href="<c:url value='${loginOutLink}'/>">${loginOut}</a></li>
        <li><a href="<c:url value='/register/add'/>">회원가입</a></li>
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
    </form>

    <button id="writeBtn" class="btn-write" onclick="location.href='<c:url value="/qna/write"/>'">글쓰기</button>
</div>

<div style="text-align:center">
    <table border = "1">
        <tr>
            <th class="no">번호</th>
            <th class="title">제목</th>
            <th class="writer">작성자</th>
            <th class="regdate">등록일</th>
            <th class="viewcnt">조회수</th>
        </tr>

        <c:forEach var="qnaDto" items="${list}">
        <tr>
            <td class="no">${qnaDto.bno}</td>
            <td class="title"><a href="<c:url value='/qna/read${ph.sc.queryString}&bno=${qnaDto.bno}'/>"><c:out value='${qnaDto.title}'/></a></td>
            <td class="writer">${qnaDto.nickname}</td>
            <c:choose>
                <c:when test="${qnaDto.reg_date.time >= startOfToday}">
                    <td class="regdate"><fmt:formatDate value="${qnaDto.reg_date}" pattern="HH:mm" type="time"/></td>
                </c:when>
                <c:otherwise>
                    <td class="regdate"><fmt:formatDate value="${qnaDto.reg_date}" pattern="yyyy-MM-dd" type="date"/></td>
                </c:otherwise>
            </c:choose>
            <td class="viewcnt">${qnaDto.view_cnt}</td>
        </tr>
        </c:forEach>
    </table>
    <br>
    <div class="paging-con">
        <div class="paging">
        <c:if test="${totalCnt==null || totalCnt==0}">
            <div> 게시물이 없습니다. </div>
        </c:if>
        <c:if test="${totalCnt!=null && totalCnt!=0}">
            <c:if test="${ph.showPrev}">
                <a class="page" href="<c:url value='/qna/list${ph.sc.getQueryString(ph.beginPage-1)}'/>">&lt;</a>
            </c:if>
            <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value='/qna/list${ph.sc.getQueryString(i)}'/>">${i}</a>
            </c:forEach>
            <c:if test="${ph.showNext}">
                <a class="page" href="<c:url value='/qna/list${ph.sc.getQueryString(ph.endPage+1)}'/>">&gt;</a>
            </c:if>
        </c:if>
        </div>
    </div>
</div>
</body>
</html>