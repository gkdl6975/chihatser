<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<footer>
	<hr>
	<div id="copy">
		
	</div>
	<div id="social">
	<%String id = (String)session.getAttribute("id");
	if(id != null){
	if (id.equals("park")) { %>
	<a href="../mail/mailForm.jsp" target="_blank">
	<img src="../images/mail.PNG" width=35 height="35"alt="Mail">
	</a><%} }%>
		<img src="../images/facebook.gif" width="33" height="33"alt="Facebook">
		 <img src="../images/twitter.gif" width="34"height="34" alt="Twitter">
	</div>
</footer>