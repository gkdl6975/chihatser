<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<header>
<%
	// String id = (String) 세션값 가져오기
	String id = (String)session.getAttribute("id");
	if (id==null){
		// 세션값 없으면 login , join
		%>
<div id="login"><a href="../member/login.jsp">login</a> | <a href="../member/join.jsp">join</a></div>
<div class="clear"></div>
<%

	}else{
	//	세션값있으면 ...님 로그ㅇ인 메세지 뿌려주시고 logout 회원정보수정
	%>
	<div id="login"><%=id %>님로그인 하셨습니다. | <a href="../member/logout.jsp">logout</a> | <a href="../member/updateForm.jsp">회원정보수정</a></div>
	<div class="clear"></div>
	<%
	}


%>
<!-- 로고들어가는 곳 -->
<div id="logo"><a href="../main/main.jsp"><img src="../images/main22.PNG" width="300" height="150" alt="Fun Web"></a></div>
<!-- 로고들어가는 곳 -->
<nav id="top_menu">
<ul>
	<li><a href="../center/notice.jsp">채용 공고</a></li>
	<li><a href="../center/notice2.jsp">합격 수기</a></li>
	<li><a href="../center/notice3.jsp">소설 첨삭</a></li>
	<li><a href="../center/notice4.jsp">쉼터</a></li>
</ul>
</nav>
</header>
<body>
<body background="../images/gg_.jpg">
</body>