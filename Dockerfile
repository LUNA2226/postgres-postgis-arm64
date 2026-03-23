FROM postgres:15

# Instalar PostGIS
RUN apt-get update && \
    apt-get install -y postgis postgresql-15-postgis-3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Ativar extensão automaticamente
COPY init.sql /docker-entrypoint-initdb.d/
