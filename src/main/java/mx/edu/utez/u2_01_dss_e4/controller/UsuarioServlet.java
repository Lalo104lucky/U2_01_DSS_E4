package mx.edu.utez.u2_01_dss_e4.controller;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import mx.edu.utez.u2_01_dss_e4.model.Dao.UsuarioDao;

import java.io.IOException;

@WebServlet(name = "UsuarioServlet", urlPatterns = {"/inicio", "/usuario"})
public class UsuarioServlet extends HttpServlet {

    protected void processRequest (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException  {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        Gson gson = new Gson();
        String action = request.getServletPath();
        switch (action) {
            case "/inicio":
                response.sendRedirect(request.getContextPath() + "/home.jsp");
                System.out.println("Página principal");
                break;
            case "/usuario":
                String json = null;
                json = gson.toJson(UsuarioDao.mostrarPersonas());
                response.getWriter().write(json);
                System.out.println(json);
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
}