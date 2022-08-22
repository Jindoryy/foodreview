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