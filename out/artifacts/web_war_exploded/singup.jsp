<%@ page import="Config.Links" %>
<%@ page import="Config.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: gabij
  Date: 27/07/2020
  Time: 14:25
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <div name="Script">
        <link href="css/Style.css" rel="stylesheet">
        <div name="Bootstrap">
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
                    integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
                    crossorigin="anonymous"></script>
            <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
                    integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
                    crossorigin="anonymous"></script>
            <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"
                    integrity="sha384-OgVRvuATP1z7JjHLkuOU7Xw704+h835Lr+6QL9UvYjZE3Ipu6Tp75j7Bh/kR0JKI"
                    crossorigin="anonymous"></script>
            <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css"
                  integrity="sha384-9aIt2nRpC12Uk9gS9baDl411NQApFmC26EwAOH8WgZl5MYYxFfc+NcPb1dKGj7Sk"
                  crossorigin="anonymous">
        </div>
    </div>
    <title>Sing Up</title>
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <a class="navbar-brand" href="<%=Links.HOME%>">Ágora Política</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="<%=Links.SOBRE%>">Sobre</a>
            </li>
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="<%=Links.POSTS%>>" id="navbarDropdown" role="button"
                   data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    Posts
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="<%=Links.EDIT%>">Editoriais</a>
                    <a class="dropdown-item" href="<%=Links.EDU%>">Educação</a>
                    <a class="dropdown-item" href="<%=Links.BRA%>">Direto de Brasilia</a>
                    <a class="dropdown-item" href="<%=Links.SP%>">Direto de São Paulo</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="<%=Links.CATE%>">Principais Tags</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="<%=Links.FALECONOSCO%>" tabindex="-1" aria-disabled="true">Fale
                    Conosco</a>
            </li>
        </ul>
    </div>
</nav>

<div class="container">
    <div class="fundoRegister">
        <form method="post">
            <div class="form-group">
                <label for="name1">Name</label>
                <input type="text" name="txtName" class="form-control" id="name1" aria-describedby="emailHelp" required>
            </div>

            <div class="form-group">
                <label for="exampleInputEmail1">Email</label>
                <input type="email" name="txtEmail" class="form-control" id="exampleInputEmail1" aria-describedby="emailHelp" required>
                <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
            </div>
            <div class="form-group">
                <label for="exampleInputPassword1">Password</label>
                <input type="password"  name="txtPass" class="form-control" id="exampleInputPassword1" required>
            </div>
            <div class="form-group">
                <label for="exampleInputPassword1">Repeat your Password</label>
                <input type="password"  name="txtRepass" class="form-control" id="exampleInputPassword2" required>
            </div>
            <a class="btn btn-outline-info my-2 my-sm-0" type="button" href="<%=Links.LOGIN%>">Sing In</a>
            <button type="submit" name="btn-login" class="btn btn-outline-info my-2 my-sm-0 registerButton">Sing Up</button>
        </form>
    </div>
</div>
<%
    if (request.getParameter("btn-login") != null) {

        String user = request.getParameter("txtEmail");
        String name = request.getParameter("txtName");
        String pass = request.getParameter("txtPass");
        String rePass = request.getParameter("txtRepass");

        if(user.isEmpty() || name.isEmpty() || pass.isEmpty() || rePass.isEmpty()){
            out.print("<script> alert( 'internal error, try again'); </script>");
        }


        try {
            Connection con = Conexao.conectar();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM users where User =  '" + user + "'");
            while (rs.next()) {
                rs.getRow();
                if (rs.getRow() > 0) {
                    out.print("<script> alert( 'user already Register'); </script>");
                    return;
                }
                if(! pass.equals(rePass)){
                    out.print("<script> alert( 'Wrong Password'); </script>");
                    return;
                }
            }
            st.executeUpdate("insert into users (Name, User, Password, Nivel) values (  '" + name + "' , '" + user + "' , '" + pass + "' , 'Reader' )");
            session.setAttribute("Nome do usuário", name);
            session.setAttribute("Nivel", "Reader");
            response.sendRedirect("index.jsp");
        } catch (Exception e) {
            out.print(e + "\n");
            out.print("<script>alert('"+e+"'); </script>");
        }
    }

%>
</body>
</html>

