#!/bin/bash

# =====================================================
# Proyecto Bases de Datos - Telemetría DOOM
# Script de recreación completa de la BD
# =====================================================

set -e

DB_NAME="doom_telemetry"
DB_USER="postgres"

ROOT_DIR="$(cd "$(dirname "$0")" && pwd)"
SQL_DIR="$ROOT_DIR/sql"

echo "========================================"
echo " RECREACIÓN DE BASE DE DATOS DOOM"
echo "========================================"

echo ""
echo "Directorio detectado:"
echo "$ROOT_DIR"

# -----------------------------------------
# Verificación de PostgreSQL
# -----------------------------------------

command -v psql >/dev/null 2>&1 || {
    echo "ERROR: PostgreSQL (psql) no está instalado."
    exit 1
}

command -v createdb >/dev/null 2>&1 || {
    echo "ERROR: createdb no está disponible."
    exit 1
}

command -v dropdb >/dev/null 2>&1 || {
    echo "ERROR: dropdb no está disponible."
    exit 1
}

# -----------------------------------------
# Verificación de archivos
# -----------------------------------------

FILES=(
    "$SQL_DIR/esquema_er_grupo.sql"
    "$SQL_DIR/insert_datos_maestros.sql"
    "$SQL_DIR/insert_encuesta_pens.sql"
    "$SQL_DIR/proceso_etl.sql"
    "$SQL_DIR/views.sql"
    "$SQL_DIR/materialized_views.sql"
)

echo ""
echo "Verificando archivos..."

for f in "${FILES[@]}"
do
    if [ ! -f "$f" ]; then
        echo "ERROR: No existe:"
        echo "$f"
        exit 1
    fi
done

echo "Todos los archivos encontrados."

# -----------------------------------------
# Recreación de BD
# -----------------------------------------

echo ""
echo "Eliminando base anterior..."

dropdb -U "$DB_USER" --if-exists "$DB_NAME"

echo "Creando base nueva..."

createdb -U "$DB_USER" "$DB_NAME"

# -----------------------------------------
# Esquema
# -----------------------------------------

echo ""
echo "Ejecutando esquema..."

psql -U "$DB_USER" -d "$DB_NAME" \
-f "$SQL_DIR/esquema_er_grupo.sql"

# -----------------------------------------
# Datos maestros
# -----------------------------------------

echo ""
echo "Insertando datos maestros..."

psql -U "$DB_USER" -d "$DB_NAME" \
-f "$SQL_DIR/insert_datos_maestros.sql"

# -----------------------------------------
# Encuesta PENS
# -----------------------------------------

echo ""
echo "Insertando encuesta..."

psql -U "$DB_USER" -d "$DB_NAME" \
-f "$SQL_DIR/insert_encuesta_pens.sql"

# -----------------------------------------
# ETL
# -----------------------------------------

echo ""
echo "Ejecutando ETL..."

psql -U "$DB_USER" -d "$DB_NAME" \
-f "$SQL_DIR/proceso_etl.sql"

# -----------------------------------------
# Views
# -----------------------------------------

echo ""
echo "Creando vistas..."

psql -U "$DB_USER" -d "$DB_NAME" \
-f "$SQL_DIR/views.sql"

# -----------------------------------------
# Materialized Views
# -----------------------------------------

echo ""
echo "Creando materialized views..."

psql -U "$DB_USER" -d "$DB_NAME" \
-f "$SQL_DIR/materialized_views.sql"

# -----------------------------------------
# Final
# -----------------------------------------

echo ""
echo "========================================"
echo " PROCESO FINALIZADO CORRECTAMENTE"
echo "========================================"
echo ""
echo "Base de datos creada:"
echo "$DB_NAME"
echo ""
echo "Puede conectarse con:"
echo "psql -U $DB_USER -d $DB_NAME"
echo ""
