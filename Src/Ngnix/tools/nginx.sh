#!/bin/bash

key=$(cat $KEY_PATH)

crt=$(cat $CRT_PATH)


openssl req -newkey rsa:2048 -nodes -keyout $key -x509 -days 365 \
-out $crt -subj "/C=TR/ST=KOCAELI/L=GEBZE/O=42Kocaeli/CN=albozkur.42.fr";

exec "$@"
