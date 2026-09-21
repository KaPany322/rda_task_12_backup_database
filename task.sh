#!/bin/bash

set -euo pipefail

if [[ -z "${DB_USER:-}" || -z "${DB_PASSWORD:-}" ]]; then
    echo "Error: DB_USER and DB_PASSWORD must be set"
    exit 1
fi

# Full backup: ShopDB -> ShopDBReserve
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" \
          ShopDB \
          --result-file=backup-db.sql

mysql -u "$DB_USER" -p"$DB_PASSWORD" \
      ShopDBReserve < backup-db.sql


# Data only: ShopDB -> ShopDBDevelopment
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" \
          ShopDB \
          --result-file=backup-no-create-db.sql \
          --skip-add-drop-table \
          --no-create-info \

mysql -u "$DB_USER" -p"$DB_PASSWORD" \
      ShopDBDevelopment < backup-no-create-db.sql