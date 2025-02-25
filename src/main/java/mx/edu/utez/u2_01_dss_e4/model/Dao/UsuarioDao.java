package mx.edu.utez.u2_01_dss_e4.model.Dao;

import mx.edu.utez.u2_01_dss_e4.model.Bean.BitacoraBean;
import mx.edu.utez.u2_01_dss_e4.model.Bean.UsuarioBean;
import mx.edu.utez.u2_01_dss_e4.utils.MySQLConnection;

import java.sql.*;
import java.util.LinkedList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class UsuarioDao {
    private static Connection conn;
    private static PreparedStatement pstm;
    private static ResultSet rs;

    private static final String get_personas = "SELECT * FROM personas";
    private static final String register_persona = "INSERT INTO personas VALUES (null, ?, ?, ?, ?, sha1(?), ?, ?)";
    private static final String delete_usuario = "DELETE FROM personas WHERE id = ?";
    private static final String update_usuario = "UPDATE personas SET nombre = ?, apellido_m = ?, apellido_p = ?, correo = ?, telefono = ?, edad = ? WHERE id = ?";
    private static final String sqlBitacora = "INSERT INTO bitacora VALUES (null, ?, CURRENT_TIMESTAMP, ?);";
    private static final String get_bitacora = "SELECT * FROM bitacora";

    public static List<BitacoraBean> mostrarBitacora() {
        List<BitacoraBean> bitacoras = new LinkedList<>();
        try {
            conn = new MySQLConnection().getConnection();
            pstm = conn.prepareStatement(get_bitacora);
            rs = pstm.executeQuery();
            while (rs.next()) {
                BitacoraBean bitacora = new BitacoraBean();
                bitacora.setId_bitacora(rs.getInt("id_bitacora"));
                bitacora.setPersona_id(rs.getInt("persona_id"));
                bitacora.setDia_realizado(rs.getString("dia_realizado"));
                bitacora.setOperacion(rs.getString("operacion"));
                bitacoras.add(bitacora);
            }
        } catch (SQLException e) {
            Logger.getLogger(UsuarioDao.class.getName())
                    .log(Level.SEVERE, "Error en mostrar bitácora -> ", e);
        } finally {
            closeConnections();
        }
        return bitacoras;
    }

    public static List<UsuarioBean> mostrarPersonas() {
        List<UsuarioBean> personas = new LinkedList<>();
        UsuarioBean persona = null;
        try{
            conn = new MySQLConnection().getConnection();
            pstm = conn.prepareStatement(get_personas);
            rs = pstm.executeQuery();
            boolean primero = true;
            while(rs.next()){
                if (primero){
                    primero = false;
                    continue;
                }
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

    public static UsuarioBean register(UsuarioBean usuarioBean) {
        try {
            conn = new MySQLConnection().getConnection();
            pstm = conn.prepareStatement(register_persona, Statement.RETURN_GENERATED_KEYS);
            pstm.setString(1, usuarioBean.getNombre());
            pstm.setString(2, usuarioBean.getApellido_p());
            pstm.setString(3, usuarioBean.getApellido_m());
            pstm.setString(4, usuarioBean.getCorreo());
            pstm.setString(5, usuarioBean.getContrasena());
            pstm.setString(6, usuarioBean.getTelefono());
            pstm.setInt(7, usuarioBean.getEdad());
            pstm.executeUpdate();

            ResultSet generatedKeys = pstm.getGeneratedKeys();
            if (generatedKeys.next()) {
                usuarioBean.setId(generatedKeys.getInt(1));
            }
            int userId = 1;
            try (PreparedStatement pstmBitacora = conn.prepareStatement(sqlBitacora)) {
                pstmBitacora.setInt(1, userId);
                pstmBitacora.setString(2, "Método POST - Registro de usuario");
                pstmBitacora.executeUpdate();
            }
        } catch (Exception e) {
            Logger.getLogger(UsuarioDao.class.getName())
                    .log(Level.SEVERE, "Error en register -> ", e);
        } finally {
            closeConnections();
        }
        return usuarioBean;
    }

    public static boolean eliminarUsuario(int id) {
        boolean result = false;
        try {
            conn = new MySQLConnection().getConnection();
            pstm = conn.prepareStatement(delete_usuario);
            pstm.setInt(1, id);
            int affectedRows = pstm.executeUpdate();
            result = affectedRows > 0;
            int userId = 1;
            try (PreparedStatement pstmBitacora = conn.prepareStatement(sqlBitacora)) {
                pstmBitacora.setInt(1, userId);
                pstmBitacora.setString(2, "Método DELETE - Eliminación de usuario");
                pstmBitacora.executeUpdate();
            }
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
            int userId = 1;
            try (PreparedStatement pstmBitacora = conn.prepareStatement(sqlBitacora)) {
                pstmBitacora.setInt(1, userId);
                pstmBitacora.setString(2, "Método PUT - Actualización de usuario");
                pstmBitacora.executeUpdate();
            }
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
