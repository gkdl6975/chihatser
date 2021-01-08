<%@page import="board.CommentsDao"%>
<%@page import="board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
//center/deletePro.jsp
// 파라미터 가져오기  num ,pass
int num = Integer.parseInt(request.getParameter("num"));
//BoardBean bb 객체생성
BoardBean bb = new BoardBean();
//bb멤버변수 <- 파라미터 값 저장
bb.setNum(num);
// BoardDAO bdao 객체생성
CommentsDao cdao = new CommentsDao();
//  int check= numCheck(bb) 만들고 호출
BoardBean bb2 = cdao.getBoard(num);
cdao.deleteBoard(bb);
//  check==1   리턴값없음 deleteBoard(bb) 메서드만들고 호출 notice.jsp이동
//  check==0  "비밀번호틀림" 뒤로이동
//  check=-1  "num 없음" 뒤로이동
String backpage = "content4.jsp?num="+ bb2.getModual();
response.sendRedirect(backpage);
%>
</body>
</html>



