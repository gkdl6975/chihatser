<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="board.CommentsDao"%>
<%@page import="board.BoardDAO4"%>
<%@page import="board.BoardDAO3"%>
<%@page import="board.BoardBean"%>
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
</head>
<body>
<div id="wrap">
<!-- 헤더들어가는 곳 -->
<jsp:include page="../inc/top.jsp"/>
<!-- 헤더들어가는 곳 -->

<!-- 본문들어가는 곳 -->
<!-- 메인이미지 -->
<div id="sub_img_center4"></div>
<!-- 메인이미지 -->

<!-- 왼쪽메뉴 -->
<jsp:include page="../inc/left.jsp"/>
<!-- 왼쪽메뉴 -->
<%
// int num  파라미터 가져오기 
int num=Integer.parseInt(request.getParameter("num"));
String id=(String)session.getAttribute("id");
// BoardDAO bdao 객체생성
BoardDAO4 bdao=new BoardDAO4();
//조회수 증가 메서드 만들고 호출
bdao.updateReadcount(num);
// 리턴할형 BoardBean bb = getBoard(num) 메서드 만들고 호출
BoardBean bb=bdao.getBoard(num);
%>
<!-- 게시판 -->
<article>
<h1>Notice Content</h1>
<table id="notice">
<tr><td>글번호</td><td><%=bb.getNum() %></td>
    <td>글쓴날짜</td><td><%=bb.getDate() %></td></tr>
<tr><td>작성자</td><td><%=bb.getName() %></td>
    <td>조회수</td><td><%=bb.getReadcount() %></td></tr>
<tr><td>제목</td><td colspan="3"><%=bb.getSubject() %></td></tr>
<tr><td>파일</td>
    <td colspan="3">
    <a href="file_down.jsp?file_name=<%=bb.getFile() %>"><%=bb.getFile() %></a></td></tr>
<tr><td>내용</td><td colspan="3"><img src="../upload/<%=bb.getFile() %>" width="500" height="auto" ><%=bb.getContent() %></td></tr>
</table>

<table id="sibal">
<%
//BoardDAO bdao 객체생성
CommentsDao bdao3=new CommentsDao();
int pageSize3=3;
int startRow3=1;
//List boardList   = getBoardList(startRow,pageSize) 메서드 만들 호출
List boardList=bdao3.getBoardList(startRow3, pageSize3,num);
// 날짜 => 원하는 모양을 변경 문자열 결과값
SimpleDateFormat sdf3=new SimpleDateFormat("yy.MM.dd");
for(int i = 0; i<boardList.size();i++){
	BoardBean bb2=(BoardBean)boardList.get(i);
	%>
	<tr><td width="100px"><%=bb2.getName() %></td><td class="contxt" width="500px"><%=bb2.getContent()%>
	<%
		if(id!=null){
	if(id.equals(bb2.getName())){
// 		String del = "deleteCommentsPro.jsp?num=" + bb2.getNum();
	%>
	<a href="deleteCommentsPro.jsp?num=<%=bb2.getNum() %>">
	<img src="../images/x.PNG" width="10px" height="10px"></a></td>
    <% }
	}%>
    <td><%=sdf3.format(bb2.getDate()) %></td></tr>
	<%
}
%>
</table>
<div class="clear"></div>
<div id="page_control">
<jsp:include page="comments.jsp"/>
</div>
</article>
<!-- 게시판 -->
<!-- 본문들어가는 곳 -->

<div class="clear"></div>
<!-- 푸터들어가는 곳 --><div id="table_search" align="center" >
<%
// 세션값 가져오기

// 세션값이 있으면 
// 세션값과  글쓴이 일치하면 글수정, 글삭제 버튼 보이기
if(id!=null){
	if(id.equals(bb.getName())){
		%>
<input type="button" value="글수정" class="btn" onclick="location.href='updateForm4.jsp?num=<%=bb.getNum()%>'">
<input type="button" value="글삭제" class="btn" onclick="location.href='deleteForm4.jsp?num=<%=bb.getNum()%>'">
		<%
	}
}
%>
<input type="button" value="글목록" class="btn" onclick="location.href='notice4.jsp'">
</div>
<jsp:include page="../inc/bottom.jsp"/>
<!-- 푸터들어가는 곳 -->
</div>
</body>
</html>