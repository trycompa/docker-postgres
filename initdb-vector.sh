#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'template_vector' template db
"${psql[@]}" <<- 'EOSQL'
CREATE DATABASE template_vector IS_TEMPLATE true;
EOSQL

# Load vector into both template_database and $POSTGRES_DB
for DB in template_postgis "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
		CREATE EXTENSION IF NOT EXISTS vector;
EOSQL
done