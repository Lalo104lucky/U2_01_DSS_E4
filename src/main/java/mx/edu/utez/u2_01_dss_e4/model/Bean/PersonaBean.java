package mx.edu.utez.u2_01_dss_e4.model.Bean;

public class PersonaBean {
    private Long id;
    private String nombre;
    private String apellido_p;
    private String apellido_m;
    private String correo;
    private String contrasena;
    private String telefono;
    private int edad;

    public PersonaBean() {}

    public PersonaBean(Long id, String nombre, String apellido_p, String apellido_m, String correo, String contrasena, String telefono, int edad) {
        this.id = id;
        this.nombre = nombre;
        this.apellido_p = apellido_p;
        this.apellido_m = apellido_m;
        this.correo = correo;
        this.contrasena = contrasena;
        this.telefono = telefono;
        this.edad = edad;
    }

    // Getters y Setters
    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getNombre() { return nombre; }
    public void setNombre(String nombre) { this.nombre = nombre; }
    public String getApellido_p() { return apellido_p; }
    public void setApellido_p(String apellido_p) { this.apellido_p = apellido_p; }
    public String getApellido_m() { return apellido_m; }
    public void setApellido_m(String apellido_m) { this.apellido_m = apellido_m; }
    public String getCorreo() { return correo; }
    public void setCorreo(String correo) { this.correo = correo; }
    public String getContrasena() { return contrasena; }
    public void setContrasena(String contrasena) { this.contrasena = contrasena; }
    public String getTelefono() { return telefono; }
    public void setTelefono(String telefono) { this.telefono = telefono; }
    public int getEdad() { return edad; }
    public void setEdad(int edad) { this.edad = edad; }
}
