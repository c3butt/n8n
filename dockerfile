FROM node:18-alpine

# ----- Instalar dependencias mínimas -----
RUN apk add --no-cache \
    bash \
    curl \
    git \
    sqlite \
    tzdata

WORKDIR /data

# ----- Instalar n8n versión estable -----
RUN npm install -g n8n@0.229.0

# ----- Crear directorios y permisos -----
RUN mkdir -p /root/.n8n && \
    mkdir -p /data && \
    chmod -R 755 /root/.n8n /data

# Optimizar RAM
ENV NODE_OPTIONS="--max-old-space-size=256"

EXPOSE 5678

CMD ["n8n"]
