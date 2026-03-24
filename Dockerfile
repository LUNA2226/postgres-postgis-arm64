# Base oficial do Postgres 15 (que tem suporte nativo a ARM64)
FROM postgres:15

# Instalamos o PostGIS e as dependências de sistema
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-15-postgis-3 \
    postgresql-15-postgis-3-scripts \
    postgis \
    && rm -rf /var/lib/apt/lists/*

# Copiamos o seu script de inicialização
COPY init.sql /docker-entrypoint-initdb.d/
