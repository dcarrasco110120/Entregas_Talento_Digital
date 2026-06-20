// app.js - Ordenamiento Burbuja: mayor y menor de tres números

// --- PASO 1: Crear el array vacío donde voy a guardar los números ---
// Un array es como una lista, empieza vacía y le voy agregando valores
var numeros = [];

// --- PASO 2: Pedir los 3 números al usuario con prompt() ---
// prompt() muestra una ventanita donde el usuario puede escribir
// parseFloat() convierte el texto que escribe el usuario en un número decimal
var numero1 = parseFloat(prompt("Ingresa el primer número:"));
var numero2 = parseFloat(prompt("Ingresa el segundo número:"));
var numero3 = parseFloat(prompt("Ingresa el tercer número:"));

// --- PASO 3: Guardar los números en el array con push() ---
// push() agrega un elemento al final del array
numeros.push(numero1);
numeros.push(numero2);
numeros.push(numero3);

// --- PASO 4: Ordenamiento Burbuja con ciclo do-while ---
// La idea del burbuja es comparar dos números seguidos y si el de la izquierda
// es mayor que el de la derecha, los intercambia. Repite esto hasta que
// el array esté ordenado de menor a mayor.

var huboIntercambio; // variable que me dice si hubo algún cambio en la pasada

do {
    // Al inicio de cada pasada asumo que no hubo intercambios
    huboIntercambio = false;

    // Recorro el array comparando elementos uno al lado del otro
    for (var i = 0; i < numeros.length - 1; i++) {

        // Si el número de la izquierda es mayor que el de la derecha, los cambio de lugar
        if (numeros[i] > numeros[i + 1]) {

            // Guardo el valor de la izquierda en una variable temporal para no perderlo
            var temporal = numeros[i];

            // Pongo el de la derecha en la posición izquierda
            numeros[i] = numeros[i + 1];

            // Pongo el temporal (antes izquierda) en la posición derecha
            numeros[i + 1] = temporal;

            // Marco que hubo un intercambio, así el do-while sabe que debe repetirse
            huboIntercambio = true;
        }
    }

// El ciclo se repite mientras sigan habiendo intercambios
} while (huboIntercambio);

// --- PASO 5: Identificar el menor y el mayor ---
// Después del ordenamiento burbuja, el array queda de menor a mayor
// El primero (posición 0) es el menor, el último es el mayor
var menor = numeros[0];
var mayor = numeros[numeros.length - 1];

// --- PASO 6: Mostrar el resultado ---
// Primero reviso si los tres números son iguales
if (menor === mayor) {
    // Si el menor y el mayor son el mismo valor, los tres son idénticos
    document.write("<h2>Los tres números ingresados son idénticos: " + mayor + "</h2>");
} else {
    // Si son distintos, muestro el mayor y el menor
    document.write("<h2>Número mayor: " + mayor + "</h2>");
    document.write("<h2>Número menor: " + menor + "</h2>");
    document.write("<p>Array ordenado: " + numeros + "</p>");
}
