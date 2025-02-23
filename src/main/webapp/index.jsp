<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <title>Inicio de Sesión</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
</head>
<body class="d-flex justify-content-center align-items-center vh-100 bg-light">

<div class="card p-4 shadow" style="width: 350px;">
    <h3 class="text-center mb-3">Iniciar Sesión</h3>

    <!-- Mensaje de alerta -->
    <div id="mensaje" class="alert d-none"></div>

    <form id="loginForm">
        <div class="mb-3">
            <label for="correo" class="form-label">Correo Electrónico</label>
            <input type="email" name="correo" pattern="^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\\.[a-zA-Z]{2,}$" class="form-control" id="correo" required>
        </div>
        <div class="mb-3">
            <label for="contra" class="form-label">Contraseña</label>
            <input type="password" name="contra" class="form-control" id="contra" required>
        </div>
        <button type="submit" class="btn btn-primary w-100">Ingresar</button>
    </form>
</div>

<script>
    document.getElementById('loginForm').addEventListener('submit', async (e) => {
        e.preventDefault(); // Evita el envío tradicional del formulario

        // Muestra la alerta de carga
        Swal.fire({
            title: 'Iniciando sesión',
            text: 'Por favor espere...',
            allowOutsideClick: false,
            didOpen: () => {
                Swal.showLoading();
            },
        });

        // Obtenemos los datos del formulario
        const formData = new FormData(e.target);
        const data = {
            correo: formData.get('correo'),
            contra: formData.get('contra')
        };
        console.log(data)
        try {
            // Esperamos la respuesta del servidor
            const response = await fetch("signIn", {
                method: "POST",
                headers: { "Content-Type": "application/json" },
                body: JSON.stringify(data)
            });

            const result = await response.json();
            console.log(result)

            if (result === "Inicio de sesión exitoso") {
                await Swal.fire({
                    icon: "success",
                    title: "Bienvenido",
                    text: "Inicio de sesión exitoso",
                    timer: 1500,
                    showConfirmButton: false
                });
                window.location.href = "home.jsp";
            } else {
                Swal.fire({
                    icon: "error",
                    title: "Error",
                    text: "Credenciales incorrectas",
                });
            }
        } catch (error) {
            Swal.fire({
                icon: "error",
                title: "Error",
                text: "Error en el servidor",
            });
            console.error("Error:", error);
        }
    });
</script>

</body>
</html>
