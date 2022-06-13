#!/bin/bash

# initial shell: access the secret.txt
KEY="!!!!! PRIVATE KEY !!!!!"
KEY=`echo $KEY | base64`
export PRIVATEKEY=$KEY

mkdir /var/www/html/secret
chmod 777 /var/www/html/secret

touch /var/www/html/secret/secret.txt
cat << EOF | sudo tee /var/www/html/secret/secret.txt
${PRIVATEKEY}
EOF

touch /var/www/html/secret/robots.txt
cat << EOF | sudo tee /var/www/html/secret/robots.txt
/oscp
/proof.txt
EOF