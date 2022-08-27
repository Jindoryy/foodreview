<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page session="false"%>
<c:set var="loginId" value="${pageContext.request.getSession(false)==null ? '' : pageContext.request.session.getAttribute('id')}"/>
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