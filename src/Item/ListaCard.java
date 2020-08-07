package Item;

import Config.Conexao;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class ListaCard {
    static public int pos = 0;
    static public Card[] array = new Card[10];

    public static Card[] list(){
        try{
            Connection con = Conexao.conectar();
            Statement st = con.createStatement();
            ResultSet rs = st.executeQuery("SELECT id FROM news Where published = 1 ASC DATA LIMIT 10 ");
            while(rs.next()){
                array[pos] = new Card(rs.getInt(1));
                pos++;
            }


        }catch (Exception e){
            array[pos].titulo = e.toString();
        }finally {
            return array;
        }
    }
}

