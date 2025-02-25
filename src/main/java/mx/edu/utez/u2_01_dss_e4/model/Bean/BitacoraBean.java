package mx.edu.utez.u2_01_dss_e4.model.Bean;

public class BitacoraBean {

    public String operacion, dia_realizado;
    public int id_bitacora, persona_id;

    public BitacoraBean(String operacion, String dia_realizado, int id_bitacora, int persona_id) {
        this.operacion = operacion;
        this.dia_realizado = dia_realizado;
        this.id_bitacora = id_bitacora;
        this.persona_id = persona_id;
    }

    public BitacoraBean() {
    }

    public String getOperacion() {
        return operacion;
    }

    public void setOperacion(String operacion) {
        this.operacion = operacion;
    }

    public String getDia_realizado() {
        return dia_realizado;
    }

    public void setDia_realizado(String dia_realizado) {
        this.dia_realizado = dia_realizado;
    }

    public int getId_bitacora() {
        return id_bitacora;
    }

    public void setId_bitacora(int id_bitacora) {
        this.id_bitacora = id_bitacora;
    }

    public int getPersona_id() {
        return persona_id;
    }

    public void setPersona_id(int persona_id) {
        this.persona_id = persona_id;
    }
}
