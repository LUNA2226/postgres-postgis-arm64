# 1. ESTÁGIO DE CONSTRUÇÃO (A Cozinha)
FROM postgres:15 AS builder

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    postgresql-server-dev-15 \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# Compilamos o pgvector com flags genéricas para evitar o "Illegal Instruction"
RUN curl -L https://github.com/pgvector/pgvector/archive/refs/tags/v0.8.0.tar.gz -o pgvector.tar.gz && \
    tar -xzf pgvector.tar.gz && \
    cd pgvector-0.8.0 && \
    # O SEGREDO ESTÁ AQUI: OPTFLAGS="" garante compatibilidade total
    make OPTFLAGS="" && \
    make install

# 2. ESTÁGIO FINAL (Usando a base oficial PostGIS)
FROM postgis/postgis:15-3.4

# Copiamos os arquivos compilados para o lugar certo
COPY --from=builder /usr/lib/postgresql/15/lib/vector.so /usr/lib/postgresql/15/lib/
COPY --from=builder /usr/share/postgresql/15/extension/vector* /usr/share/postgresql/15/extension/

# Script de inicialização
COPY init.sql /docker-entrypoint-initdb.d/
