<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Página Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
</head>
<body>
    <div class="container mt-5">
        <div class="row">
            <h1 class="text-center">Control de personas</h1>
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
                    <th scope="col">Editar</th>
                    <th scope="col">Eliminar</th>
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
                const response = await fetch('usuario', {
                    method: "GET",
                    headers: { 'Content-Type': 'application/json' }
                });
                const data = await response.json();
                console.log(data)

                const tbody = document.querySelector('.table tbody');
                tbody.innerHTML = '';

                data.forEach((usuario, index) => {
                    const row = document.createElement('tr');

                    const cellIndex = document.createElement('td');
                    cellIndex.textContent = index + 1;
                    row.appendChild(cellIndex);

                    const cellNombre = document.createElement('td');
                    cellNombre.textContent = usuario.nombre;
                    row.appendChild(cellNombre);

                    const cellApellidoMaterno = document.createElement('td');
                    cellApellidoMaterno.textContent = usuario.apellido_m;
                    row.appendChild(cellApellidoMaterno);

                    const cellApellidoPaterno = document.createElement('td');
                    cellApellidoPaterno.textContent = usuario.apellido_p;
                    row.appendChild(cellApellidoPaterno);

                    const cellEmail = document.createElement('td');
                    cellEmail.textContent = usuario.correo;
                    row.appendChild(cellEmail);

                    const cellTelefono = document.createElement('td');
                    cellTelefono.textContent = usuario.telefono;
                    row.appendChild(cellTelefono);

                    const cellEdad = document.createElement('td');
                    cellEdad.textContent = usuario.edad;
                    row.appendChild(cellEdad);

                    // Botón Editar
                    const botonEditar = document.createElement('td');
                    botonEditar.innerHTML = `
                    <button class="btn btn-primary btn-sm">
                        <i class="fas fa-edit"></i> Editar
                    </button>
                `;
                    row.appendChild(botonEditar);

                    // Botón Eliminar
                    const botonEliminar = document.createElement('td');
                    botonEliminar.innerHTML = `
                    <button class="btn btn-danger btn-sm">
                        <i class="fas fa-trash"></i> Eliminar
                    </button>
                `;
                    row.appendChild(botonEliminar);

                    tbody.appendChild(row);
                });
            }catch (error){
                console.error('Error al obtener los datos:', error);
            }
        })
    </script>
</body>
</html>
