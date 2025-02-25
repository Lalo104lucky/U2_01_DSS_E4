<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Persona</title>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex items-center justify-center h-screen">

<style>
    html, body {
        background: linear-gradient(to right, #6a11cb, #2575fc);
        height: 100vh;
        display: flex;
        justify-content: center;
        align-items: center;
    }

    .register-card {
        position: absolute;
        width: 100%;
        background: white;
        left: 50%;
        transform: translateX(-50%);
    }
</style>

<div class="bg-white p-8 rounded-lg shadow-lg w-full max-w-lg register-card">
    <h2 class="text-2xl font-bold text-center mb-4 text-gray-900">Registrar Persona</h2>
    <form id="registerForm">

        <div>
            <label for="nombre" class="block mb-2 text-sm font-medium text-gray-900">Nombre</label>
            <input type="text" id="nombre" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="Ingrese su nombre" required>
        </div>

        <div>
            <label for="apellido_p" class="block mb-2 text-sm font-medium text-gray-900">Apellido Paterno</label>
            <input type="text" id="apellido_p" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="Ingrese su apellido paterno" required>
        </div>

        <div>
            <label for="apellido_m" class="block mb-2 text-sm font-medium text-gray-900">Apellido Materno</label>
            <input type="text" id="apellido_m" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="Ingrese su apellido materno" required>
        </div>

        <div>
            <label for="correo" class="block mb-2 text-sm font-medium text-gray-900">Correo Electrónico</label>
            <input type="email" id="correo" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="correo@example.com" required>
        </div>

        <div>
            <label for="telefono" class="block mb-2 text-sm font-medium text-gray-900">Teléfono</label>
            <input type="text" id="telefono" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="10 dígitos" required>
        </div>

        <div>
            <label for="edad" class="block mb-2 text-sm font-medium text-gray-900">Edad</label>
            <input type="number" id="edad" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="Edad" required>
        </div>

        <div>
            <label for="contrasena" class="block mb-2 text-sm font-medium text-gray-900">Contraseña</label>
            <input type="password" id="contrasena" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="********" required>
        </div>

        <div>
            <label for="confirmarContrasena" class="block mb-2 text-sm font-medium text-gray-900">Confirmar Contraseña</label>
            <input type="password" id="confirmarContrasena" class="bg-gray-50 border border-gray-300 text-gray-900 text-sm rounded-lg focus:ring-blue-500 focus:border-blue-500 block w-full p-2.5" placeholder="********" required>
        </div>

        <div class="mt-4">
            <button type="submit" class="w-full bg-blue-500 text-white p-2 rounded-lg hover:bg-blue-600">Registrar</button>
        </div>
    </form>
</div>

<script>
    document.getElementById('registerForm').addEventListener('submit', async (event) => {
        event.preventDefault();

        const nombre = document.getElementById('nombre').value.trim();
        const apellido_p = document.getElementById('apellido_p').value.trim();
        const apellido_m = document.getElementById('apellido_m').value.trim();
        const correo = document.getElementById('correo').value.trim();
        const contrasena = document.getElementById('contrasena').value.trim();
        const confirmarContrasena = document.getElementById('confirmarContrasena').value.trim();
        const telefono = document.getElementById('telefono').value.trim();
        const edad = document.getElementById('edad').value.trim();

        const regexTelefono = /^[0-9]{10}$/;
        const regexContrasena = /^(?=.*[A-Z])(?=.*\d)(?=.*[\W_]).{8,}$/;

        if (!nombre || !apellido_p || !apellido_m || !correo || !contrasena || !confirmarContrasena || !telefono || !edad) {
            return Swal.fire({
                icon: 'warning',
                title: 'Campos vacíos',
                text: 'Todos los campos son obligatorios.',
            });
        }

        if (!regexTelefono.test(telefono)) {
            return Swal.fire({
                icon: 'error',
                title: 'Teléfono inválido',
                text: 'Debe tener exactamente 10 dígitos numéricos.',
            });
        }

        if (!regexContrasena.test(contrasena)) {
            return Swal.fire({
                icon: 'error',
                title: 'Contraseña insegura',
                text: 'Debe tener al menos 8 caracteres, una mayúscula, un número y un carácter especial.',
            });
        }

        if (contrasena !== confirmarContrasena) {
            return Swal.fire({
                icon: 'error',
                title: 'Contraseñas no coinciden',
                text: 'Las contraseñas ingresadas no son iguales.',
            });
        }

        Swal.fire({
            title: 'Actualizando...',
            text: 'Por favor espere...',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            },
        });

        const formData = { nombre, apellido_p, apellido_m, correo, contrasena, telefono, edad };


        try {
            const response = await fetch('registrar', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(formData)
            });


            const result = await response.json();

            if (result.success) {
                await Swal.fire({
                    icon: 'success',
                    title: 'Éxito',
                    text: 'Persona registrada correctamente',
                    timer: 1500,
                });
                window.location.href = "home.jsp";
            } else {
                Swal.fire({
                    icon: 'error',
                    title: 'Error',
                    text: 'No se pudo registrar la persona',
                });
            }
        } catch (error) {
            Swal.fire({ icon: 'error', title: 'Error', text: 'Error en el servidor' });
            console.error('Error:', error);
        }
    });
</script>

</body>
</html>
