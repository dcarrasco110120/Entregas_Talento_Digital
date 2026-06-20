// app.js - Consumo de la API REST de Rick and Morty

// --- OPTIMIZACIÓN: Variable global para guardar los datos en memoria ---
// La primera vez que el usuario presiona el botón, se llama a la API.
// Las siguientes veces, se usan los datos ya guardados aquí (sin llamar a la API de nuevo).
var personajesGuardados = null;

// --- FUNCIÓN PRINCIPAL: Obtener personajes ---
function obtenerPersonajes() {

    // Si ya tenemos los datos en memoria, los usamos directamente (sin llamar a la API)
    if (personajesGuardados !== null) {
        console.log("Datos cargados desde memoria local (sin llamar a la API)");
        mostrarLista(personajesGuardados);
        return;
    }

    // Aviso al usuario que estoy cargando
    document.getElementById("estado").textContent = "Cargando datos desde la API...";

    // fetch() hace la petición HTTP al endpoint de la API
    fetch("https://rickandmortyapi.com/api/character/1,2,3,4,5,6,7,8,9,10")
        .then(function(respuesta) {
            return respuesta.json();
        })
        .then(function(datos) {
            // Guardo los datos en memoria para no volver a llamar a la API
            personajesGuardados = datos;
            console.log("Datos obtenidos desde la API:", personajesGuardados);
            document.getElementById("estado").textContent = "Datos cargados desde la API.";
            mostrarLista(personajesGuardados);
        })
        .catch(function(error) {
            document.getElementById("estado").textContent = "Error al conectar con la API.";
            console.error("Error:", error);
        });
}

// --- FUNCIÓN: Mostrar lista de personajes ---
function mostrarLista(personajes) {

    var lista = document.getElementById("lista-personajes");
    lista.innerHTML = "";

    // .map() recorre cada personaje y crea un <li> con su información
    personajes.map(function(p) {
        var item = document.createElement("li");
        item.textContent = "ID: " + p.id + " - Nombre: " + p.name + " - Especie: " + p.species;
        lista.appendChild(item);
    });

    document.getElementById("seccion-lista").style.display = "block";
}

// --- FUNCIÓN: Agrupar personajes por especie ---
function mostrarAgrupacion() {

    if (personajesGuardados === null) {
        alert("Primero debes obtener los personajes presionando el primer boton.");
        return;
    }

    // .reduce() agrupa los personajes en un objeto donde cada clave es una especie
    var agrupados = personajesGuardados.reduce(function(acumulador, personaje) {
        var especie = personaje.species;
        if (!acumulador[especie]) {
            acumulador[especie] = [];
        }
        acumulador[especie].push(personaje);
        return acumulador;
    }, {});

    // Ordeno las especies alfabéticamente
    var especiesOrdenadas = Object.keys(agrupados).sort();

    var contenedor = document.getElementById("agrupacion");
    contenedor.innerHTML = "";

    especiesOrdenadas.forEach(function(especie) {
        var titulo = document.createElement("p");
        titulo.className = "especie-titulo";
        titulo.textContent = especie;
        contenedor.appendChild(titulo);

        var lista = document.createElement("ul");
        agrupados[especie].forEach(function(p) {
            var item = document.createElement("li");
            item.textContent = "- " + p.name + " (ID: " + p.id + ")";
            lista.appendChild(item);
        });
        contenedor.appendChild(lista);
    });

    document.getElementById("seccion-agrupacion").style.display = "block";
}

// --- FUNCIÓN: Mostrar ficha individual de Rick Sanchez (ID: 1) ---
function mostrarFicha() {

    if (personajesGuardados === null) {
        alert("Primero debes obtener los personajes presionando el primer boton.");
        return;
    }

    // .filter() busca el personaje con id === 1 dentro del array
    var rick = personajesGuardados.filter(function(p) {
        return p.id === 1;
    })[0];

    var contenedor = document.getElementById("ficha");
    contenedor.innerHTML =
        '<img src="' + rick.image + '" alt="Imagen de ' + rick.name + '">' +
        '<div class="ficha-info">' +
            '<p><strong>ID:</strong> ' + rick.id + '</p>' +
            '<p><strong>Nombre:</strong> ' + rick.name + '</p>' +
            '<p><strong>Especie:</strong> ' + rick.species + '</p>' +
        '</div>';

    document.getElementById("seccion-ficha").style.display = "block";
}
