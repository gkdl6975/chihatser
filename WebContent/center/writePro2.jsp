<%@page import="board.BoardDAO2"%>
<%@page import="board.BoardDAO"%>
<%@page import="board.BoardBean"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- center/writePro.jsp -->
<%
// 한글처리
request.setCharacterEncoding("utf-8");
// 파라미터 가져오기
// name, pass, subject, content 파라미터 가져오기
String name=request.getParameter("name");
String pass=request.getParameter("pass");
String subject=request.getParameter("subject");
String content=request.getParameter("content");
// int readcount = 0 //조회수
int readcount = 0;
// 글쓴날짜 <= 현시스템에 날짜시간을 가져오기
Timestamp date=new Timestamp(System.currentTimeMillis());

// 패키지  board 파일이름 BoardBean
// 멤버변수  set() get() 
// BoardBean bb 객체생성
BoardBean bb=new BoardBean();
// bb 멤버변수  set메서드호출 <= 파라미터
bb.setName(name);
bb.setPass(pass);
bb.setSubject(subject);
bb.setContent(content);
bb.setReadcount(readcount);
bb.setDate(date);

// 패키지 board 파일이름 BoardDAO
// 리턴값없음 insertBoard(bb) 메서드 만들기
// BoardDAO bdao 객체생성
BoardDAO2 bdao=new BoardDAO2();
// bdao   insertBoard(bb) 메서드 호출
bdao.insertBoard(bb);
//notice.jsp 이동 
response.sendRedirect("notice2.jsp");
%>
</body>
</html>






