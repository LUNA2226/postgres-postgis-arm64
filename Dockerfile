# Base oficial do Postgres 15 (Suporte nativo a ARM64)
FROM postgres:15

# Instalamos apenas o essencial para o Georadar
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-15-postgis-3 \
    postgis \
    && rm -rf /var/lib/apt/lists/*

# Copiamos o seu script de inicialização
COPY init.sql /docker-entrypoint-initdb.d/
