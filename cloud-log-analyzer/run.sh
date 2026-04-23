#!/usr/bin/env bash
# =============================================================================
# Autor: Pablohzdev: Hernández López Pablo - 23211987
# Curso: Arquitectura de Computadoras / Ensamblador ARM64
# Práctica: Mini Cloud Log Analyzer (Variante A)
# Fecha: Abril 2026
#
# Descripción:
# Script de ejecución automatizada para el programa "analyzer".
# Este script compila el proyecto (si es necesario) y ejecuta el analizador
# de logs utilizando como entrada el archivo de prueba logs_A.txt.
#
# Funcionamiento:
# - Verifica si el binario ./analyzer existe y es ejecutable
# - Si no existe, ejecuta 'make' para compilar el proyecto
# - Detecta la arquitectura del sistema:
#     * ARM64 (aarch64): ejecución nativa
#     * x86_64: ejecución mediante emulación con qemu-aarch64
# - Envía el archivo de logs como entrada estándar al programa
#
# Notas:
# - Este script forma parte de una práctica académica enfocada en el uso de
#   syscalls en ARM64 sin libc.
# - Facilita la validación rápida del funcionamiento del programa. 
# =============================================================================


set -euo pipefail

if [[ ! -x ./analyzer ]]; then
  echo "[INFO] No existe ./analyzer o no tiene permisos de ejecución. Ejecutando make..."
  make
fi

if [[ $(uname -m) == "aarch64" ]]; then
  # Ejecución nativa en ARM64 (escenario esperado en AWS Ubuntu 24 ARM64).
  cat data/logs_A.txt | ./analyzer
elif command -v qemu-aarch64 >/dev/null 2>&1; then
  # Ejecución emulada para quienes trabajan en host x86_64.
  cat data/logs_A.txt | qemu-aarch64 ./analyzer
else
  echo "[ERROR] Este host no es ARM64 y no se encontró qemu-aarch64." >&2
  echo "        Ejecute esta práctica en AWS Ubuntu 24 ARM64." >&2
  exit 1
fi
