// =======================================
// callbacks.js - Funciones Callback
// Ejercicio Práctico - Talento Digital
// =======================================


// Función 1: validar_numero
// Pide un dato con prompt() y valida si es un número
function validar_numero(callback) {
    let dato = prompt("Ingrese un número:");

    if (dato === null || dato.trim() === "") {
        callback(false, "No se ingresó ningún valor.");
        return;
    }

    if (!isNaN(dato)) {
        console.log("Dato válido: " + dato);
        callback(true, "El dato ingresado (" + dato + ") es un número válido.");
    } else {
        console.log("Dato inválido: " + dato);
        callback(false, "Usted ingresó caracteres incorrectos: \"" + dato + "\"");
    }
}


// Función 2: calcular_y_avisar_despues
// Calcula la sumatoria de impares entre 1 y numero
// Espera 5 segundos y luego ejecuta el callback
function calcular_y_avisar_despues(numero, callback) {
    let sumatoria = 0;

    for (let i = 1; i <= numero; i++) {
        if (i % 2 !== 0) {
            sumatoria += i;
        }
    }

    console.log("Sumatoria de impares hasta " + numero + " = " + sumatoria);
    console.log("Esperando 5 segundos...");

    setTimeout(function() {
        console.log("¡Callback ejecutado después de 5 segundos!");
        callback(sumatoria);
    }, 5000);
}


// Función 3: calcular_y_avisar_dependiendo
// Calcula sumatorias sucesivas de 1 hasta numero
// Si resultado < 1000 → callback, si resultado >= 1000 → callback_error
function calcular_y_avisar_dependiendo(numero, callback, callback_error) {
    let resultado = 0;
    let detalles = [];

    for (let i = 1; i <= numero; i++) {
        // Sumatoria parcial: 1 + 2 + ... + i
        let suma_i = 0;
        for (let j = 1; j <= i; j++) {
            suma_i += j;
        }
        resultado += suma_i;

        // Construir la expresión "1 + 2 + ... + i"
        let terminos = [];
        for (let k = 1; k <= i; k++) {
            terminos.push(k);
        }
        detalles.push({
            expresion: terminos.join(" + "),
            suma: suma_i
        });
    }

    console.log("Resultado total sumatorias sucesivas: " + resultado);

    if (resultado < 1000) {
        callback(numero, resultado, detalles);
    } else {
        callback_error(numero, resultado, detalles);
    }
}
