# ============================================================
# n8n - Render Production
# Imagen oficial fijada a una versión estable
# ============================================================

FROM docker.n8n.io/n8nio/n8n:2.36.7

# ------------------------------------------------------------
# Memoria
# Render Starter: limitar heap de Node para evitar OOM
# ------------------------------------------------------------
ENV NODE_OPTIONS="--max-old-space-size=320"

# ------------------------------------------------------------
# Persistencia
# El disco de Render debe estar montado en /home/node
# n8n guardará su información en /home/node/.n8n
# ------------------------------------------------------------
ENV N8N_USER_FOLDER=/home/node/.n8n

# Seguridad de permisos del archivo de configuración
ENV N8N_ENFORCE_SETTINGS_FILE_PERMISSIONS=true

# ------------------------------------------------------------
# Reducir servicios no esenciales
# ------------------------------------------------------------
ENV N8N_DIAGNOSTICS_ENABLED=false
ENV N8N_VERSION_NOTIFICATIONS_ENABLED=false
ENV N8N_HIRING_BANNER_ENABLED=false
ENV N8N_PERSONALIZATION_ENABLED=false

EXPOSE 5678
