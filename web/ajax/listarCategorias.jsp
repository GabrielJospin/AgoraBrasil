<%@ page import="Config.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Config.Links" %><%
    String search = request.getParameter("txtSearch");
    boolean typeSearch = ! (search.equals("") || search == null);
    search = "%" + search + "%";
    try {
        Connection con = Conexao.conectar();
        Statement st = con.createStatement();
        ResultSet rs;
        if(typeSearch) {
            rs = st.executeQuery("SELECT * FROM tags where Nome like '"+search+"' order by Nome asc ");
        }else{
            rs = st.executeQuery("SELECT * FROM tags order by Nome asc ");
        }
        while (rs.next()) {
            String urlTag = Links.TAGS + "?id=" + rs.getString(1);
            String urlImagem = "img/Tag/tag-" + rs.getString(1) + ".jpg";
            String nome = rs.getString(2);
            String descricao = rs.getString(3);
            out.print("    <div class=\"card\">\n" +
                    "        <div class=\"figure\">\n" +
                    "            <img class=\"image\"\n" +
                    "                 src=\"" + urlImagem + "\"\n" +
                    "                 class=\"card-img-top\"></div><!--\n" +
                    "    --><div class=\"card-body\">\n" +
                    "        <h5>" + nome + "</h5>\n" +
                    "\n" +
                    "        <p class=\"card-text\">" + descricao + "</p>\n" +
                    "        <a href=\"" + urlTag + "\" class=\"btn btn-outline-info direita\">Ver Tag</a>\n" +
                    "    </div>\n" +
                    "    </div>");
        }
    } catch (Exception e) {
        out.print(e + "\n");
    }
%>