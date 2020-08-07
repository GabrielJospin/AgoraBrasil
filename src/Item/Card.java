package Item;

import Config.Conexao;
import com.mysql.jdbc.Driver;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class Card {
    String titulo = "";
    String subtitulo = "";
    String urlNoticia = "";
    String urlImagem = "";
    public String code;
    public Boolean proximo = true;

    public Card(int point) {
        try {
            Connection con = Conexao.conectar();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT * FROM news Where id = '"+point+"'");
            while (rs.next()) {
                urlNoticia = "#";
                titulo = rs.getString(2);
                subtitulo = rs.getString(3);
                urlImagem = rs.getString(2);
                code = "    <div class=\"card\">\n" +
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
                        "    </div>";

            }
            urlImagem = "https://f.i.uol.com.br/fotografia/2020/03/24/15850785725e7a612ca61d1_1585078572_3x2_md.jpg";
        } catch (Exception e) {
            System.out.print(e);
            titulo = e.toString();
        }

    }

}
