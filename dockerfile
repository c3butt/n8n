FROM node:20-alpine

# ----- Dependencias mínimas -----
RUN apk add --no-cache \
    bash \
    curl \
    git \
    sqlite \
    tzdata

WORKDIR /home/node

# ----- Instalar última versión de n8n -----
RUN npm install -g n8n@latest --omit=dev --prefer-offline

# ----- Optimización extrema de RAM -----
ENV NODE_OPTIONS="\
 --max-old-space-size=320 \
 --optimize_for_size \
 --gc_interval=100 \
 --max-semi-space-size=4 \
 --stack_size=512 \
"

# ----- Forzar disco de Render -----
ENV N8N_USER_FOLDER=/home/node/.n8n
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# ----- DESACTIVAR módulos que consumen demasiada RAM -----
ENV N8N_AI_ASSISTANT_ENABLED=false
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
ENV N8N_HIRING_BANNER_ENABLED=false
ENV N8N_PERSONALIZATION_ENABLED=false

# Desactivar LangChain (consume muchísimo)
ENV N8N_EXCLUDE_MODULES="n8n-nodes-langchain"

# ----- Crear carpeta -----
RUN mkdir -p /home/node/.n8n && \
    chown -R node:node /home/node

USER node

EXPOSE 5678

CMD ["n8n"]
