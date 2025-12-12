@echo off
:: Script para arrancar varios servidores FastAPI en diferentes puertos
:: Uso: run.bat [--dev] [--stop]

:: Establecer la ruta base
set BASE_DIR=%~dp0
cd /d %BASE_DIR%

:: Verificar si se solicita detener servidores
if "%1"=="--stop" (
    echo Deteniendo servidores...
    taskkill /f /im uvicorn.exe >nul 2>&1
    echo Servidores detenidos.
    goto :eof
)

:: Activar entorno virtual si existe
if exist .venv\Scripts\activate.bat (
    call .venv\Scripts\activate.bat
    echo Entorno virtual activado.
) else (
    echo Advertencia: No se encontro entorno virtual en .venv
)

:: Verificar si uvicorn esta instalado
uvicorn --version >nul 2>&1
if errorlevel 1 (
    echo Error: uvicorn no esta instalado. Instala con: pip install uvicorn
    goto :eof
)

:: Definir puertos
set PORT1=3000
set PORT2=3001
set PORT3=3002
set PORT4=3003

:: Verificar si incluye la bandera --dev
if "%1"=="--dev" (
    set UVICORN_CMD=uvicorn --reload
    echo Iniciando servidores en modo desarrollo con recarga automatica...
) else (
    set UVICORN_CMD=uvicorn
    echo Iniciando servidores en modo produccion...
)

:: Arrancar los servidores en diferentes puertos
start "Server 1" cmd /k "%UVICORN_CMD% apis.server1.main:app --host 0.0.0.0 --port %PORT1%"
start "Server 2" cmd /k "%UVICORN_CMD% apis.server2.main:app --host 0.0.0.0 --port %PORT2%"
start "Server 3" cmd /k "%UVICORN_CMD% apis.server3.main:app --host 0.0.0.0 --port %PORT3%"
start "Server 4" cmd /k "%UVICORN_CMD% apis.server4.main:app --host 0.0.0.0 --port %PORT4%"

echo Servidores iniciados en puertos %PORT1%, %PORT2%, %PORT3%, %PORT4%

