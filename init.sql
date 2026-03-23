-- Extensões para o Georadar (Mapas e Rotas)
CREATE EXTENSION IF NOT EXISTS postgis;
CREATE EXTENSION IF NOT EXISTS postgis_topology;
CREATE EXTENSION IF NOT EXISTS pgrouting;

-- Extensões para o Chatwoot (Busca e Identidade)
CREATE EXTENSION IF NOT EXISTS pg_trgm;
CREATE EXTENSION IF NOT EXISTS unaccent;
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";

-- Extensão para o Cérebro do Chatwoot (IA/Vetores)
CREATE EXTENSION IF NOT EXISTS vector;
