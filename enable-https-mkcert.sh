#!/bin/bash
echo "🔐 Installation de mkcert pour support HTTPS local..."
sudo apt install libnss3-tools -y
curl -JLO https://dl.filippo.io/mkcert/latest?for=linux/amd64
chmod +x mkcert-v*-linux-amd64
sudo mv mkcert-v*-linux-amd64 /usr/local/bin/mkcert
mkcert -install
mkdir -p ~/.certs
cd ~/.certs
mkcert monprojet.local
echo "✅ Certificat et clé générés pour monprojet.local dans ~/.certs/"
