# ESTÁGIO 1: Builder
FROM postgres:15 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    postgresql-server-dev-15 \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/pgvector/pgvector/archive/refs/tags/v0.8.0.tar.gz -o pgvector.tar.gz && \
    tar -xzf pgvector.tar.gz && \
    cd pgvector-0.8.0 && make && make install


# ESTÁGIO 2: Final (com PostGIS já pronto)
FROM postgis/postgis:15-3.4

# Copia pgvector compilado
COPY --from=builder /usr/lib/postgresql/15/lib/vector.so /usr/lib/postgresql/15/lib/
COPY --from=builder /usr/share/postgresql/15/extension/vector* /usr/share/postgresql/15/extension/

# Script de inicialização
COPY init.sql /docker-entrypoint-initdb.d/
