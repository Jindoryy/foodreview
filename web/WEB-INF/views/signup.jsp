<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 위 3개의 메타 태그는 *반드시* head 태그의 처음에 와야합니다; 어떤 다른 콘텐츠들은 반드시 이 태그들 *다음에* 와야 합니다 -->
    <title>회원가입</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>

    <!-- 부트스트랩 -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">

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
    </style>

    <script type="text/javascript">

        /** 모든 공백 체크 정규식
         * 입력 사항에 빈칸이 없도록 한다. */
        var empV = /\s/g;

        /** 아이디 정규식
         * 소문자, 숫자로만 구성된 4~12자리 문자열*/
        var idV = /^[a-z0-9]{4,12}$/;

        /** 비밀번호 정규식
         * 숫자, 영문, 특수문자 각 1자리 이상 ( 그외 글자 X ) 8~16자리 */
        var pwV = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+])(?!.*[^a-zA-z0-9$`~!@$!%*#^?&\\(\\)\-_=+]).{8,16}$/;

        /** email 정규식 */
        var emailV = /(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))/;

        /** 닉네임 정규식
         * 한글초성, 한글, 영문, 숫자만을 사용가능한 2~16자리 */
        var nicknameV = /^(?=.*[a-z0-9가-힣ㄱ-ㅎ])[a-z0-9가-힣ㄱ-ㅎ]{2,16}$/;



        $(document).ready(function () {

            // 여기서부터
            $("#accountID").blur(function () {
                if($('#accountID').val()=='') {
                    console.log("아이디 검사 1");
                    $('#id_check').text('아이디를 입력하세요.');
                    $('#id_check').css('color', 'red');

                } else if(idV.test($('#accountID').val()) != true) {
                    console.log("아이디 검사 2");
                    $('#id_check').text('4~12자의 영문 소문자, 숫자만 사용 가능합니다.');
                    $('#id_check').css('color', 'red');

                } else if ($('#accountID').val()!='') {
                    console.log("아이디 중복 검사 실행");

                    let cid = $('#accountID').val();


                    $.ajax({
                        async : true,
                        type : 'GET',
                        url : '${pageContext.request.contextPath}/idCheck?accountId='+cid,
                        dataType : 'json',
                        contentType : "application/json; charset=UTF-8",
                        success : function (cnt) {
                            console.log("ajax 리턴값: "+cnt);
                            if(cnt > 0) {
                                $('#id_check').text('중복된 아이디 입니다.');
                                $('#id_check').css('color', 'red');
                                $("#usercheck").attr("disabled", true);
                            } else {
                                $('#id_check').text('사용가능한 아이디 입니다.');
                                $('#id_check').css('color', 'blue');
                                $("#usercheck").attr("disabled", false);
                            }

                        }
                    });
                }
            });

            //테스트 주석 시 여기에

            $('form').on('submit', function () {
                var inval_Ary = new Array(4).fill(false);

                if (idV.test($('#accountID').val())) {
                    inval_Ary[0] = true;
                } else {
                    inval_Ary[0] = false;
                    alert('아이디를 확인하세요.');
                    return false;
                }

                if (($('#accountPassword').val() == ($('#pw_2').val())) && pwV.test($('#accountPassword').val())) {
                    inval_Ary[1] = true;
                } else {
                    inval_Ary[1] = false;
                    alert('비밀번호를 확인하세요.');
                    return false;
                }

                if (emailV.test($('#accountEmail').val())) {
                    inval_Ary[2] = true;
                } else {
                    inval_Ary[2] = false;
                    alert('이메일을 확인하세요.');
                    return false;
                }

                if (nicknameV.test($('#accountNickname').val())) {
                    inval_Ary[3] = true;
                } else {
                    inval_Ary[3] = false;
                    alert('닉네임을을 확인하세요.');
                    return false;
                }

                var validAll = true;
                for(var i = 0; i < inval_Ary.length; i++) {
                    if(inval_Arr[i] == false){
                        validAll = false;
                    }
                }
                if(validAll == true) {
                    console.log("valid 값: "+validAll);
                    printf("valid 값: "+validAll);
                    return alert('회원가입을 성공적으로 완료했습니다.');
                } else {
                    console.log("valid 값: "+validAll);
                    printf("valid 값: "+validAll);
                    alert('정보를 다시 확인하세요.');
                    return false;
                }
            });

            //테스트 용도
            /*
            $('#accountID').blur(function() {
                if (idV.test($('#accountID').val())) {
                    console.log('true');
                    $('#id_check').text('');
                } else {
                    console.log('false');
                    $('#id_check').text('소문자, 숫자로만 구성된 4~12자리로만 가능합니다.');
                    $('#id_check').css('color', 'red');
                }
            });

             */

            $('#accountPassword').blur(function() {
                if (pwV.test($('#accountPassword').val())) {
                    console.log('true');
                    $('#pw_check').text('');
                } else {
                    console.log('false');
                    $('#pw_check').text('숫자, 영문, 특수문자 각 1자리 이상 ( 그외 글자 X ) 8~16자리');
                    $('#pw_check').css('color', 'red');
                }
            });

            //1~2 패스워드 일치 확인
            $('#pw_2').blur(function() {
                if ($('#accountPassword').val() != $(this).val()) {
                    $('#pw2_check').text('비밀번호가 일치하지 않습니다.');
                    $('#pw2_check').css('color', 'red');
                } else {
                    $('#pw2_check').text('');
                }
            });

            //이름에 특수문자 들어가지 않도록 설정
            $("#accountNickname").blur(function() {
                if($('#accountNickname').val()=='') {
                    console.log("닉네임 검사 1");
                    $('#name_check').text('닉네임을 입력하세요.');
                    $('#name_check').css('color', 'red');
                } else if (nicknameV.test($('#accountNickname').val()) != true) {
                    console.log("닉네임 검사 2");
                    $('#name_check').text('한글초성, 한글, 영문, 숫자만이 사용가능합니다. (2~16자리)');
                    $('#name_check').css('color', 'red');
                } else if ($('#accountNickname').val()!='') {

                    console.log("닉네임 중복 검사 실행");

                    let cnn = $('#accountNickname').val();


                    $.ajax({
                        async : true,
                        type : 'GET',
                        url : '${pageContext.request.contextPath}/nicknameCheck?accountNickname='+cnn,
                        dataType : 'json',
                        contentType : "application/json; charset=UTF-8",
                        success : function (cnt) {
                            console.log("ajax 리턴값: "+cnt);
                            if(cnt > 0) {
                                $('#name_check').text('중복된 닉네임 입니다.');
                                $('#name_check').css('color', 'red');
                                $("#usercheck").attr("disabled", true);
                            } else {
                                $('#name_check').text('사용가능한 닉네임 입니다.');
                                $('#name_check').css('color', 'blue');
                                $("#usercheck").attr("disabled", false);
                            }

                        }
                    });
                }
            });
            $("#accountEmail").blur(function() {
                if (emailV.test($(this).val())) {
                    $("#email_check").text('');
                } else {
                    $('#email_check').text('이메일 양식을 확인해주세요.');
                    $('#email_check').css('color', 'red');
                }
            });

        });

    </script>

</head>
<body>

<div id="menu">
    <ul style="background-color: #5F5F5F; display:flex;" >
        <li id="logo">REVIEW</li>
        <li><a href="<c:url value='/'/>">홈</a></li>
        <li><a href="<c:url value='/login'/>">로그인</a></li>
    </ul>
</div>
<br>
<br>
<div class="container">
    <div class="col-lg-4"></div>
    <div class="col-lg-4">
        <div class="jumbotron" style="padding-top: 20px;">
            <form method="post" action="/signup">
                <h3 style="text-align: center;">회원가입</h3>
                <div class="form-group">
                    <label for="accountID">아이디</label>
                    <input type="text" class="form-control" placeholder="아이디" id="accountID" name="id" maxlength="20">
                    <div class="check_font" id="id_check"></div>
                </div>
                <div class="form-group">
                    <label for="accountPassword">비밀번호</label>
                    <input type="password" class="form-control" placeholder="비밀번호" id="accountPassword" name="password" maxlength="20">
                    <div class="check_font" id="pw_check"></div>
                </div>
                <div class="form-group">
                    <label for="accountPassword">비밀번호 확인</label>
                    <input type="password" class="form-control" placeholder="비밀번호 확인" id="pw_2" name="pw_2" maxlength="20">
                    <div class="check_font" id="pw2_check"></div>
                </div>
                <div class="form-group">
                    <label for="accountEmail">이메일</label>
                    <input type="text" class="form-control" placeholder="이메일" id="accountEmail" name="email" maxlength="20">
                    <div class="check_font" id="email_check"></div>
                </div>
                <div class="form-group">
                    <label for="accountNickname">닉네임</label>
                    <input type="text" class="form-control" placeholder="닉네임" id="accountNickname" name="nickname" maxlength="20">
                    <div class="check_font" id="name_check"></div>
                </div>
                <div class="form-group">
                    <label for="accountRegion">지역 선택</label>
                    <select class="form-control" id="accountRegion" name="region">
                        <option value="서울" selected>서울</option>
                        <option value="부산">부산</option>
                        <option value="대구">대구</option>
                        <option value="인천">인천</option>
                        <option value="광주">광주</option>
                        <option value="대전">대전</option>
                        <option value="울산">울산</option>
                        <option value="세종">세종</option>
                        <option value="경기">경기</option>
                        <option value="강원">강원</option>
                        <option value="충북">충북</option>
                        <option value="충남">충남</option>
                        <option value="전북">전북</option>
                        <option value="전남">전남</option>
                        <option value="경북">경북</option>
                        <option value="경남">경남</option>
                        <option value="제주">제주</option>
                    </select>
                </div>
                <input type="submit" class="btn btn-primary form-control" id="usercheck" value="회원가입">
            </form>
        </div>
    </div>

</div>
<!-- jQuery (부트스트랩의 자바스크립트 플러그인을 위해 필요합니다) -->
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- 모든 컴파일된 플러그인을 포함합니다 (아래), 원하지 않는다면 필요한 각각의 파일을 포함하세요 -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
</body>
</html>
