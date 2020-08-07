<%@ page import="Config.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Config.Links" %><%
    try {
        String nome = request.getParameter("txtSearch");
        boolean typeSearch = ! (nome.equals("") || nome == null);
        nome = "%" + nome + "%";
        Connection con = Conexao.conectar();
        Statement st = con.createStatement();
        ResultSet rs;
        if(typeSearch) {
             rs = st.executeQuery("SELECT * FROM news Where Published = 1 and Titulo like '" + nome + "' order by data desc LIMIT 10");
        }else{
             rs = st.executeQuery("SELECT * FROM news Where Published = 1 order by data desc LIMIT 10");
        } while (rs.next()) {
            String urlNoticia = Links.NEWS + "?id="+rs.getString(1);
            String titulo = rs.getString(2);
            String subtitulo = rs.getString(3);
            String urlImagem = rs.getString(5);
            out.print("    <div class=\"card\">\n" +
                    "        <div class=\"figure\">\n" +
                    "            <img class=\"image\"\n" +
                    "                 src=\"" + urlImagem + "\"\n" +
                    "                 class=\"card-img-top\"></div><!--\n" +
                    "    --><div class=\"card-body\">\n" +
                    "        <h5>" + titulo + "</h5>\n" +
                    "\n" +
                    "        <p class=\"card-text\">" + subtitulo + "</p>\n" +
                    "        <a href=\"" + urlNoticia + "\" class=\"btn btn-outline-info direita\">Leia a noticia</a>\n" +
                    "    </div>\n" +
                    "    </div>");

        }
    }catch (Exception e){
        out.print(e+"\n");
    }
%>
