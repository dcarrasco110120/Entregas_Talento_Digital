// app.js - Evaluación Final: Administrador de Usuarios
// Autor: Diego Carrasco
// Repositorio: https://github.com/dcarrasco110120/Entregas_Talento_Digital

// =====================================================
// CLASE: AdminUsuarios
// Administra la data obtenida desde el web service
// https://jsonplaceholder.typicode.com/users
// =====================================================

class AdminUsuarios {

    constructor() {
        // El array donde voy a guardar los usuarios una vez que lleguen de la API
        this.usuarios = [];

        // Referencia al div donde muestro los resultados en pantalla
        this.resultado = document.getElementById("resultado");
        this.estado = document.getElementById("estado");

        // Llamo al método que obtiene los datos apenas se crea la clase
        this.obtenerDatos();
    }

    // --- MÉTODO: Obtener datos desde la API usando XMLHttpRequest ---
    // XMLHttpRequest es la forma clásica de hacer peticiones HTTP en JavaScript
    obtenerDatos() {

        // Creo una nueva instancia de XMLHttpRequest
        var xhr = new XMLHttpRequest();

        // Guardo referencia a "this" porque dentro del callback cambia el contexto
        var self = this;

        // Configuro la petición: método GET y la URL del endpoint
        xhr.open("GET", "https://jsonplaceholder.typicode.com/users");

        // Esta función se ejecuta cuando el servidor responde
        xhr.onload = function() {

            // Si el código de respuesta es 200, significa que todo salió bien
            if (xhr.status === 200) {

                // JSON.parse() convierte el texto de la respuesta en un array de objetos
                self.usuarios = JSON.parse(xhr.responseText);

                // Verifico en consola que los datos llegaron bien
                console.log("Usuarios cargados:", self.usuarios);

                // Actualizo el mensaje de estado en la página
                self.estado.textContent = "✅ Datos cargados correctamente. Usa los botones.";

            } else {
                self.estado.textContent = "❌ Error al obtener los datos de la API.";
                console.error("Error HTTP:", xhr.status);
            }
        };

        // Esta función se ejecuta si hay un error de red (sin internet, etc.)
        xhr.onerror = function() {
            self.estado.textContent = "❌ Error de red. Verifica tu conexión.";
            console.error("Error de red al conectar con la API.");
        };

        // Envío la petición
        xhr.send();
    }

    // --- MÉTODO AUXILIAR: Muestra texto en el div de resultados ---
    mostrar(texto) {
        this.resultado.textContent = texto;
    }

    // --- MÉTODO AUXILIAR: Verifica que los datos ya estén cargados ---
    datosListos() {
        if (this.usuarios.length === 0) {
            this.mostrar("⏳ Los datos aún no han cargado. Espera un momento e intenta de nuevo.");
            return false;
        }
        return true;
    }

    // --- MÉTODO AUXILIAR: Busca un usuario por nombre usando prompt() ---
    // Retorna el objeto usuario si lo encuentra, o null si no existe
    buscarPorNombre(pregunta) {
        var nombreIngresado = prompt(pregunta);

        // Si el usuario canceló el prompt, retorno null
        if (nombreIngresado === null) return null;

        // .find() busca el primer elemento que cumpla la condición
        // toLowerCase() convierte a minúsculas para que la búsqueda no distinga mayúsculas
        var usuario = this.usuarios.find(function(u) {
            return u.name.toLowerCase() === nombreIngresado.toLowerCase();
        });

        if (!usuario) {
            alert("No se encontró ningún usuario con el nombre: " + nombreIngresado);
            return null;
        }

        return usuario;
    }

    // =====================================================
    // MÉTODO 1: Listar los nombres de todos los usuarios
    // =====================================================
    listarNombres() {
        if (!this.datosListos()) return;

        // .map() recorre el array y extrae solo el nombre de cada usuario
        // .join() une todos los nombres en un solo string separado por saltos de línea
        var nombres = this.usuarios.map(function(u, indice) {
            return (indice + 1) + ". " + u.name;
        }).join("\n");

        this.mostrar("📋 LISTA DE USUARIOS:\n\n" + nombres);
        console.log("Lista de nombres:", nombres);
    }

