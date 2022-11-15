<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>
    <link href="/css/topbar.css" rel="stylesheet">

    <style>

        @font-face {
            font-family: 'KyoboHand';
            src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_20-04@1.0/KyoboHand.woff') format('woff');
            font-weight: bold;
            font-style: normal;
        }
        body{
            background-image: url("https://img.freepik.com/free-photo/white-crumpled-paper-texture-for-background_1373-159.jpg");
            background-repeat: no-repeat;
            background-size: cover;
            overflow: visible;
            font-family: KyoboHand;
        }
        .write-container {
            width: 50%;
            margin: 200px auto 150px;
            font-size: 1.2em;
        }

        .fileDrop {
            width: 600px;
            height: 200px;
            border: 1px dashed gray;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 1.5em;
        }

        .uploaded-list {
            display: flex;
        }

        .img-sizing {
            display: block;
            width: 100px;
            height: 100px;
        }

    </style>
    <!-- bootstrap css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- bootstrap js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" defer></script>
    <!-- custom css -->
    <link rel="stylesheet" href="/css/main-write.css">
    <link rel="stylesheet" href="/css/custom-write.css">

    <link href="/css/topbar.css" rel="stylesheet">

</head>

<body>
<%@include file="../topbar.jsp"%>
<div class="wrap custom-wrap">
<%--    <%@ include file="../include/header.jsp" %>--%>

    <div class="write-container custom-container">


        <form id="write-form" class="custom-write" action="/diary/write" method="post" autocomplete="off" enctype="multipart/form-data">


            <div>
                <h1 class="today-diary">(작성자)의 일기</h1>
            </div>


            <div class="mb-3 custom-emotion">
                <select name="emotion" id="emotion-input">
                    <option value="">${d.emotion}</option>
                </select>
            </div>

            <div class="mb-3">
                <select name="diaryShow" id="show-input">
                    <option value="">${d.diaryShow}</option>
                </select>
            </div>
            <div class="mb-3">
                <textarea name="diaryContent" class="form-control" id="exampleFormControlTextarea1" rows="10" readonly>${d.diaryContent}</textarea>
            </div>



            <div class="d-grid gap-2 btn-list">
                <button id="to-list" class="btn btn-warning custom-button" type="button">목록</button>
                <button id="btn-update" class="btn btn-warning custom-button" type="button">수정</button>
                <button id="btn-delete" class="btn btn-warning custom-button" type="button">삭제</button>
            </div>

        </form>

    </div>

<%--    <%@ include file="../include/footer.jsp" %>--%>



</div>


<script>
/*
    // 게시물 등록 입력값 검증 함수
    function validateFormValue() {
        // 이름입력태그, 제목 입력태그

        const $emotionInput = document.getElementById('emotion-input');
        let flag = false; // 입력 제대로하면 true로 변경


        console.log('t: ', $emotionInput.value);

        if ($emotionInput.value.trim() === '') {
            alert('감정은 필수값입니다~');
        } else {
            flag = true;
        }

        console.log('flag:', flag);

        return flag;

    }
*/
    // 게시물 입력값 검증
    // const $regBtn = document.getElementById('reg-btn');
    //
    // $regBtn.onclick = e => {
    //     // 필수 입력값을 잘 채웠으면 폼을 서브밋한다.
    //     const $form = document.getElementById('write-form');
    //     $form.submit();
    // };


    //목록버튼 이벤트
    const $toList = document.getElementById('to-list');
    $toList.onclick = e => {
        location.href = '/diary/list';
    };

    // 수정
    const $update = document.getElementById('btn-update');

    if($update !== null) {

        $update.onclick = e => {


            location.href = '/diary/modify?diaryNo=${d.diaryNo}';
        };
    }

    // 삭제
    const $delete = document.getElementById('btn-delete');
    $delete.onclick = e => {
        if(!confirm('일기를 지울까요? 정말..? 추억인데....')) {
            return;
        }
        location.href = '/diary/delete?diaryNo=${diaryNo}';
    };


</script>





</body>

</html>