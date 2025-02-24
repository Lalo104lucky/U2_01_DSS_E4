package mx.edu.utez.u2_01_dss_e4.model.Dao;

import jakarta.servlet.http.HttpSession;
import mx.edu.utez.u2_01_dss_e4.model.Bean.LoginBean;
import mx.edu.utez.u2_01_dss_e4.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LoginDao {

    public static Connection conn;
    public static PreparedStatement pstm;
    public static ResultSet rs;

    public static boolean login(LoginBean loginBean, HttpSession session) {
        MySQLConnection connection = new MySQLConnection();
        String sqlQuery = "SELECT * FROM personas where correo = ? and contrasena = sha1(?);";
        String sqlBitacora = "INSERT INTO bitacora VALUES (null, ?, CURRENT_TIMESTAMP, ?);";

        try (
                Connection conn = connection.getConnection();
             PreparedStatement pstm = conn.prepareStatement(sqlQuery)) {
            pstm.setString(1, loginBean.correo);
            pstm.setString(2, loginBean.contra);
            try (ResultSet rs = pstm.executeQuery()) {
                if (rs.next()) {
                    int userId = rs.getInt("id");
                    String permisos = (userId == 1) ? "admin" : "user";

                    // Guardar la sesión
                    session.setAttribute("usuario", loginBean.correo);
                    session.setAttribute("permisos", permisos);

                    // Insertar en bitácora
                    try (PreparedStatement pstmBitacora = conn.prepareStatement(sqlBitacora)) {
                        pstmBitacora.setInt(1, userId);
                        pstmBitacora.setString(2, "Método POST");
                        System.out.println(sqlQuery);
                        int res = pstmBitacora.executeUpdate();
                        return res > 0;
                    }
                }
            }
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage());
        } finally {
            try {
                if (conn != null)
                    conn.close();
                if (pstm != null)
                    pstm.close();
                if (rs != null)
                    rs.close();
            } catch (Exception e){
                System.out.println("Error al iniciar sesion: " + e.getMessage());
            }
        }
        return false;
    }
}
