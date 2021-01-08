<%@page import="member.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
	function idok() {
		// join.jsp id상자 value  <= dupCheck.jsp 찾은 아이디
		opener.fr.id.value=document.wfr.wid.value;
		// 창닫기
		window.close();
	}
</script>
</head>
<body>
<%
// member/dupCheck.jsp

// "dupCheck.jsp?wid="+wid
//  wid 파라미터 가져오기
String wid=request.getParameter("wid");
// MemberDAO mdao 객체생성
MemberDAO mdao=new MemberDAO();
// int check = dupCheck(wid)
int check=mdao.dupCheck(wid);
// check==1  "아이디 중복"
// check==0  "아이디 사용가능"
if(check==1){
	out.println("아이디 중복");
}else{
	out.println("아이디 사용가능");
	%><input type="button" value="아이디사용" onclick="idok()"><%
}
%>
<form action="dupCheck.jsp" method="post" name="wfr">
아이디 : <input type="text" name="wid" value="<%=wid%>">
<input type="submit" value="아이디 중복체크">
</form>
</body>
</html>






