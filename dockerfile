FROM node:18-alpine

# ----- Instalar dependencias mínimas -----
RUN apk add --no-cache \
    bash \
    curl \
    git \
    sqlite \
    tzdata

# ----- Crear directorio de trabajo -----
WORKDIR /home/node

# ----- Instalar n8n versión estable y liviana -----
RUN npm install -g n8n@1.10.0

# ----- Ajustes de RAM -----
ENV NODE_OPTIONS="--max-old-space-size=256"

# ----- Forzar que use el disco de Render -----
ENV N8N_USER_FOLDER=/home/node/.n8n
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# ----- Crear carpeta si no existe -----
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node/.n8n

# Usar usuario node (NO root)
USER node

EXPOSE 5678

CMD ["n8n"]
