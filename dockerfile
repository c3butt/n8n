FROM node:18-alpine

# ----- Instalar dependencias mínimas -----
RUN apk add --no-cache \
    bash \
    curl \
    git \
    sqlite \
    tzdata

# ----- Directorio de trabajo -----
WORKDIR /home/node

# ----- Instalar n8n versión estable -----
RUN npm install -g n8n@1.120.0

# ----- Ajustes de RAM para Render Starter -----
ENV NODE_OPTIONS="--max-old-space-size=256"

# ----- Configurar ruta fija DEL DISCO en Render -----
# Render monta el disco EXACTAMENTE en /home/node/.n8n
ENV N8N_USER_FOLDER=/home/node/.n8n

# Reparar permisos automáticamente
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# ----- Crear la carpeta para que Render pueda montarla -----
# IMPORTANTE: no escribir nada dentro, solo crearla.
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node

# ----- Ejecutar como usuario "node" -----
USER node

EXPOSE 5678

CMD ["n8n"]
