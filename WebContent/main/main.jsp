<%@page import="board.BoardDAO3"%>
<%@page import="board.BoardBean"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardDAO2"%>
<%@page import="java.util.List"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="../css/default.css" rel="stylesheet" type="text/css">
<link href="../css/front.css" rel="stylesheet" type="text/css">

 
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


</head>
<body>

<div id="wrap">
<!-- 헤더파일들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더파일들어가는 곳 -->
<!-- 메인이미지 들어가는곳 -->
<div class="clear"></div>
<div id="main_img"><jsp:include page="../center/slides2.jsp"/></div>
<!-- 메인이미지 들어가는곳 -->
<!-- 메인 콘텐츠 들어가는 곳 -->
<article id="front">
<p class="tsh03">추천정보</p>
<div id="solution">
<div id="hosting" >
<p><a href="https://www.careertalk.kr/" target="_blank"><img src="../images/class1.png" width="400" height="200"></a></p>
</div>
<div id="security">
<p><a href = "https://www.youtube.com/channel/UCMoiE31oWSWDGljWqCEFOcg?sub_confirmation=1" target="_blank">
<img src="../images/class2.png" width="400" height="200"></a></p>
</div>
<div id="payment">
<p><a href="https://www.itwillbs.co.kr/" target="_blank"><img src="../images/class3.png" width="400" height="200"></a></p>
</div>
</div>
<div class="clear"></div>
<div id="sec_news">
<h3><span class="orange">인기</span> 채용공고</h3>
<table>
<%
//BoardDAO bdao 객체생성
BoardDAO bdao=new BoardDAO();
int pageSize=5;
int startRow=1;
//List boardList   = getBoardList(startRow,pageSize) 메서드 만들 호출
List boardList=bdao.getBoardList2(startRow, pageSize);
// 날짜 => 원하는 모양을 변경 문자열 결과값
for(int i = 0; i<boardList.size();i++){
	BoardBean bb=(BoardBean)boardList.get(i);
	%>
	<tr><td class="contxt"><a href="../center/content.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
    <td> 조회수 : <%=bb.getReadcount() %></td></tr>
	<%
}
%>
</table>
</div>
<div id="news_notice">
<h3 class="brown">합격 수기</h3>
<table>
<%
//BoardDAO bdao 객체생성
BoardDAO2 bdao2=new BoardDAO2();
// int pageSize=5;
// int startRow=1;
//List boardList   = getBoardList(startRow,pageSize) 메서드 만들 호출
List boardList2=bdao2.getBoardList(startRow, pageSize);
// 날짜 => 원하는 모양을 변경 문자열 결과값
SimpleDateFormat sdf2=new SimpleDateFormat("yy.MM.dd");
for(int i = 0; i<boardList2.size();i++){
	BoardBean bb=(BoardBean)boardList2.get(i);
	%>
	<tr><td class="contxt"><a href="../center/content2.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
    <td><%=sdf2.format(bb.getDate()) %></td></tr>
	<%
}
%>
</table>
</div>
<div id="news_notice2">
<h3 class="brown">자소설 첨삭</h3>
<table>
<%
//BoardDAO bdao 객체생성
BoardDAO3 bdao3=new BoardDAO3();
// int pageSize3=5;
// int startRow3=1;
//List boardList   = getBoardList(startRow,pageSize) 메서드 만들 호출
List boardList3=bdao3.getBoardList(startRow, pageSize);
// 날짜 => 원하는 모양을 변경 문자열 결과값
SimpleDateFormat sdf3=new SimpleDateFormat("yy.MM.dd");
for(int i = 0; i<boardList3.size();i++){
	BoardBean bb=(BoardBean)boardList3.get(i);
	%>
	<tr><td class="contxt"><a href="../center/content2.jsp?num=<%=bb.getNum()%>"><%=bb.getSubject() %></a></td>
    <td><%=sdf3.format(bb.getDate()) %></td></tr>
	<%
}
%>
</table>
</div>
</article>
<!-- 메인 콘텐츠 들어가는 곳 -->
<div class="clear"></div>
<!-- 푸터 들어가는 곳 -->
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터 들어가는 곳 -->
</div>
</body>
</html>