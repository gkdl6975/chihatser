<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/subpage.css" rel="stylesheet" type="text/css">
<!--[if lt IE 9]>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/IE9.js" type="text/javascript"></script>
<script src="http://ie7-js.googlecode.com/svn/version/2.1(beta4)/ie7-squish.js" type="text/javascript"></script>
<script src="http://html5shim.googlecode.com/svn/trunk/html5.js" type="text/javascript"></script>
<![endif]-->
<!--[if IE 6]>
 <script src="../script/DD_belatedPNG_0.0.8a.js"></script>
 <script>
   /* EXAMPLE */
   DD_belatedPNG.fix('#wrap');
   DD_belatedPNG.fix('#main_img');   

 </script>
 <![endif]-->
 <script type="text/javascript">
 	function dupCheck() {
		// id상자 비어있으면 체크
		if(document.fr.id.value==""){
			alert("아이디 입력하세요");
			document.fr.id.focus();
			return;
		}
		// 창을 열어서 id들고 가기
		var wid=document.fr.id.value;
		window.open("dupCheck.jsp?wid="+wid,"","width=400,height=300");
	}
 </script>
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 본문메인이미지 -->
<div id="sub_img_member"></div>
<!-- 본문메인이미지 -->
<!-- 왼쪽메뉴 -->
<!-- 왼쪽메뉴 -->
<!-- 본문내용 -->
<article>
<form action="joinPro.jsp" id="join" method="post" name="fr">
<fieldset>
<legend>기본 정보</legend>
<label>아이디</label>
<input type="text" name="id" class="id">
<input type="button" value="중복확인" class="dup" onclick="dupCheck()"><br>
<label>비밀번호</label>
<input type="password" name="pass"><br>
<label>비밀번호 확인</label>
<input type="password" name="pass2"><br>
<label>이름</label>
<input type="text" name="name"><br>
<label>E-Mail</label>
<input type="text" name="email"> <jsp:include page="email.jsp"/><br>
<!-- <label>E-Mail 확인</label> -->
<!-- <input type="email" name="email2"> -->
<br>
</fieldset>

<fieldset>
<legend>추가 정보</legend>
<label>주소</label>
<jsp:include page="map.jsp" /><br>
<label>휴대전화</label>
<input type="text" name="phone"><br>
</fieldset>
<div class="clear"></div>
<div id="buttons" align="center">
<input type="submit" value="가입" class="submit">
<input type="reset" value="취소" class="cancel">
</div>
</form>
</article>
<!-- 본문내용 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>