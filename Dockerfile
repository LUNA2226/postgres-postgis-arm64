# 1. Definimos a base (Postgres 15)
FROM postgres:15

# 2. Instalamos o PostGIS e as ferramentas para compilar o pgvector
RUN apt-get update && apt-get install -y --no-install-recommends \
    postgresql-15-postgis-3 \
    postgis \
    build-essential \
    postgresql-server-dev-15 \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 3. Baixamos e instalamos o pgvector (essencial para o Chatwoot AI)
# Usamos curl + tar porque o git clone estava falhando no seu ambiente
RUN curl -L https://github.com/pgvector/pgvector/archive/refs/tags/v0.8.0.tar.gz -o pgvector.tar.gz && \
    tar -xzf pgvector.tar.gz && \
    cd pgvector-0.8.0 && \
    make && \
    make install && \
    cd .. && rm -rf pgvector.tar.gz pgvector-0.8.0

# 4. Limpeza para a imagem não ocupar muito espaço no seu servidor ARM
RUN apt-get remove -y build-essential curl postgresql-server-dev-15 && \
    apt-get autoremove -y

# 5. Copia o seu script SQL para criar as extensões automaticamente
COPY init.sql /docker-entrypoint-initdb.d/
