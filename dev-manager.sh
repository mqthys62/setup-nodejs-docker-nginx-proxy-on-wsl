#!/bin/bash
while true; do
  clear
  echo "=========================="
  echo "🛠 Dev Manager Menu"
  echo "=========================="
  echo "1. Créer un proxy local"
  echo "2. Supprimer un proxy local"
  echo "3. Lister les proxies actifs"
  echo "4. Quitter"
  echo -n "> Choix : "
  read choix
  case $choix in
    1)
      read -p "Nom du projet : " name
      read -p "Port local : " port
      add-local-proxy.sh "$name" "$port"
      read -p "Appuie sur Entrée pour continuer..."
      ;;
    2)
      read -p "Nom du projet à supprimer : " name
      add-local-proxy.sh --remove "$name"
      read -p "Appuie sur Entrée pour continuer..."
      ;;
    3)
      list-local-proxies.sh
      read -p "Appuie sur Entrée pour continuer..."
      ;;
    4)
      echo "👋 À bientôt !"
      exit 0
      ;;
    *)
      echo "❌ Choix invalide"
      sleep 1
      ;;
  esac
done
