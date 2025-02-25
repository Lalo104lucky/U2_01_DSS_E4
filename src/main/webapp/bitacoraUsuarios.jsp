<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 24/2/2025
  Time: 03:40 p. m.
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Bitacora Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
<div class="container mt-5">
    <div class="row">
        <h1 class="text-center">Control de personas</h1>
        <div class="d-flex justify-content-between col-12">
            <div>
                <a href="home.jsp" class="btn btn-primary">Página Principal</a>
            </div>
        </div>
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Usuario</th>
                <th scope="col">Dia Realizado</th>
                <th scope="col">Operacion</th>
            </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
    </div>
</div>
<script>
    document.addEventListener('DOMContentLoaded', async()=>{
        try{
            const response = await fetch('bitacora', {
                method: "GET",
                headers: { 'Content-Type': 'application/json' }
            });
            const data = await response.json();
            console.log(data)

            const tbody = document.querySelector('.table tbody');
            tbody.innerHTML = '';

            data.forEach((bitacora, index) => {
                const row = document.createElement('tr');

                const cellIndex = document.createElement('td');
                cellIndex.textContent = index + 1;
                row.appendChild(cellIndex);

                const cellNombre = document.createElement('td');
                cellNombre.textContent = "Administrador";
                row.appendChild(cellNombre);

                const cellDiaRealizado = document.createElement('td');
                cellDiaRealizado.textContent = bitacora.dia_realizado;
                row.appendChild(cellDiaRealizado);

                const cellOperacion = document.createElement('td');
                cellOperacion.textContent = bitacora.operacion;
                row.appendChild(cellOperacion);

                tbody.appendChild(row);
            });
        }catch (error){
            console.error('Error al obtener los datos:', error);
        }
    })
</script>
</body>
</html>