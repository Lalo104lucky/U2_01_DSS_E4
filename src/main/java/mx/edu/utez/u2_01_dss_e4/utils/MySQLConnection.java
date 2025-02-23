package mx.edu.utez.u2_01_dss_e4.utils;

import java.sql.*;

public class MySQLConnection {

    Connection connection;

    public static void main(String[] args) {
        try{
            Connection con = new MySQLConnection().getConnection();
            if (con != null){
                System.out.println("Todo bien");
                con.close();
            } else {
                System.out.println("Todo mal");
            }
        } catch (SQLException e){
            System.out.println("Error:" + e);
        }
    }

    public MySQLConnection(){
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/peopleCocer","root","root");
        } catch (SQLException | ClassNotFoundException e){
            System.out.println("Error: " + e);
        }
    }

    public Connection getConnection(){
        return connection;
    }
}
