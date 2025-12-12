#!/bin/bash

# Script para arrancar varios servidores FastAPI en diferentes puertos
# Uso: run.sh [--dev] [--stop]

# Establecer la ruta base
BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$BASE_DIR"

# Verificar si se solicita detener servidores
if [ "$1" == "--stop" ]; then
    echo "Deteniendo servidores..."
    pkill -f "uvicorn" 2>/dev/null
    echo "Servidores detenidos."
    exit 0
fi

# Activar entorno virtual si existe
if [ -f ".venv/bin/activate" ]; then
    source .venv/bin/activate
    echo "Entorno virtual activado."
else
    echo "Advertencia: No se encontró entorno virtual en .venv"
fi

# Verificar si uvicorn está instalado
if ! command -v uvicorn &> /dev/null; then
    echo "Error: uvicorn no está instalado. Instala con: pip install uvicorn"
    exit 1
fi

# Definir puertos
PORT1=3000
PORT2=3001
PORT3=3002
PORT4=3003

# Verificar si incluye la bandera --dev
if [ "$1" == "--dev" ]; then
    UVICORN_CMD="uvicorn --reload"
    echo "Iniciando servidores en modo desarrollo con recarga automática..."
else
    UVICORN_CMD="uvicorn"
    echo "Iniciando servidores en modo producción..."
fi

# Arrancar los servidores en diferentes puertos
nohup $UVICORN_CMD apis.server1.main:app --host 0.0.0.0 --port $PORT1 > server1.log 2>&1 &
nohup $UVICORN_CMD apis.server2.main:app --host 0.0.0.0 --port $PORT2 > server2.log 2>&1 &
nohup $UVICORN_CMD apis.server3.main:app --host 0.0.0.0 --port $PORT3 > server3.log 2>&1 &
nohup $UVICORN_CMD apis.server4.main:app --host 0.0.0.0 --port $PORT4 > server4.log 2>&1 &

echo "Servidores iniciados en puertos $PORT1, $PORT2, $PORT3, $PORT4"