package mx.edu.utez.u2_01_dss_e4.model.Dao;

import mx.edu.utez.u2_01_dss_e4.model.Bean.PersonaBean;
import mx.edu.utez.u2_01_dss_e4.utils.MySQLConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class PersonaDao {

    public boolean actualizarPersona(PersonaBean persona) {
        MySQLConnection connection = new MySQLConnection();
        String sqlQuery = "UPDATE personas SET nombre = ?, apellido_p = ?, apellido_m = ?, correo = ?, contrasena = sha1(?), telefono = ?, edad = ? WHERE id = ?;";

        try (Connection conn = connection.getConnection();
             PreparedStatement pstm = conn.prepareStatement(sqlQuery)) {

            pstm.setString(1, persona.getNombre());
            pstm.setString(2, persona.getApellido_p());
            pstm.setString(3, persona.getApellido_m());
            pstm.setString(4, persona.getCorreo());
            pstm.setString(5, persona.getContrasena());
            pstm.setString(6, persona.getTelefono());
            pstm.setInt(7, persona.getEdad());
            pstm.setLong(8, persona.getId());

            return pstm.executeUpdate() > 0;

        } catch (Exception e) {
            System.out.println("Error al actualizar persona: " + e.getMessage());
        }
        return false;
    }
}
