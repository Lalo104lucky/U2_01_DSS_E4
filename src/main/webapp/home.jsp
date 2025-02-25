<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Página Principal</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH" crossorigin="anonymous">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">

</head>
<body>
<div class="container mt-5">
    <div class="row">
        <h1 class="text-center">Control de personas</h1>
        <div class="d-flex justify-content-between col-12">
            <div>
                <a href="bitacoraUsuarios.jsp" class="btn btn-primary">Bitacora</a>
            </div>
            <div>
                <a href="registrarUsuario.jsp" class="btn btn-primary">Registrar Persona</a>
            </div>
        </div>
        <table class="table table-striped table-hover mt-04">
            <thead>
            <tr>
                <th scope="col">#</th>
                <th scope="col">Nombre</th>
                <th scope="col">Apellido Paterno</th>
                <th scope="col">Apellido Materno</th>
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

                const cellApellidoPaterno = document.createElement('td');
                cellApellidoPaterno.textContent = usuario.apellido_p;
                row.appendChild(cellApellidoPaterno);

                const cellApellidoMaterno = document.createElement('td');
                cellApellidoMaterno.textContent = usuario.apellido_m;
                row.appendChild(cellApellidoMaterno);

                const cellEmail = document.createElement('td');
                cellEmail.textContent = usuario.correo;
                row.appendChild(cellEmail);

                const cellTelefono = document.createElement('td');
                cellTelefono.textContent = usuario.telefono;
                row.appendChild(cellTelefono);

                const cellEdad = document.createElement('td');
                cellEdad.textContent = usuario.edad;
                row.appendChild(cellEdad);

                const botonEditar = document.createElement('td');
                botonEditar.innerHTML = `
                        <button class="btn btn-primary btn-sm btn-edit">
                            <i class="fas fa-edit"></i> Editar
                        </button>
                    `;
                row.appendChild(botonEditar);

                // Botón Eliminar
                const botonEliminar = document.createElement('td');
                botonEliminar.innerHTML = `
                        <button class="btn btn-danger btn-sm btn-delete">
                            <i class="fas fa-trash"></i> Eliminar
                        </button>
                    `;
                row.appendChild(botonEliminar);

                tbody.appendChild(row);

                botonEditar.querySelector('.btn-edit').addEventListener('click', () => {
                    const id = usuario.id;
                    const nombre = usuario.nombre;
                    const apellido_m = usuario.apellido_m;
                    const apellido_p = usuario.apellido_p;
                    const correo = usuario.correo;
                    const telefono = usuario.telefono;
                    const edad = usuario.edad;

                    // Lógica para abrir el modal y cargar los datos
                    const modal = new bootstrap.Modal(document.getElementById('editModal'));
                    document.getElementById('edit-id').value = id;
                    document.getElementById('edit-nombre').value = nombre;
                    document.getElementById('edit-apellido_m').value = apellido_m;
                    document.getElementById('edit-apellido_p').value = apellido_p;
                    document.getElementById('edit-correo').value = correo;
                    document.getElementById('edit-telefono').value = telefono;
                    document.getElementById('edit-edad').value = edad;
                    modal.show();
                });

                botonEliminar.querySelector('.btn-delete').addEventListener('click', async () => {
                    const id = usuario.id;

                    const confirmacion = window.confirm("¿Estás seguro de que quieres eliminar a este usuario?");
                    if (!confirmacion) {
                        return;
                    }

                    try {
                        const response = await fetch('usuario?id=' + id, {
                            method: 'DELETE',
                            headers: {
                                'Content-Type': 'application/json'
                            }
                        });

                        const result = await response.json();
                        console.log('Resultado del servidor:', result);

                        if (result.success) {
                            alert('Usuario eliminado con éxito');
                            location.reload();
                        } else {
                            alert('Error al eliminar el usuario: ' + (result.message || 'Desconocido'));
                        }
                    } catch (error) {
                        console.error('Error al eliminar el usuario:', error);
                        alert('Hubo un error al intentar eliminar el usuario. Por favor, inténtalo nuevamente.');
                    }
                });



            });

            document.getElementById('editForm').addEventListener('submit', async (event) => {
                event.preventDefault();


                const nombre = document.getElementById('edit-nombre').value;
                const apellido_m = document.getElementById('edit-apellido_m').value;
                const apellido_p = document.getElementById('edit-apellido_p').value;
                const correo = document.getElementById('edit-correo').value;
                const telefono = document.getElementById('edit-telefono').value;
                const edad = document.getElementById('edit-edad').value;


                if (!nombre || !apellido_m || !apellido_p || !correo || !telefono || !edad) {
                    alert("Todos los campos son obligatorios.");
                    return;
                }

                const confirmacion = window.confirm("¿Estás seguro de que quieres actualizar los datos de este usuario?");
                if (!confirmacion) {
                    return;
                }

                try {
                    const id = document.getElementById('edit-id').value;

                    const response = await fetch('usuario', {
                        method: 'PUT',
                        headers: {
                            'Content-Type': 'application/json'
                        },
                        body: JSON.stringify({ id, nombre, apellido_m, apellido_p, correo, telefono, edad })
                    });

                    const result = await response.json();
                    if (result.success) {
                        alert('Usuario actualizado con éxito');
                        location.reload();
                    } else {
                        alert('Error al actualizar el usuario');
                    }
                } catch (error) {
                    console.error('Error al actualizar el usuario:', error);
                    alert('Hubo un error al intentar actualizar el usuario. Por favor, inténtalo nuevamente.');
                }
            });

        } catch (error) {
            console.error('Error al obtener los datos:', error);
        }
    })
</script>

<div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="editModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editModalLabel">Editar Usuario</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="editForm">
                    <input type="hidden" id="edit-id">
                    <div class="mb-3">
                        <label for="edit-nombre" class="form-label">Nombre</label>
                        <input type="text" class="form-control" id="edit-nombre">
                    </div>
                    <div class="mb-3">
                        <label for="edit-apellido_p" class="form-label">Apellido Paterno</label>
                        <input type="text" class="form-control" id="edit-apellido_p">
                    </div>
                    <div class="mb-3">
                        <label for="edit-apellido_m" class="form-label">Apellido Materno</label>
                        <input type="text" class="form-control" id="edit-apellido_m">
                    </div>
                    <div class="mb-3">
                        <label for="edit-correo" class="form-label">Correo</label>
                        <input type="email" class="form-control" id="edit-correo">
                    </div>
                    <div class="mb-3">
                        <label for="edit-telefono" class="form-label">Teléfono</label>
                        <input type="text" class="form-control" id="edit-telefono">
                    </div>
                    <div class="mb-3">
                        <label for="edit-edad" class="form-label">Edad</label>
                        <input type="number" class="form-control" id="edit-edad">
                    </div>
                    <button type="submit" class="btn btn-primary">Guardar Cambios</button>
                </form>
            </div>
        </div>
    </div>
</div>

</body>
</html>