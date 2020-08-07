<%@ page import="Config.Links" %><%
    session.invalidate();
    response.sendRedirect(Links.HOME);
%>
