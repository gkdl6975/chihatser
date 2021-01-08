<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%String id = (String)session.getAttribute("id");
int num=Integer.parseInt(request.getParameter("num"));
if (id==null){
	// 세션값 없으면 login , join
	%>
	<form>
<table id="notice">
<tr><td>작성자</td><td><input type="text" name="name" value="로그인이 필요합니다." readonly></td></tr>
<tr><td>내용</td>
    <td><textarea name="content" rows="5" cols="50" ></textarea></td></tr>
</table>
</form>
<%

}else{
//	세션값있으면 ...님 로그ㅇ인 메세지 뿌려주시고 logout 회원정보수정
%>
<form action="commentsPro.jsp" method="post" enctype="post">
<input type="hidden" name="num" value="<%=num%>">
<table id="notice">
<tr><td>작성자</td><td><input type="text" name="name" value="<%=id%>" readonly></td></tr>
<tr><td>내용</td>
    <td><textarea name="content" rows="5" cols="50"></textarea></td></tr>
</table>
<div id="table_search">
<input type="submit" value="댓글달기" class="btn">
</div>
</form>
<%
}
%>
</body>
</html>