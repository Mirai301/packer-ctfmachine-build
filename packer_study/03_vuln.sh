#!/bin/bash

# initial shell: access the secret.txt
export PRIVATEKEY="!!!!! PRIVATE KEY !!!!!"

mkdir /var/www/html/secret

touch /var/www/html/secret/secret.txt
cat << EOF | sudo tee /var/www/html/secret/secret.txt
${PRIVATEKEY}
EOF

touch /var/www/html/secret/robots.txt
cat << EOF | sudo tee /var/www/html/secret/robots.txt
/oscp
/proof.txt
EOF