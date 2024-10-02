# B3-GITLAB

# Configuration GitLab avec Docker Swarm

Ce dépôt contient les fichiers nécessaires pour construire une image GitLab personnalisée et la déployer en utilisant Docker Swarm.

## Prérequis


1. Initialiser docker swarm:
   ```
   docker swarm init
   ```

## Construction de l'image GitLab

1. Clonez ce dépôt :
   ```
   git clone https://github.com/votre-nom-utilisateur/gitlab-docker-swarm.git](https://github.com/NumberOreo1/B3-GITLAB.git
   ```

2. Construisez l'image Docker :

   Remplacer le registry_host,external_url,registry_external_url par votre hostname dans le Dockerfile
   
   ```
   docker build -t img_gitlab .
   ```

   Cette commande va construire l'img gitlab en utilisant le Dockerfile

## Déploiement sur Docker Swarm

1. Déployez la stack en utilisant le fichier `docker-compose.yml` :
   ```
   docker stack deploy -c docker-compose.yml gitlab
   ```

   Cette commande va créer et démarrer les services définis dans le fichier `docker-compose.yml`.

## Configuration

Le fichier `docker-compose.yml` contient la configuration pour le service GitLab, incluant :

- Base de données PostgreSQL
- Redis
- Application GitLab

Mettre à jour les variables d'environnement dans le fichier `docker-compose.yml` avant le déploiement :

- `GITLAB_HOST` : Votre url GitLab
- `GITLAB_ROOT_PASSWORD` : MDP avec des chiffres, lettres et symboles 

## Accès à GitLab

Une fois déployé, vous pouvez accéder à GitLab à l'adresse `http://localhost/`.

L'accès SSH est disponible sur le port 2222.

## Dépannage

Si vous rencontrez des problèmes, vérifiez les logs des services :

```
docker stack ps gitlab

docker service logs -f gitlab_gitlab
docker service logs -f gitlab_postgresql
docker service logs -f gitlab_redis
```