    // =====================================================
    // MÉTODO 2: Buscar info básica de un usuario por nombre
    // Muestra: username y correo
    // =====================================================
    buscarInfoBasica() {
        if (!this.datosListos()) return;

        var usuario = this.buscarPorNombre("Ingresa el nombre del usuario (ej: Leanne Graham):");
        if (!usuario) return;

        var info =
            "🔍 INFORMACIÓN BÁSICA DE: " + usuario.name + "\n\n" +
            "Username : " + usuario.username + "\n" +
            "Correo   : " + usuario.email;

        this.mostrar(info);
        console.log("Info básica:", usuario.username, usuario.email);
    }

    // =====================================================
    // MÉTODO 3: Buscar dirección de un usuario por nombre
    // Muestra todos los campos de address
    // =====================================================
    buscarDireccion() {
        if (!this.datosListos()) return;

        var usuario = this.buscarPorNombre("Ingresa el nombre del usuario para ver su dirección:");
        if (!usuario) return;

        var dir = usuario.address;

        var info =
            "🏠 DIRECCIÓN DE: " + usuario.name + "\n\n" +
            "Calle   : " + dir.street + "\n" +
            "Suite   : " + dir.suite + "\n" +
            "Ciudad  : " + dir.city + "\n" +
            "Código  : " + dir.zipcode + "\n" +
            "Lat/Lng : " + dir.geo.lat + ", " + dir.geo.lng;

        this.mostrar(info);
        console.log("Dirección:", dir);
    }

    // =====================================================
    // MÉTODO 4: Buscar info avanzada de un usuario por nombre
    // Muestra: teléfono, sitio web y compañía (todos los campos)
    // =====================================================
    buscarInfoAvanzada() {
        if (!this.datosListos()) return;

        var usuario = this.buscarPorNombre("Ingresa el nombre del usuario para ver su info avanzada:");
        if (!usuario) return;

        var comp = usuario.company;

        var info =
            "📊 INFORMACIÓN AVANZADA DE: " + usuario.name + "\n\n" +
            "Teléfono    : " + usuario.phone + "\n" +
            "Sitio web   : " + usuario.website + "\n\n" +
            "🏢 COMPAÑÍA:\n" +
            "  Nombre      : " + comp.name + "\n" +
            "  Frase       : " + comp.catchPhrase + "\n" +
            "  Rubro       : " + comp.bs;

        this.mostrar(info);
        console.log("Info avanzada:", usuario.phone, usuario.website, comp);
    }

    // =====================================================
    // MÉTODO 5: Listar todas las compañías con su catchphrase
    // =====================================================
    listarCompanias() {
        if (!this.datosListos()) return;

        var lista = this.usuarios.map(function(u, indice) {
            return (indice + 1) + ". " + u.company.name + "\n   \"" + u.company.catchPhrase + "\"";
        }).join("\n\n");

        this.mostrar("🏢 COMPAÑÍAS Y SUS FRASES CLAVE:\n\n" + lista);
        console.log("Compañías listadas.");
    }

    // =====================================================
    // MÉTODO 6: Listar nombres ordenados alfabéticamente
    // =====================================================
    listarNombresOrdenados() {
        if (!this.datosListos()) return;

        // .slice() hace una copia del array para no modificar el original
        // .sort() ordena alfabéticamente por el campo name
        var ordenados = this.usuarios.slice().sort(function(a, b) {
            return a.name.localeCompare(b.name);
        });

        var lista = ordenados.map(function(u, indice) {
            return (indice + 1) + ". " + u.name;
        }).join("\n");

        this.mostrar("🔤 USUARIOS ORDENADOS ALFABÉTICAMENTE (A-Z):\n\n" + lista);
        console.log("Nombres ordenados:", lista);
    }
}

// =====================================================
// INSTANCIA: Creo el objeto de la clase
// Al crearse, el constructor llama automáticamente a la API
// =====================================================
var admin = new AdminUsuarios();
