#!/bin/bash

# Espera o MySQL iniciar
while ! mysqladmin ping -h"localhost" --silent; do
    sleep 1
done

# Faz o backup inicial
mysqldump -uroot -p123 deliveryOnline > /backups/deliveryOnline_$(date +'%Y%m%d%H%M%S').sql

# Agendamento do backup para cada hora
while true; do
    sleep 3600
    mysqldump -uroot -p123 deliveryOnline > /backups/deliveryOnline_$(date +'%Y%m%d%H%M%S').sql
done
