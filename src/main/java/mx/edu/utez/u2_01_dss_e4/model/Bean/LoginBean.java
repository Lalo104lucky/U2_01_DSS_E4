package mx.edu.utez.u2_01_dss_e4.model.Bean;

public class LoginBean {
    public String correo, contra;

    public LoginBean() {

    }

    public LoginBean(String correo, String contra) {
        this.correo = correo;
        this.contra = contra;
    }

    public String getCorreo() {
        return correo;
    }

    public void setCorreo(String correo) {
        this.correo = correo;
    }

    public String getContra() {
        return contra;
    }

    public void setContra(String contra) {
        this.contra = contra;
    }
}
