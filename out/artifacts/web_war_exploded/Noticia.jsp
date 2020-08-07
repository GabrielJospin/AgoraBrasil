<%@ page import="Config.Links" %>
<%@ page import="Config.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.util.regex.Pattern" %>
<%@ page import="java.util.regex.Matcher" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %><%--
  Created by IntelliJ IDEA.
  User: gabij
  Date: 28/07/2020
  Time: 13:50
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String mypage = "#";
    String nomeUsuario = (String) session.getAttribute("Nome do usuário");
    String nivel = (String) session.getAttribute("Nivel");
    boolean logado = (nivel != null);
    if (logado) {
        switch (nivel) {
            case "Reader":
                mypage = Links.MYPAGECOMMON;
                break;
            case "Writer":
                mypage = Links.MYPAGEWRITTER;
                break;
            case "Columnist":
                mypage = Links.MYPAGECOLUMNIST;
                break;
            case "Master":
                mypage = Links.MYPAGEMASTER;
                break;
            case "Admin":
                mypage = Links.MYPAGEADMIN;
                break;
            default:
                mypage = "#";
                break;
        }
    }


%>

<% String id = request.getParameter("id");
    String titulo = "";
    String subtitulo = "";
    String urlImagem = "";
    String corpo = "a";
    String data = "";
    String autor_id= "";
    String local = "";
    boolean verif = false;

    try {
        Connection con = Conexao.conectar();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT * FROM news Where id ='" + id + "'");
        while (rs.next()) {
            String urlNoticia = Links.NEWS + "?id=" + rs.getString(1);
            titulo = rs.getString(2);
            subtitulo = rs.getString(3);
            corpo = rs.getString(4);
            urlImagem = rs.getString(5);
            data = rs.getString(6);
            autor_id = rs.getString(7);
            local = rs.getString(8);
        }
        verif = true;
        corpo = corpo.replace("\n", "<br>");
    } catch (Exception e) {
        out.print(e + "\n");
        verif = true;
    }
    if (!verif) {
        response.sendRedirect(Links.HOME);
    }

    SimpleDateFormat formato = new SimpleDateFormat("yyyy-MM-dd");
    Date dataFormatada = formato.parse(data);

%>

<%
    String nome = "";
    String user = "";
    try{
        int exist = 0;
        Connection con = Conexao.conectar();
        Statement st = con.createStatement();
        ResultSet rs = st.executeQuery("SELECT name,user FROM users Where id ='" + autor_id + "'");
        while (rs.next()) {
            exist ++;
            nome = rs.getString(1);
            user = rs.getString(2);
        }
            if(exist==0){
                nome = "usuario não identificado";
                user = autor_id;
            }
        }catch (Exception e){
        nome=e.toString();
    }

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
    </div>
    <title><%=titulo%>
    </title>
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
                out.print("<a class=\"btn btn - outline - info my - 2my - sm - 0\" type=\"button\" href=\"" + mypage + "\">My Page\n" + "</a>\n" + nomeUsuario + "<a href='" + Links.LOGOUT + "'><svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-box-arrow-right\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n" +
                        "  <path fill-rule=\"evenodd\" d=\"M11.646 11.354a.5.5 0 0 1 0-.708L14.293 8l-2.647-2.646a.5.5 0 0 1 .708-.708l3 3a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0z\"/>\n" +
                        "  <path fill-rule=\"evenodd\" d=\"M4.5 8a.5.5 0 0 1 .5-.5h9a.5.5 0 0 1 0 1H5a.5.5 0 0 1-.5-.5z\"/>\n" +
                        "  <path fill-rule=\"evenodd\" d=\"M2 13.5A1.5 1.5 0 0 1 .5 12V4A1.5 1.5 0 0 1 2 2.5h7A1.5 1.5 0 0 1 10.5 4v1.5a.5.5 0 0 1-1 0V4a.5.5 0 0 0-.5-.5H2a.5.5 0 0 0-.5.5v8a.5.5 0 0 0 .5.5h7a.5.5 0 0 0 .5-.5v-1.5a.5.5 0 0 1 1 0V12A1.5 1.5 0 0 1 9 13.5H2z\"/>\n" +
                        "</svg></a>");
            }
        %>


    </div>
</nav>

<div class="container">
    <div class="news">
        <h1><%=titulo%>
        </h1>
        <hr>
        <h4><%=subtitulo%>
        </h4>
        <img class="newsimage" src="<%=urlImagem%>">
        <div class="mt-2" align="justify" >
            <p><%=local+","%></p>
            <p align="justify"><%out.print(corpo);%></p>
        </div>
        <div class="card">
            <a class="card-title" href="#"><%=nome%></a>
            <p><%=user%></p>
            <p><%=dataFormatada%></p>
            <p>Tags: <%
                try {
                    int exist = 0;
                    Connection con = Conexao.conectar();
                    Statement st = con.createStatement();
                    ResultSet rs = st.executeQuery("SELECT * FROM tag_news Where news_id ='" + id + "'");
                    while (rs.next()) {
                        String tag_id = rs.getString(2);
                        Statement st2 = con.createStatement();
                        ResultSet rs2 = st2.executeQuery("SELECT * FROM tags Where id ='" + tag_id + "'");
                        while(rs2.next()){
                            out.print("<a class='card-title' href='Tag.jsp?id="+tag_id+"'>"+rs2.getString(2)+"</a> ,");
                        }
                    }
                }catch (Exception e){
                    out.print(e);
                }





            %></p>
        </div>
    </div>
</div>



</body>
</html>
