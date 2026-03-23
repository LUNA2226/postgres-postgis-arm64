# Mantivemos a base que você escolheu (Postgres 15)
FROM postgres:15

# 1. Instalamos o PostGIS e as ferramentas de compilação para o pgvector
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-15-postgis-3 \
    postgis \
    build-essential \
    git \
    postgresql-server-dev-15 \
    && rm -rf /var/lib/apt/lists/*

# 2. Compilamos o pgvector (Obrigatório para o Chatwoot AI)
RUN cd /tmp && \
    git clone --branch v0.6.0 https://github.com/pgvector/pgvector.git && \
    cd pgvector && \
    make && \
    make install

# 3. Limpeza (Para a imagem não ficar gigante no seu servidor ARM)
RUN apt-get remove -y build-essential git postgresql-server-dev-15 && \
    apt-get autoremove -y && \
    rm -rf /tmp/pgvector

# 4. Sua linha original para rodar o SQL de extensões
COPY init.sql /docker-entrypoint-initdb.d/
