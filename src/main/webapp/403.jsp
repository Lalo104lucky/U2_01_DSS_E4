<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 22/2/2025
  Time: 05:48 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Acceso Denegado</title>

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            overflow: hidden;
            background-color: steelblue;
            font-family: 'Comfortaa', cursive;
            display: flex;
            align-items: center;
            justify-content: center;
            flex-direction: column;
            text-align: center;
        }

        .container {
            z-index: 1;
        }

        img {
            max-width: 200px;
            margin-bottom: 20px;
        }

        h1 {
            font-size: 5rem;
            font-weight: bold;
            color: #9ae1e2;
            font-family: 'Ubuntu', sans-serif;
            text-transform: uppercase;
        }

        h2 {
            font-family: 'Cabin', sans-serif;
            color: #9ae1e2;
            font-size: 2rem;
            margin-bottom: 20px;
        }

        h5 {
            font-family: 'Cabin', sans-serif;
            color: darkred;
            font-size: 1.2rem;
            margin-bottom: 30px;
        }
    </style>
</head>
<body>
<div class="container">
    <img src="https://cdn-icons-png.flaticon.com/512/564/564619.png" alt="Error 403">
    <h1>Error 403</h1>
    <h2>Lo sentimos, no tienes acceso o permisos para esta página</h2>
    <h5>Por favor regresa</h5>
    <a href="./index.jsp" class="btn btn-warning">Regresar</a>
</div>
</body>
</html>