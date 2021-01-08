<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자바 메일 보내기 폼</title>
<style>
	table{
		width : 450px;
		margin : auto;
	}
	h1{
		text-align: center;
	}
	td{
		border : 1px dotted gray;
		}
</style>
</head>
<body>
<form action="../mailSend" method="post">
<h1>문의 메일 보내기</h1>
<table>
	<tr><td>보내는 사람 메일 : </td><td><input type="text" name="sender" value="gkdl5559@gmail.com" ></td></tr>
	<tr><td>받는 사람 메일 : </td><td><input type="text" name="receiver"></td></tr>
	<tr><td>제목 : </td><td><input type="text" name="subject"></td></tr>
	<tr><td>내용 : </td><td><textarea rows="20" cols="40" name="content"></textarea></td></tr>
	<tr><td align=center colspan=2><input type="submit" value="보내기"></td></tr>
</table>
</form>

</body>
</html>