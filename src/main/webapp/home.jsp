<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Página Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
    <h1>Control de personas</h1>
    <div class="container mt-5">
        <table class="table table-striped table-hover">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido materno</th>
                <th scope="col">Apellido Paterno</th>
                <th scope="col">Email</th>
                <th scope="col">Telefono</th>
                <th scope="col">Edad</th>
            </tr>
            </thead>
            <tbody>

            </tbody>
        </table>
    </div>

    <script>
        document.addEventListener('DOMContentLoaded', async()=>{
            await fetch('usuario', {
                method: "GET",
                headers: { "Content-Type": "application/json" }
            }).then(response => response.json()).then(data => console.log(data))
        })
    </script>
</body>
</html>
