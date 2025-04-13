# 🐧 Environnement de Développement Linux sous WSL + Nginx Proxy Local

Ce dépôt contient deux scripts utiles pour gérer un environnement de développement local sur **Ubuntu WSL**, avec une gestion facilitée des projets et des URLs locales personnalisées via **Nginx**.

---

## 🧰 Contenu

- `setup-dev-env.sh` : installe les outils de base pour le dev (Node.js, Git, Docker sans Docker Desktop, etc.)
- `add-local-proxy.sh` : crée/supprime une URL locale personnalisée (ex : `http://monprojet.local`) via Nginx
- `list-local-proxies.sh` : affiche tous les proxies locaux actifs
- `dev-manager.sh` : interface CLI interactive pour gérer les proxies
- `enable-https-mkcert.sh` : active le HTTPS local avec `mkcert`

---

## ⚙️ Prérequis

Avant de lancer les scripts, voici ce qu'il faut installer **manuellement** :

### 1. Installer WSL + Ubuntu

#### Option 1 : rapide (PowerShell administrateur)
```
wsl --install
```

#### Option 2 : manuelle
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

Redémarrer ensuite l’ordinateur, puis installer **Ubuntu** depuis le Microsoft Store.

---

### 2. Installer Nginx dans WSL (Ubuntu)
```
sudo apt update
sudo apt install nginx -y
```

Vérification :
```
sudo nginx -t
```

---

## 📦 Installation des scripts

1. Cloner le repository dans votre wsl.

2. Rendre les scripts exécutables :
```
chmod +x *.sh
```

3. Lancer le script d’environnement :
```
./setup-dev-env.sh
```

---

## 🔧 Utilisation de `add-local-proxy.sh`

### ➕ Ajouter un projet
```
add-local-proxy.sh monprojet 3000
```

### ➖ Supprimer un projet
```
add-local-proxy.sh --remove monprojet
```

---

## 📝 Ajout manuel dans le fichier hosts Windows

Si l'ajout automatique échoue :

1. Ouvrir un éditeur **en tant qu'administrateur**
2. Ouvrir ce fichier :
```
C:\Windows\System32\drivers\etc\hosts
```
3. Ajouter à la fin :
```
127.0.0.1 monprojet.local
```

---

## 📂 Organisation recommandée

```
~
├── scripts/
│   ├── setup-dev-env.sh
│   ├── add-local-proxy.sh
│   ├── list-local-proxies.sh
│   ├── dev-manager.sh
│   └── enable-https-mkcert.sh
├── projects/
│   ├── monprojet/
│   └── autreprojet/
```

Ajoutez au `.bashrc` :
```
export PATH="$HOME/scripts:$PATH"
```

Puis rechargez :
```
source ~/.bashrc
```

---

## ✅ Résultat attendu

- `http://monprojet.local` accessible depuis le navigateur
- Projets organisés dans `~/projects`
- Docker et Nginx opérationnels sans Docker Desktop

---

### ✅ Liste des proxies actifs
```
chmod +x ./list-local-proxies.sh
./list-local-proxies.sh
```

### ✅ Interface interactive
```
chmod +x dev-manager.sh
./dev-manager.sh
```

### ✅ Support HTTPS avec mkcert
```
chmod +x ./enable-https-mkcert.sh
./enable-https-mkcert.sh
```

---
Made with ❤️ by mqthys62
