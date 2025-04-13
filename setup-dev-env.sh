#!/bin/bash

echo "🔧 Initialisation de l'installation de l'environnement de dev pour Ubuntu WSL..."
sleep 1

error_exit() {
  echo "❌ ERREUR à l'étape: $1"
  exit 1
}

# 1. Mise à jour du système
echo "🔄 Mise à jour du système..."
sudo apt update && sudo apt upgrade -y || error_exit "Mise à jour du système"

# 2. Outils de base
echo "📦 Installation des outils de base..."
sudo apt install -y \
  curl \
  wget \
  git \
  unzip \
  zip \
  gnupg \
  ca-certificates \
  lsb-release \
  build-essential \
  apt-transport-https \
  software-properties-common \
  || error_exit "Installation des outils de base"

# 3. Git config via prompt
echo "🛠️ Configuration de Git..."
read -p "👉 Entrez votre nom Git (ex: John Doe): " git_name
read -p "👉 Entrez votre email Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

echo "✅ Git configuré avec $git_name <$git_email>"

# 4. Node.js (via NodeSource)
echo "📦 Installation de Node.js 20.x..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - || error_exit "Ajout du dépôt NodeSource"
sudo apt install -y nodejs || error_exit "Installation de Node.js"

# 5. Docker (sans Docker Desktop)
echo "🐳 Installation de Docker CE..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg || error_exit "Ajout de la clé Docker"

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || error_exit "Ajout du dépôt Docker"

sudo apt update || error_exit "Mise à jour après ajout Docker"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || error_exit "Installation des paquets Docker"

# Ajouter l'utilisateur actuel au groupe docker
sudo usermod -aG docker $USER
echo "ℹ️ Vous devrez peut-être redémarrer votre terminal pour utiliser Docker sans sudo."

# 6. Création du dossier projets
mkdir -p ~/projects && echo "📁 Dossier ~/projects créé"

# === OPTIONNEL ===
# Zsh + Oh My Zsh
# echo "💄 Installation de Zsh + Oh My Zsh..."
# sudo apt install -y zsh || error_exit "Installation de zsh"
# chsh -s $(which zsh)
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Nginx (si tu veux faire des proxys locaux)
# echo "🌐 Installation de Nginx..."
# sudo apt install -y nginx || error_exit "Installation de Nginx"

echo "✅ Installation terminée avec succès ! 🎉"
echo "🔁 Pense à redémarrer ton terminal ou faire un logout/login pour que Docker fonctionne sans sudo."
#!/bin/bash

echo "🔧 Initialisation de l'installation de l'environnement de dev pour Ubuntu WSL..."
sleep 1

error_exit() {
  echo "❌ ERREUR à l'étape: $1"
  exit 1
}

# 1. Mise à jour du système
echo "🔄 Mise à jour du système..."
sudo apt update && sudo apt upgrade -y || error_exit "Mise à jour du système"

# 2. Outils de base
echo "📦 Installation des outils de base..."
sudo apt install -y \
  curl \
  wget \
  git \
  unzip \
  zip \
  gnupg \
  ca-certificates \
  lsb-release \
  build-essential \
  apt-transport-https \
  software-properties-common \
  || error_exit "Installation des outils de base"

# 3. Git config via prompt
echo "🛠️ Configuration de Git..."
read -p "👉 Entrez votre nom Git (ex: Thery Mathys): " git_name
read -p "👉 Entrez votre email Git: " git_email

git config --global user.name "$git_name"
git config --global user.email "$git_email"

echo "✅ Git configuré avec $git_name <$git_email>"

# 4. Node.js (via NodeSource)
echo "📦 Installation de Node.js 20.x..."
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash - || error_exit "Ajout du dépôt NodeSource"
sudo apt install -y nodejs || error_exit "Installation de Node.js"

# 5. Docker (sans Docker Desktop)
echo "🐳 Installation de Docker CE..."
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg || error_exit "Ajout de la clé Docker"

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null || error_exit "Ajout du dépôt Docker"

sudo apt update || error_exit "Mise à jour après ajout Docker"
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin || error_exit "Installation des paquets Docker"

# Ajouter l'utilisateur actuel au groupe docker
sudo usermod -aG docker $USER
echo "ℹ️ Vous devrez peut-être redémarrer votre terminal pour utiliser Docker sans sudo."

# 6. Création du dossier projets
mkdir -p ~/projects && echo "📁 Dossier ~/projects créé"