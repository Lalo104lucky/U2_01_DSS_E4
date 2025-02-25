package mx.edu.utez.u2_01_dss_e4.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.u2_01_dss_e4.model.Bean.UsuarioBean;
import mx.edu.utez.u2_01_dss_e4.model.Dao.UsuarioDao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.PrintWriter;

@WebServlet(name = "UsuarioServlet", urlPatterns = {
        "/inicio",
        "/usuario",
        "/registrar",
        "/bitacora",
})
public class UsuarioServlet extends HttpServlet {

    String redirect = "/", action;
    String json = null;

    protected void processRequest (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        action = request.getServletPath();
        switch (action) {
            case "/inicio":
                response.sendRedirect(request.getContextPath() + "/home.jsp");
                break;
            case "/usuario":
                String json = null;
                json = gson.toJson(UsuarioDao.mostrarPersonas());
                response.getWriter().write(json);
                break;
            case "/registrar":
                StringBuilder stringBuilder = new StringBuilder();
                BufferedReader reader = new BufferedReader(new InputStreamReader((request.getInputStream())));
                String requestBody = stringBuilder.append(reader.readLine()).toString();

                UsuarioBean usuarioBean = new UsuarioBean();
                usuarioBean = gson.fromJson(requestBody, UsuarioBean.class);
                UsuarioDao.register(usuarioBean);

                JsonObject jsonResponse = new JsonObject();
                jsonResponse.addProperty("success", true);
                jsonResponse.add("usuario", gson.toJsonTree(usuarioBean));

                response.setContentType("application/json");
                response.setCharacterEncoding("UTF-8");
                response.getWriter().write(jsonResponse.toString());
                break;
            case "/bitacora":
                json = gson.toJson(UsuarioDao.mostrarBitacora());
                response.getWriter().write(json);
                break;

            default:
                response.setStatus(HttpServletResponse.SC_NOT_FOUND);
                response.getWriter().write(gson.toJson("recurso no encontrado"));
                response.sendRedirect(request.getContextPath() + "/404.jsp");
                break;
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doDelete(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String idParam = request.getParameter("id");

        if (idParam != null) {
            int id = Integer.parseInt(idParam);
            boolean eliminado = UsuarioDao.eliminarUsuario(id);
            response.getWriter().write("{\"success\": " + eliminado + "}");
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "ID requerido");
        }
    }
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        try {
            BufferedReader reader = request.getReader();
            Gson gson = new Gson();
            JsonObject jsonObject = gson.fromJson(reader, JsonObject.class);

            if (jsonObject != null && jsonObject.has("id")) {
                int id = jsonObject.get("id").getAsInt();
                String nombre = jsonObject.get("nombre").getAsString();
                String apellido_m = jsonObject.get("apellido_m").getAsString();
                String apellido_p = jsonObject.get("apellido_p").getAsString();
                String correo = jsonObject.get("correo").getAsString();
                String telefono = jsonObject.get("telefono").getAsString();
                int edad = jsonObject.get("edad").getAsInt();

                boolean actualizado = UsuarioDao.actualizarUsuario(id, nombre, apellido_m, apellido_p, correo, telefono, edad);
                response.getWriter().write("{\"success\": " + actualizado + "}");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Datos incompletos");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error al actualizar el usuario");
        }
    }
}