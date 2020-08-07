package Config;

import java.sql.*;
import com.mysql.jdbc.Driver;

public class Conexao {

    public static Connection conectar() throws SQLException {
        try {
            Class.forName("com.mysql.jdbc.Driver");
            return DriverManager.getConnection("jdbc:mysql://localhost/agora", "root","");

        }catch (ClassNotFoundException e){
            throw new RuntimeException(e);
        }
    }

}