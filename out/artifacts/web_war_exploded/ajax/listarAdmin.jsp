<%@ page import="Config.Conexao" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="Config.Links" %>
<%
    String search = request.getParameter("txtSearch");
    boolean typeSearch = ! (search.equals("") || search == null);
    search = "%" + search + "%";
    String mypage = Links.MYPAGEADMIN;

    out.print("\n" +
            "<table class=\"table table-dark mt-4\">\n" +
            "    <thead>\n" +
            "    <tr>\n" +
            "        <th scope=\"col\">Name</th>\n" +
            "        <th scope=\"col\">User</th>\n" +
            "        <th scope=\"col\">nivel</th>\n" +
            "        <th scope=\"col\">Edit</th>\n" +
            "    </tr>\n" +
            "    </thead>\n" +
            "    <tbody>");
    try {
        Connection con = Conexao.conectar();
        Statement st = con.createStatement();
        ResultSet rs;
        if (typeSearch) {
            rs = st.executeQuery("SELECT * FROM users where Name like'" + search + "' order by nivel asc, name asc ");
        } else {
            rs = st.executeQuery("SELECT * FROM users order by nivel asc, name asc ");
        }
        while (rs.next()) {
            String name = rs.getString(2);
            String user = rs.getString(3);
            String userNivel = rs.getString(5);

            out.print("<tr>\n" +
                    "        <td>" + name + "</td>\n" +
                    "        <td>" + user + "</td>\n" +
                    "        <td>" + userNivel + "</td>\n" +
                    " <td> <a href='" + mypage + "?funcao=edit&id=" + rs.getString(1) + "' class=\"text-info\"><svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-pencil\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n" +
                    "  <path fill-rule=\"evenodd\" d=\"M11.293 1.293a1 1 0 0 1 1.414 0l2 2a1 1 0 0 1 0 1.414l-9 9a1 1 0 0 1-.39.242l-3 1a1 1 0 0 1-1.266-1.265l1-3a1 1 0 0 1 .242-.391l9-9zM12 2l2 2-9 9-3 1 1-3 9-9z\"/>\n" +
                    "  <path fill-rule=\"evenodd\" d=\"M12.146 6.354l-2.5-2.5.708-.708 2.5 2.5-.707.708zM3 10v.5a.5.5 0 0 0 .5.5H4v.5a.5.5 0 0 0 .5.5H5v.5a.5.5 0 0 0 .5.5H6v-1.5a.5.5 0 0 0-.5-.5H5v-.5a.5.5 0 0 0-.5-.5H3z\"/>\n" +
                    "</svg></a>\n" +
                    " <a href='" + mypage + "?funcao=delete&id=" + rs.getString(1) + "' class=\"text-danger\"><svg width=\"1em\" height=\"1em\" viewBox=\"0 0 16 16\" class=\"bi bi-trash\" fill=\"currentColor\" xmlns=\"http://www.w3.org/2000/svg\">\n" +
                    "  <path d=\"M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5zm3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0V6z\"/>\n" +
                    "  <path fill-rule=\"evenodd\" d=\"M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1v1zM4.118 4L4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4H4.118zM2.5 3V2h11v1h-11z\"/>\n" +
                    "</svg></a>\n" +
                    " </td>\n" +
                    "</tr>");

        }
    }catch (Exception e){
        out.print(e);
    }

%>
