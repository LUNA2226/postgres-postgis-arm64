FROM postgis/postgis:15-3.4

RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    postgresql-server-dev-15 \
    ca-certificates \
    curl \
    && rm -rf /var/lib/apt/lists/*

RUN curl -L https://github.com/pgvector/pgvector/archive/refs/tags/v0.8.0.tar.gz -o pgvector.tar.gz && \
    tar -xzf pgvector.tar.gz && \
    cd pgvector-0.8.0 && make && make install && \
    cd .. && rm -rf pgvector.tar.gz pgvector-0.8.0

RUN apt-get remove -y build-essential postgresql-server-dev-15 curl && \
    apt-get autoremove -y && \
    apt-get clean

COPY init.sql /docker-entrypoint-initdb.d/
