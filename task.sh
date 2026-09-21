#!/bin/bash

# Full backup: ShopDB -> ShopDBReserve
mysqldump -u $DB_USER -p$DB_PASSWORD \
          ShopDB \
          --result-file=backup-db.sql

mysql -u $DB_USER -p$DB_PASSWORD \
            ShopDBReserve < backup-db.sql

# Data only: ShopDB -> ShopDBDevelopment
mysqldump -u $DB_USER -p$DB_PASSWORD \
          ShopDB \
          --result-file=backup-no-create-db.sql \
          --skip-add-drop-table --no-create-info

mysql -u $DB_USER -p$DB_PASSWORD \
            ShopDBDevelopment < backup-no-create-db.sql