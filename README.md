
# 02-Prueba: Microservicios con FastAPI

Sistema de cuatro microservicios independientes construido con **FastAPI** y **Uvicorn**, ejecutados en puertos diferentes para demostración y pruebas. Compatible con Windows, Linux y macOS.

## Requisitos Previos

- **Python 3.14+**
- **pip** o **uv** (gestor de paquetes)
- **Sistema operativo**: Windows (usa `run.bat`), Linux (usa `run.sh`), macOS (usa `run.macos.sh`)

## Instalación de Herramientas

### 1. Instalar Python
Descarga e instala desde [python.org](https://www.python.org/). Verifica la instalación:
```bash
python --version
```

### 2. Instalar UV (opcional pero recomendado)
```bash
pip install uv
```

### 3. Instalar Dependencias del Proyecto
```bash
# Con uv (recomendado)
uv sync

# O con pip
pip install -r requirements.txt
```

## Instalación de Herramientas

### 1. Instalar Python
Descarga e instala desde [python.org](https://www.python.org/). Verifica la instalación:
```bash
python --version
```

### 2. Instalar UV (opcional pero recomendado)
```bash
pip install uv
```

### 3. Instalar Dependencias del Proyecto
```bash
# Con uv (recomendado)
uv sync

# O con pip
pip install -r requirements.txt
```

## Estructura del Proyecto

```
02-prueba/
├── apis/
│   ├── server1/
│   │   ├── main.py
│   │   └── __pycache__/
│   ├── server2/
│   │   ├── main.py
│   │   └── __pycache__/
│   ├── server3/
│   │   ├── main.py
│   │   └── __pycache__/
│   └── server4/
│       ├── main.py
│       └── __pycache__/
├── run.bat          # Script para Windows
├── run.sh           # Script para Linux
├── run.macos.sh     # Script para macOS
├── pyproject.toml
├── uv.lock
└── README.md
```

## Ejecución del Proyecto

### Opción 1: Usar los Scripts Automáticos

#### Windows (run.bat)
**Modo Producción:**
```bash
run.bat
```

**Modo Desarrollo (con recarga automática):**
```bash
run.bat --dev
```

**Detener los Servidores:**
```bash
run.bat --stop
```

#### Linux (run.sh)
**Modo Producción:**
```bash
./run.sh
```

**Modo Desarrollo (con recarga automática):**
```bash
./run.sh --dev
```

**Detener los Servidores:**
```bash
./run.sh --stop
```

#### macOS (run.macos.sh)
**Modo Producción:**
```bash
./run.macos.sh
```

**Modo Desarrollo (con recarga automática):**
```bash
./run.macos.sh --dev
```

**Detener los Servidores:**
```bash
./run.macos.sh --stop
```

### Opción 2: Ejecutar Manualmente

```bash
# Server 1 - Puerto 3000
uvicorn apis.server1.main:app --host 0.0.0.0 --port 3000

# Server 2 - Puerto 3001
uvicorn apis.server2.main:app --host 0.0.0.0 --port 3001

# Server 3 - Puerto 3002
uvicorn apis.server3.main:app --host 0.0.0.0 --port 3002

# Server 4 - Puerto 3003
uvicorn apis.server4.main:app --host 0.0.0.0 --port 3003
```

## Puertos Disponibles

| Servidor | Puerto | URL |
|----------|--------|-----|
| Server 1 | 3000 | http://localhost:3000 |
| Server 2 | 3001 | http://localhost:3001 |
| Server 3 | 3002 | http://localhost:3002 |
| Server 4 | 3003 | http://localhost:3003 |

Accede a la documentación interactiva (Swagger UI) en: `http://localhost:{puerto}/docs`

## Dependencias

- **fastapi** - Framework web moderno y rápido
- **uvicorn[standard]** - Servidor ASGI con soporte para hot-reload

## Docker y Kubernetes

### Construir y Ejecutar con Docker Compose (Desarrollo Local)

```bash
# Construir y ejecutar
docker-compose up --build

# Acceder a los servicios via Nginx en localhost:80
# Ej: http://localhost/api/server1/docs
```

### Desplegar en Kubernetes

1. **Construir la imagen Docker:**
   ```bash
   docker build -t your-registry/fastapi-app:latest .
   docker push your-registry/fastapi-app:latest
   ```

2. **Configurar Rathole:**
   - Edita `rathole.toml` y `k8s-deployment.yaml` con la dirección de tu servidor Rathole.

3. **Aplicar manifests:**
   ```bash
   kubectl apply -f k8s-deployment.yaml
   ```

4. **Escalar réplicas:**
   ```bash
   kubectl scale deployment fastapi-app --replicas=3
   ```

5. **Acceder:**
   - Via Nginx Service: `kubectl get svc nginx-service`
   - Rathole expondrá los puertos externamente según configuración.
