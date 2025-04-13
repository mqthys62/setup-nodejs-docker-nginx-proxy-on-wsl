#!/bin/bash

HOSTS_FILE="/mnt/c/Windows/System32/drivers/etc/hosts"
PROJECTS_ROOT="$HOME/projects"

add_proxy() {
  PROJECT_NAME=$1
  LOCAL_PORT=$2
  NGINX_CONF="/etc/nginx/sites-available/$PROJECT_NAME.local"
  NGINX_LINK="/etc/nginx/sites-enabled/$PROJECT_NAME.local"
  PROJECT_DIR="$PROJECTS_ROOT/$PROJECT_NAME"

  echo "📁 Vérification ou création du dossier projet : $PROJECT_DIR"
  mkdir -p "$PROJECT_DIR"

  echo "📝 Création de la configuration Nginx pour $PROJECT_NAME.local..."

  sudo tee $NGINX_CONF > /dev/null <<EOF
server {
    listen 80;
    server_name $PROJECT_NAME.local;

    location / {
        proxy_pass http://localhost:$LOCAL_PORT;
        proxy_set_header Host \$host;
        proxy_set_header X-Real-IP \$remote_addr;
        proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    }
}
EOF

  echo "🔗 Activation du proxy Nginx..."
  sudo ln -s $NGINX_CONF $NGINX_LINK 2>/dev/null || echo "🔁 Le lien existait déjà."

  echo "🔄 Reload de Nginx..."
  if sudo nginx -t && sudo systemctl reload nginx; then
    echo "✅ Nginx rechargé avec succès."
  else
    echo "❌ Erreur dans la config Nginx. Vérifie avec : sudo nginx -t"
    exit 1
  fi

  echo "🛠️ Ajout de l'entrée dans le fichier hosts Windows..."
  if grep -q "$PROJECT_NAME.local" "$HOSTS_FILE"; then
    echo "✅ $PROJECT_NAME.local est déjà présent dans le fichier hosts."
  else
    if echo "127.0.0.1 $PROJECT_NAME.local" | sudo tee -a "$HOSTS_FILE" > /dev/null; then
      echo "✅ Ajout réussi dans le fichier hosts Windows."
    else
      echo -e "\n❌ Impossible d'écrire dans le fichier hosts Windows (accès refusé)."
      echo -e "🔒 Windows protège ce fichier même depuis WSL."
      echo -e "\n📋 Copie manuellement cette ligne dans ton fichier hosts :\n"
      echo -e "########################################"
      echo -e "127.0.0.1   $PROJECT_NAME.local"
      echo -e "########################################\n"
      echo -e "📍 Emplacement : C:\\Windows\\System32\\drivers\\etc\\hosts"
      echo -e "🧠 Ouvre Notepad ou VS Code **en tant qu'administrateur**, colle la ligne à la fin, et sauvegarde."
    fi
  fi

  echo ""
  echo "🚀 Tu peux maintenant accéder à : http://$PROJECT_NAME.local"
  echo "📁 Ton projet est situé ici : $PROJECT_DIR"
}

remove_proxy() {
  PROJECT_NAME=$1
  NGINX_CONF="/etc/nginx/sites-available/$PROJECT_NAME.local"
  NGINX_LINK="/etc/nginx/sites-enabled/$PROJECT_NAME.local"

  echo "🧹 Suppression de la configuration Nginx pour $PROJECT_NAME.local..."

  sudo rm -f "$NGINX_LINK"
  sudo rm -f "$NGINX_CONF"

  echo "🔄 Reload de Nginx..."
  sudo nginx -t && sudo systemctl reload nginx

  echo "🧽 Nettoyage du fichier hosts..."
  sudo sed -i "/$PROJECT_NAME\.local/d" "$HOSTS_FILE"

  echo "🗑️ Proxy $PROJECT_NAME.local supprimé."
}

# === CLI handler ===
if [[ "$1" == "--remove" && -n "$2" ]]; then
  remove_proxy "$2"
elif [[ $# -eq 2 ]]; then
  add_proxy "$1" "$2"
else
  echo "❌ Utilisation :
  ➕ Ajouter un proxy : $0 <nom_du_projet> <port_local>
  ➖ Supprimer un proxy : $0 --remove <nom_du_projet>"
  exit 1
fi
