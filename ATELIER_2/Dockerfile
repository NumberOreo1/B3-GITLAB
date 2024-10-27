# Étape 1 : Construction de l'application avec Node.js
FROM node:16 AS build

# Définir le répertoire de travail dans le conteneur
WORKDIR /app

# Copier seulement les fichiers nécessaires pour installer les dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers sources de l'application
COPY . .

# Construire l'application
RUN npm run build

# Étape 2 : Préparation du conteneur NGINX pour servir l'application
FROM nginx:alpine

# Copier les fichiers construits de l'étape précédente vers NGINX
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]