FROM python:3.14-slim

# Establecer directorio de trabajo
WORKDIR /app

# Copiar archivos de dependencias
COPY pyproject.toml uv.lock ./

# Instalar uv y dependencias
RUN pip install uv && uv sync --frozen --no-install-project

# Copiar el código fuente
COPY apis/ ./apis/
COPY entrypoint.sh ./

# Hacer ejecutable el script
RUN chmod +x entrypoint.sh

# Exponer puertos
EXPOSE 3000 3001 3002 3003

# Comando para ejecutar los servidores
CMD ["./entrypoint.sh"]