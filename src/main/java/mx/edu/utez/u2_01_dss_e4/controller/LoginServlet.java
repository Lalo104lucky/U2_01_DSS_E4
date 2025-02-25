package mx.edu.utez.u2_01_dss_e4.controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import com.google.gson.Gson;
import mx.edu.utez.u2_01_dss_e4.model.Bean.LoginBean;
import mx.edu.utez.u2_01_dss_e4.model.Dao.LoginDao;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

@WebServlet(name = "LoginServlet", urlPatterns = {
        "/login",
        "/getPermisos",
        "/signIn",
        "/signOut",
})
public class LoginServlet extends HttpServlet {

    String redirect = "/", action;

    protected void loginRequest (HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        request.setCharacterEncoding("UTF-8");

        action = request.getServletPath();
        switch (action) {
            case "/login":
                response.sendRedirect(request.getContextPath() + "/index.jsp");
                break;
            case "/signIn":
                signIn(request, response);
                break;
            case "/signOut":
                signOut(request, response);
                System.out.println("Cerrando sesión");
                break;
            case "/getPermisos":
                getPermisos(request, response);
                break;
        }
    }

    private void signIn(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String json = "";
        Gson gson = new Gson();
        StringBuilder stringBuilder = new StringBuilder();
        BufferedReader reader = new BufferedReader(new InputStreamReader((request.getInputStream())));
        String requestBody = stringBuilder.append(reader.readLine()).toString();

        LoginBean loginBean = new LoginBean();
        loginBean = gson.fromJson(requestBody, LoginBean.class);
        HttpSession session = request.getSession();
        boolean validuser = LoginDao.login(loginBean, session);
        if (!validuser) {
            response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            response.getWriter().write(gson.toJson("Credenciales Incorrectas"));
        }

        response.getWriter().write(gson.toJson("Inicio de sesión exitoso"));

    }

    private void signOut(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        Gson gson = new Gson();
        if (session != null){
            session.invalidate();
            response.getWriter().write(gson.toJson("Sesión cerrada correctamente"));
        } else {
            response.getWriter().write(gson.toJson("No hay sesión activa"));
        }
    }

    private void getPermisos(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession(false);
        Gson gson = new Gson();
        if(session != null && session.getAttribute("permisos") != null) {
            response.getWriter().write(gson.toJson("Acceso permitido"));
        } else {
            response.getWriter().write(gson.toJson("Sin permisos"));
        }
    }


    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loginRequest(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        loginRequest(request, response);
    }
}