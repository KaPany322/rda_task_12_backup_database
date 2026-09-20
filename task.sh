#!/bin/bash
mysql -u "$DB_USER" -p"$DB_PASSWORD" \
    -e "CREATE DATABASE ShopDBReserve; 
        CREATE DATABASE ShopDBDevelopment;"

mysql -u "$DB_USER" -p"$DB_PASSWORD" \
    -e "USE ShopDBReserve; 
        CREATE TABLE Products (ID INT AUTO_INCREMENT,Name VARCHAR(50),PRIMARY KEY (ID));
        USE ShopDBDevelopment; 
        CREATE TABLE Products (ID INT AUTO_INCREMENT,Name VARCHAR(50),PRIMARY KEY (ID));"
mysqldump -u "$DB_USER" -p"$DB_PASSWORD" \
    ShopDB \
    --result-file=backup.sql


mysql -u "$DB_USER" -p"$DB_PASSWORD" \
    ShopDBReserve < backup.sql


mysqldump -u "$DB_USER" -p"$DB_PASSWORD" \
    ShopDB \
    --result-file=backup-no-info-db.sql \
    --no-create-info

mysql -u "$DB_USER" -p"$DB_PASSWORD" \
    ShopDBDevelopment < backup-no-info-db.sql