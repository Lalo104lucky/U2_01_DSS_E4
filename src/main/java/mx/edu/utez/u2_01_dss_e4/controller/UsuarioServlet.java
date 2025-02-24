package mx.edu.utez.u2_01_dss_e4.controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.u2_01_dss_e4.model.Bean.PersonaBean;
import mx.edu.utez.u2_01_dss_e4.model.Dao.PersonaDao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.Map;
@WebServlet(name = "UsuarioServlet", value = "/inicio")
public class UsuarioServlet extends HttpServlet {
    private final PersonaDao personaDao = new PersonaDao();
    Gson gson = new Gson();
    StringBuilder stringBuilder = new StringBuilder();

    protected void processRequest (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        BufferedReader reader = new BufferedReader(new InputStreamReader((request.getInputStream())));

        String requestBody = stringBuilder.append(reader.readLine()).toString();

        HttpSession session = request.getSession();
        String data = (String) session.getAttribute("session");

        String action = request.getServletPath();

        if (data != null){
            String[] dataSession = data.split("/");
            if (dataSession[2].equals("admin")) {
                switch (action) {
                    case "/inicio":
                        response.sendRedirect(request.getContextPath() + "/home.jsp");
                        System.out.println("Página principal");
                        break;

                }
            } else {
                response.sendRedirect(request.getContextPath() + "/403.jsp");
            }
        } else {
            response.sendRedirect(request.getContextPath() + "/403.jsp");
        }


    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
       }
    @Override
    protected void doPut(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        StringBuilder sb = new StringBuilder();
        String line;
        try (BufferedReader reader = request.getReader()) {
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        }

        PersonaBean persona = gson.fromJson(sb.toString(), PersonaBean.class);
        boolean actualizado = personaDao.actualizarPersona(persona);

        response.getWriter().write(gson.toJson(Map.of("success", actualizado)));
    }

}