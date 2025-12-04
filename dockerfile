# ======================================================
# n8n ultralight build (perfecto para 512MB en Render)
# Versión recomendada: 0.229.0 (muy estable y liviana)
# ======================================================

FROM node:18-alpine

# ----- Variables de entorno base -----
ENV NODE_ENV=production
ENV NODE_OPTIONS="--max-old-space-size=256"

# ----- Instalar dependencias necesarias -----
RUN apk add --no-cache \
    bash \
    curl \
    git \
    sqlite \
    tzdata

# ----- Crear directorio para n8n -----
WORKDIR /data

# ----- Instalar n8n versión ligera -----
RUN npm install -g n8n@0.229.0

# ----- Crear directorios necesarios -----
RUN mkdir /root/.n8n && \
    mkdir /data && \
    chmod -R 755 /root/.n8n /data

# ----- Puerto estándar de n8n -----
EXPOSE 5678

# ======================================================
# OPTIMIZACIONES PARA REDUCIR RAM
# ======================================================

# 🚫 Desactivar Task Runners (consumen mucha RAM)
ENV N8N_RUNNERS_ENABLED=false

# 🚫 Modo de ejecución clásico (no usa broker adicional)
ENV EXECUTIONS_MODE=regular

# 🚫 Evitar clusterización (innecesario en Render Starter)
ENV N8N_DISABLE_PRODUCTION_MAIN_PROCESS=true

# 🚫 Reducir tamaño de logs en memoria
ENV N8N_LOG_LEVEL=info

# 🚫 SQLite sin pool (sin consumo extra)
ENV DB_TYPE=sqlite
ENV DB_SQLITE_POOL_SIZE=0

# ----- Evitar crecimientos innecesarios -----
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=false

# ------------------------------------------------------
# ENTRYPOINT
# ------------------------------------------------------
CMD ["n8n"]
