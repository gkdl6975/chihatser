<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="board.BoardDAO3"%>
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
String uploadPath=request.getRealPath("/upload");
System.out.println(uploadPath);
// 파라미터 가져오기
int maxSize=10*1024*1024;
MultipartRequest multi=new MultipartRequest(request,uploadPath,maxSize,"utf-8",new DefaultFileRenamePolicy());

// name, pass, subject, content 파라미터 가져오기
String name=multi.getParameter("name");
String pass=multi.getParameter("pass");
String subject=multi.getParameter("subject");
String content=multi.getParameter("content");
String file=multi.getFilesystemName("file");
// int readcount = 0 //조회수
int readcount = 0;
// 글쓴날짜 <= 현시스템에 날짜시간을 가져오기
Timestamp date=new Timestamp(System.currentTimeMillis());
int num=Integer.parseInt(multi.getParameter("num"));
int re_ref=Integer.parseInt(multi.getParameter("re_ref"));
int re_lev=Integer.parseInt(multi.getParameter("re_lev"));
int re_seq=Integer.parseInt(multi.getParameter("re_seq"));

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
bb.setFile(file);
bb.setNum(num);
bb.setRe_ref(re_ref);
bb.setRe_lev(re_lev);
bb.setRe_seq(re_seq);

// 패키지 board 파일이름 BoardDAO
// 리턴값없음 insertBoard(bb) 메서드 만들기
// BoardDAO bdao 객체생성
BoardDAO3 bdao=new BoardDAO3();
// bdao   insertBoard(bb) 메서드 호출
bdao.reInsertBoard(bb);
//notice.jsp 이동 
response.sendRedirect("notice3.jsp");
%>
</body>
</html>






