# Utilise une image de base Node.js pour builder l'application
FROM node:16 as build-stage

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers de l'application
COPY . .

# Builder l'application Vue.js
RUN npm run build

# Étape 2 : Utilisation de Nginx pour servir l'application
FROM nginx:alpine as production-stage

# Copier le fichier de configuration Nginx personnalisé dans /etc/nginx/conf.d/
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Copier les fichiers générés par le build Vue.js dans le répertoire Nginx
COPY --from=build-stage /app/dist /usr/share/nginx/html

# Exposer le port 80 pour Nginx
EXPOSE 80

# Démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
