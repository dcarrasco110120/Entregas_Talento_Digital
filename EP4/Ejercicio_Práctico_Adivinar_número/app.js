// app.js - Juego: Adivina el número (1 al 10)

// --- PASO 1: Generar el número secreto aleatorio ---
// Math.random() genera un número decimal entre 0 y 1 (ejemplo: 0.743)
// Al multiplicarlo por 10 obtengo un número entre 0 y 9.99
// Math.floor() lo redondea hacia abajo (quita los decimales)
// Al sumarle 1, el rango pasa a ser entre 1 y 10
const secreto = Math.floor(Math.random() * 10) + 1;

// Para depuración: puedo ver el número en consola mientras desarrollo
// console.log("Número secreto:", secreto); // <-- descomentar para hacer pruebas

// --- PASO 2: Preparar las variables del juego ---
var intentosRestantes = 3;   // el usuario tiene 3 oportunidades
var usados = [];             // array vacío donde voy guardando los números ya ingresados
var gano = false;            // bandera para saber si el usuario adivinó

// --- PASO 3: Función para detectar números repetidos ---
// Recibe un número y el array de intentos previos
// Retorna true si el número ya fue usado, false si es nuevo
function yaUsado(numero, lista) {
    return lista.includes(numero);
}

// --- PASO 4: Ciclo principal del juego ---
// El juego sigue mientras queden intentos Y el usuario no haya adivinado
while (intentosRestantes > 0 && !gano) {

    // Pido el número al usuario con prompt()
    // parseInt() convierte el texto ingresado en un número entero
    var entrada = parseInt(prompt(
        "🎯 Adivina el número (1 al 10)\n" +
        "Intentos restantes: " + intentosRestantes + "\n" +
        (usados.length > 0 ? "Números ya usados: " + usados.join(", ") : "")
    ));

    // --- Validación 1: Verifico que sea un número válido entre 1 y 10 ---
    // isNaN() retorna true si el valor NO es un número (ej: si el usuario escribió letras)
    if (isNaN(entrada) || entrada < 1 || entrada > 10) {
        alert("⚠️ Número fuera de rango. Debes ingresar un número entre 1 y 10.");
        // No resto intento, el ciclo vuelve a empezar
        continue;
    }

    // --- Validación 2: Verifico que no haya usado este número antes ---
    if (yaUsado(entrada, usados)) {
        alert("🔁 Ya usaste el número " + entrada + ". Elige uno diferente.");
        // No resto intento, el ciclo vuelve a empezar
        continue;
    }

    // --- Si llegó hasta aquí, el número es válido: lo agrego al array ---
    usados.push(entrada);

    // --- Comparo con el número secreto ---
    if (entrada === secreto) {
        // ¡Adivinó!
        gano = true;
        alert("🎉 ¡Adivinaste! El número era " + secreto + ".\nUsaste " + usados.length + " intento(s).");
    } else {
        // No adivinó: resto un intento y aviso cuántos quedan
        intentosRestantes--;

        if (intentosRestantes > 0) {
            // Todavía tiene intentos: doy una pista
            var pista = entrada < secreto ? "El número secreto es MAYOR." : "El número secreto es MENOR.";
            alert("❌ Incorrecto. " + pista + "\nIntentos restantes: " + intentosRestantes);
        }
    }
}

// --- PASO 5: Mensaje final si se acabaron los intentos sin adivinar ---
if (!gano) {
    alert("😢 Sin aciertos. El número era: " + secreto);
}

// --- PASO 6: Mostrar el historial de intentos en la página ---
// Busco el elemento con id="historial" en el HTML y cambio su contenido
var divHistorial = document.getElementById("historial");

if (gano) {
    divHistorial.innerHTML =
        "<strong>🎉 ¡Ganaste!</strong><br>" +
        "El número secreto era: <strong>" + secreto + "</strong><br>" +
        "Intentos usados: " + usados.join(", ");
} else {
    divHistorial.innerHTML =
        "<strong>😢 Perdiste</strong><br>" +
        "El número secreto era: <strong>" + secreto + "</strong><br>" +
        "Intentos usados: " + usados.join(", ");
}
