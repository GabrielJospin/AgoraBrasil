<%@ page import="Config.Links" %>
<%@ page import="Config.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %><%--
  Created by IntelliJ IDEA.
  User: gabij
  Date: 27/07/2020
  Time: 15:39
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String mypage = Links.MYPAGEADMIN;
    String nomeUsuario = (String) session.getAttribute("Nome do usuário");
    boolean logado = (nomeUsuario != null);
    String nivel = (String) session.getAttribute("Nivel");
    if(! nivel.equals("Admin"))response.sendRedirect("index.jsp");


    ///////// FAZER BUSCA ??????
%>
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
        <div name = "ajax">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        </div>
    </div>
    <title>My Page</title>
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
        <%
            if (!logado) {
                out.print("<a class=\"btn btn-outline-info my-2 my-sm-0\" type=\"button\" href=\"" + Links.LOGIN + "\">Log In\n" + "</a>\n");
            } else {
                out.print("<button class=\"btn btn - outline - info my - 2my - sm - 0\" type=\"button\" href=\"" + mypage + "\">My Page\n" + "</button>\n" + nomeUsuario + "<a href='" + Links.LOGOUT + "'><svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-box-arrow-right\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n" +
                        "  <path fill-rule=\"evenodd\" d=\"M11.646 11.354a.5.5 0 0 1 0-.708L14.293 8l-2.647-2.646a.5.5 0 0 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0z\"/>\n" +
                        "  <path fill-rule=\"evenodd\" d=\"M4.5 8a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5z\"/>\n" +
                        "  <path fill-rule=\"evenodd\" d=\"M2 13.5A1.5 1.5 0 0 1 .5 12V4A1.5 1.5 0 0 1 2 2.5h7A1.5 1.5 0 0 1 10.5 4v1.5a.5.5 0 0 1-1 0V4a.5.5 0 0 0-.5-.5H2a.5.5 0 0 0-.5.5v8a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5v-1.5a.5.5 0 0 1 1 0V12A1.5 1.5 0 0 1 9 13.5H2z\"/>\n" +
                        "</svg></a>");
            }
        %>


    </div>
</nav>

<div class="container">
    <div class="container mt-4">
        <!-- Search-->
        <form class="form-inline ml-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" id="txtSearch" name="txtSearch" placeholder="Search" aria-label="Search">
            <button class="btn btn-info my-sm-0" type="submit" id="btn-search">Search</button>
        </form>
        <!-- Cards -->
        <div id="listar"></div>
    </div>
</div>

<div class="modal fade" id="modal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit User</h5>

                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form id="CadastroForm" method="post">
                    <select class="form-control" name="txtNivel">
                        <option>Admin</option>
                        <option>Master</option>
                        <option>Columnist</option>
                        <option>Writer</option>
                        <option>Reader</option>
                    </select>

                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                        <button type="submit" class="btn btn-primary" name="editNivel">Edit Nivel
                        </button>
                    </div>
                </form>
            </div>
        </div>
    </div>
</div>

<%
    if (request.getParameter("editNivel") != null) {
        String id = request.getParameter("id");
        String userNivel = request.getParameter("txtNivel");
        try {
            Connection con = Conexao.conectar();
            Statement st = con.createStatement();
            st.executeUpdate("UPDATE users SET nivel = '" + userNivel + "' where id ='" + id + "'");
            response.sendRedirect(mypage);
        } catch (Exception e) {
            out.print(e);
        }
    }
%>


<%
    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("edit")) {
        out.print("<script>$('#modal').modal('show'); </script>");
    }
%>

<%
    if (request.getParameter("funcao") != null && request.getParameter("funcao").equals("delete")) {
        out.print("<script>alert('Are you sure?') </script>");
        try {
            String id = request.getParameter("id");
            Connection con = Conexao.conectar();
            Statement st = con.createStatement();
            st.executeUpdate("DELETE FROM users where id =  '" + id + "'");
            response.sendRedirect(mypage);
        } catch (Exception e) {
            out.print(e + "\n");
        }
    }
%>


<!-- Ajax para listar -->
<script type="text/javascript">
    $(document).ready(function () {
        $.ajax({
            url: "ajax/listarAdmin.jsp",
            method: "post",
            data: $('form').serialize(),
            dataType: "html",
            success: function (result) {
                $('#listar').html(result);
            }
        })
    })

</script>


<!-- Ajax para buscar pelo botão -->
<script type="text/javascript">
    $(document).ready(function () {
        $('#btn-search').click(function (event) {
            event.preventDefault();
            $.ajax({
                url: "ajax/listarAdmin.jsp",
                method: "post",
                data: $('form').serialize(),
                dataType: "html",
                success: function (result) {
                    $('#listar').html(result);
                }
            })

        })
    })
</script>

<!-- Ajax para buscar pelo botão -->
<script type="text/javascript">
    $(document).ready(function () {
        $('#txtSearch').keyup(function () {
            $('#btn-search').click();
        })
    })
</script>

</body>
</html>
