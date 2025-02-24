package mx.edu.utez.u2_01_dss_e4.model.Dao;

import mx.edu.utez.u2_01_dss_e4.model.Bean.UsuarioBean;
import mx.edu.utez.u2_01_dss_e4.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsuarioDao {
    private static Connection conn;
    private static PreparedStatement pstm;
    private static ResultSet rs;

    private static final String get_personas = "SELECT * FROM personas";
    private static final String delete_usuario = "DELETE FROM personas WHERE id = ?";
    private static final String update_usuario = "UPDATE personas SET nombre = ?, apellido_m = ?, apellido_p = ?, correo = ?, telefono = ?, edad = ? WHERE id = ?";


    public static List<UsuarioBean> mostrarPersonas(){
        List<UsuarioBean> personas = new LinkedList<>();
        UsuarioBean persona = null;
        try{
            conn = new MySQLConnection().getConnection();
            pstm = conn.prepareStatement(get_personas);
            rs = pstm.executeQuery();
            while(rs.next()){
                persona = new UsuarioBean();
                persona.setId(rs.getInt("id"));
                persona.setNombre(rs.getString("nombre"));
                persona.setApellido_m(rs.getString("apellido_m"));
                persona.setApellido_p(rs.getString("apellido_p"));
                persona.setCorreo(rs.getString("correo"));
                persona.setTelefono(rs.getString("telefono"));
                persona.setEdad(rs.getInt("edad"));
                personas.add(persona);
            }
        } catch (SQLException e) {
            Logger.getLogger(UsuarioDao.class.getName())
                    .log(Level.SEVERE, "Error en mostrar personas -> ", e);
        }finally {
            closeConnections();
        }
        return personas;
    }

    public static boolean eliminarUsuario(int id) {
        boolean result = false;
        try {
            conn = new MySQLConnection().getConnection();
            pstm = conn.prepareStatement(delete_usuario);
            pstm.setInt(1, id);
            int affectedRows = pstm.executeUpdate();
            result = affectedRows > 0;
        } catch (SQLException e) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, "Error al eliminar usuario -> ", e);
        } finally {
            closeConnections();
        }
        return result;
    }


    public static boolean actualizarUsuario(int id, String nombre, String apellido_m, String apellido_p, String correo, String telefono, int edad) {
        boolean result = false;
        try {
            conn = new MySQLConnection().getConnection();
            pstm = conn.prepareStatement(update_usuario);
            pstm.setString(1, nombre);
            pstm.setString(2, apellido_m);
            pstm.setString(3, apellido_p);
            pstm.setString(4, correo);
            pstm.setString(5, telefono);
            pstm.setInt(6, edad);
            pstm.setInt(7, id);
            int affectedRows = pstm.executeUpdate();
            result = affectedRows > 0;
        } catch (SQLException e) {
            Logger.getLogger(UsuarioDao.class.getName()).log(Level.SEVERE, "Error al actualizar usuario -> ", e);
        } finally {
            closeConnections();
        }
        return result;
    }

    public static void closeConnections() {
        try {
            if (conn != null) {
                conn.close();
            }
            if (pstm != null) {
                pstm.close();
            }
            if (rs != null) {
                rs.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

}
