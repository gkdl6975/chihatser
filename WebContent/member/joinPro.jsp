<%@page import="member.MemberDAO"%>
<%@page import="java.sql.Timestamp"%>
<%@page import="member.MemberBean"%>
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
	// member/joinPro.jsp
	// 한글처리
	request.setCharacterEncoding("utf-8");
	// 파라미터값 가져오기 id, pass, name, email, address, phone, mobile 파라미터 가져오기
	String id = request.getParameter("id");
	String pass = request.getParameter("pass");
	String name = request.getParameter("name");
	String email = request.getParameter("email");
	String email2 = request.getParameter("email2");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	String address4 = request.getParameter("address4");
	String address5 = request.getParameter("address5");
	String phone = request.getParameter("phone");
	Timestamp date=new Timestamp(System.currentTimeMillis());
	// 패키지 member 파일이름 memberBean
	MemberBean mb = new MemberBean();
	//  id, pass, name, email, address, phone, mobile 멤버변수 정의 set get
	mb.setId(id);
	mb.setPass(pass);
	mb.setName(name);
	mb.setEmail(email+email2);
	mb.setAddress1(address1);
	mb.setAddress2(address2);
	mb.setAddress3(address3);
	mb.setAddress4(address4);
	mb.setAddress5(address5);
	mb.setPhone(phone);
	
	// memberDAO객체생성
	MemberDAO mdao = new MemberDAO();
	// insertMember(mb)
	mdao.insertMember(mb);
	// login페이지로 이동
%>
<script type="text/javascript">
	alert("회원가입성공");
	location.href="login.jsp";
</script>
</body>
</html>