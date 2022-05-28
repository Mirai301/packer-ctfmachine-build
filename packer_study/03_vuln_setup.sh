#!/bin/bash

# initial shell: access the secret.txt
export PRIVATEKEY="!!!!! PRIVATE KEY !!!!!"

touch /var/www/html/secret.txt
cat << EOF | sudo tee /var/www/html/secret.txt
${PRIVATEKEY}
EOF