<%@ page import="Config.Links" %>
<%@ page import="Config.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="javax.imageio.ImageIO" %>
<%@ page import="java.io.File" %>
<%@ page import="java.awt.image.BufferedImage" %>
<%@ page import="jdk.nashorn.internal.runtime.regexp.joni.Config" %>
<%@ page import="java.io.InputStream" %>
<%@ page contentType="text/html;charset=iso-8859-1" language="java" %>
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
    <title>My Page</title>
</head>
<body>
<%!
    private ServletContext servletContext;
%><%
    String mypage = Links.MYPAGECOLUMNIST;
    if (session == null) response.sendRedirect("index.jsp");
    String nomeUsuario = (String) session.getAttribute("Nome do usuário");
    String userId = (String) session.getAttribute("User id");
    boolean logado = (nomeUsuario != null);
    String nivel = (String) session.getAttribute("Nivel");
    if ((!nivel.equals("Columnist")) || nivel == null) response.sendRedirect("index.jsp");
%>
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
    <div class="news">
        <form method="post">
            <h1>Hi, <%=nomeUsuario%>
            </h1>
            <h2>Welcome to your page</h2>
            <hr>
            <h4>Writer</h4>
            <input class="form-control form-control-lg" type="text" name="txtTitle" placeholder="Titulo">
            <br>
            <input class="form-control" type="text" name="txtSubtitle" placeholder="Subtitulo">
            <div class="form-group">
                <label for="exampleFormControlTextarea1">O Texto: </label>
                <textarea class="form-control" name="Texto" id="exampleFormControlTextarea1" rows="50"></textarea>
            </div>
            <div class="form-group">
                <label for="exampleFormControlFile1">Imagem</label>
                <input action="upload"  type="file" enctype="multipart/form-data" class="form-control-file" name="img" id="exampleFormControlFile1">
            </div>
            <input class="form-control form-control-sm" type="text" name="txtLocal" placeholder="Local">
            <%
                Connection con = Conexao.conectar();
                Statement st = con.createStatement();
                ResultSet rs = st.executeQuery("SELECT * FROM tags order by Nome asc ");
                while (rs.next()) {
                    if (rs.getString(1).equals("4")) {
                        out.print("<input id='defaultCheck1' type='checkbox' name='Tag_id' value='1' disabled>" +
                                "<label class='form-check-label' for='defaultCheck1'>" + rs.getString(2) + "</label>");
                    } else {
                        out.print("<input id='defaultCheck1' type='checkbox' name='Tag_id' value=" + rs.getString(1) + " " +
                                "<label class='form-check-label' for='defaultCheck1'>" + rs.getString(2) + "</label> \t");
                    }

                }
            %>
            <br>
            <br>
            <button type="submit" class="btn btn-outline-info my-2 my-sm-0 mt-2" name="btn-submit">Enviar</button>
        </form>
    </div>
</div>

<%
    if (request.getParameter("txtTitle") != null) {
        String titulo = request.getParameter("txtTitle");
        String subtitulo = request.getParameter("txtSubtitle");
        String text = request.getParameter("Texto");
        String local = request.getParameter("txtLocal");
        out.print(local);
        String id = "-1";
        try {
            con = Conexao.conectar();
            st = con.createStatement();
            st.executeUpdate("Insert into news (Titulo, Subtitulo, Corpo, Autor_id, lugar , Published) " +
                    "VALUES ('" + titulo + "' , '" + subtitulo + "', '" + text + "', '" + userId + "','" + local + "',1)");

            Statement st2 = con.createStatement();
            ResultSet rs2 = st2.executeQuery("SELECT * from news where Titulo like '%" + titulo + "%'");
            while (rs2.next()) {
                id = rs2.getString(1);
            }

            Statement st3 = con.createStatement();
            st3.executeUpdate("update news SET Imagem = 'img/news/img-" + id + "' where  id = '" + id + "'");

            /*String img = request.getParameter("img");
            BufferedImage image = ImageIO.read(new File(img));
            ImageIO.write(image, "jpg", new File("img/news/img-" + id + ".jpg"));
            */
            String[] tags_id = request.getParameterValues("Tag_id");
            for (int i = 0; i < tags_id.length; i++) {
                Statement st4 = con.createStatement();
                st4.executeUpdate("INSERT INTO tag_news (tag_id,news_id) VALUES ('" + tags_id[i] + "','" + id + "')");
            }
            out.print("<Script>alert('Publicada!');</Script>");


        } catch (Exception e) {

            out.print(e+" ");
            e.printStackTrace();
        }
    }

%>
</body>
</html>
