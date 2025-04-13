#!/bin/bash
NGINX_SITES="/etc/nginx/sites-available"
echo "📄 Proxies locaux configurés :"
echo "-----------------------------"
if [ -d "$NGINX_SITES" ]; then
  ls $NGINX_SITES | grep ".local" | sed 's/\.local//g' | while read site; do
    echo "🌐 http://$site.local"
  done
else
  echo "❌ Le dossier $NGINX_SITES n'existe pas."
fi
