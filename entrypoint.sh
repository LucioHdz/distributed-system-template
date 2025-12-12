#!/bin/bash

# Lanzar servidores en background
uv run uvicorn apis.server1.main:app --host 0.0.0.0 --port 3000 &
uv run uvicorn apis.server2.main:app --host 0.0.0.0 --port 3001 &
uv run uvicorn apis.server3.main:app --host 0.0.0.0 --port 3002 &
uv run uvicorn apis.server4.main:app --host 0.0.0.0 --port 3003 &

# Mantener el contenedor corriendo
wait