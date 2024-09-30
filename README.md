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
   ```
   docker build -t mygitlab .
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

Assurez-vous de mettre à jour les variables d'environnement suivantes dans le fichier `docker-compose.yml` avant le déploiement :

- `GITLAB_HOST` : Votre domaine GitLab
- `GITLAB_ROOT_PASSWORD` : Le mot de passe initial pour l'utilisateur root de GitLab
- `GITLAB_SECRETS_*` : Générez de nouvelles clés secrètes pour ces variables

## Accès à GitLab

Une fois déployé, vous pouvez accéder à GitLab à l'adresse `https://gitlab.xxxx.fr` (remplacez par votre domaine réel).

L'accès SSH est disponible sur le port 2222.

## Dépannage

Si vous rencontrez des problèmes, vérifiez les logs des services :

```
docker service logs -f gitlab_gitlab
docker service logs -f gitlab_postgresql
docker service logs -f gitlab_redis
```
