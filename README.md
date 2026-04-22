# 🚀 Mini Cloud Log Analyzer (ARM64)

## 👤 Autor
- Nombre: *Pablo Hernández López*
- Curso: Arquitectura de Computadoras / Ensamblador ARM64  
- Fecha: 22 de Abril 2026  

---

## 📌 Descripción

Este proyecto consiste en la implementación de un **analizador de logs simplificado** en **ARM64 Assembly (AArch64)**, ejecutado sobre Linux sin el uso de librerías estándar (libc), utilizando únicamente **syscalls del sistema operativo**.

El programa procesa códigos de estado HTTP recibidos a través de la entrada estándar (`stdin`) y los clasifica según su tipo.

---
## 🎥 Asciicinema

[Testing](https://asciinema.org/a/UTfG1eXhGSMzoBuB)

[Testing with 1000 numbers](https://asciinema.org/a/qaWfQpcgzaxUMcYE)



## 🎯 Variante implementada

### ✅ Variante A

Se contabilizan los siguientes tipos de códigos HTTP:

- **2xx** → Respuestas exitosas  
- **4xx** → Errores del cliente  
- **5xx** → Errores del servidor  

---

## ⚙️ Funcionamiento

El programa sigue el siguiente flujo:
1. Leer datos desde stdin usando syscall read
2. Procesar byte por byte
3. Convertir texto a número (parseo manual)
4. Clasificar el código HTTP
5. Incrementar contadores
6. Imprimir resultados con syscall write
7. Finalizar ejecución con syscall exit

---

## 🧠 Pseudocódigo

Inicializar contadores en 0

Mientras haya datos en stdin:
leer bloque
recorrer cada byte:
si es dígito:
construir número
si es salto de línea:
clasificar número
reiniciar acumulador

Si queda número pendiente:
clasificarlo

Imprimir resultados

---

## 🧩 Tecnologías utilizadas

- ARM64 Assembly (GNU Assembler)
- Linux Syscalls (`read`, `write`, `exit`)
- Bash
- GNU Make
- AWS Ubuntu ARM64

---

## 🏗️ Estructura del proyecto

.
├── src/
│   └── analyzer.s
├── data/
│   └── logs_A.txt
├── run.sh
├── Makefile
└── README.md

---

## 🛠️ Compilación

```bash
make
./run.sh
cat data/logs_A.txt | ./analyzer
```

## ✅ Salida esperada

=== Mini Cloud Log Analyzer ===
Éxitos 2xx: 4
Errores 4xx: 3
Errores 5xx: 3

---

## ⚠️ Consideraciones técnicas

* Se utiliza parsing manual de enteros (sin funciones de C)
* Se manejan buffers de entrada de tamaño fijo (4096 bytes)
* Se implementa control de estado para detectar números válidos
* Se respeta la arquitectura ARM64 y sus convenciones
* No se utilizan librerías externas

---

## 🧠 Aspectos importantes de ARM64

* Uso de registros (x0–x30)
* Uso de syscall mediante svc
* Manejo de memoria con direccionamiento base + offset
* Control de flujo con saltos condicionales (b, cmp)

⸻

## 🐞 Pruebas realizadas

Se realizaron pruebas con:

* Datos de entrada proporcionados (logs_A.txt)
* Casos con múltiples líneas
* Casos con valores fuera de rango (ej. 3xx)
* Validación de conteo correcto

⸻

## 🚧 Posibles mejoras

* Contar códigos inválidos
* Calcular porcentaje de éxito
* Implementar otras variantes (B, C, D, E)
* Optimizar acceso a memoria
* Manejo de errores más robusto

⸻

## 🎯 Conclusión

Esta práctica permitió comprender cómo un problema común de procesamiento de datos puede ser implementado a bajo nivel utilizando instrucciones de máquina en ARM64.

Se reforzaron conceptos clave como:

* manejo de memoria
* uso de registros
* control de flujo
* interacción directa con el sistema operativo

Además, se evidenció la complejidad adicional que implica trabajar sin abstracciones de alto nivel, pero también el control total que se obtiene sobre la ejecución.

⸻

## 📎 Evidencia

Ejemplo de ejecución:
$ ./run.sh
=== Mini Cloud Log Analyzer ===
Éxitos 2xx: 4
Errores 4xx: 3
Errores 5xx: 3

## 🧠 Reflexión personal

El desarrollo en ensamblador permite entender profundamente cómo funciona la computadora a nivel interno, desde el manejo de datos hasta la ejecución de instrucciones.

Aunque este tipo de implementación es más compleja que en lenguajes de alto nivel, es fundamental para comprender sistemas operativos, compiladores y software de alto rendimiento.



