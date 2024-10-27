# TimeManager

## Description du Projet

**TimeManager** est une application de gestion du temps conçue pour optimiser et faciliter le suivi des tâches et des horaires de travail dans une organisation. Destinée aux administrateurs, managers, et employés, l'application permet de gérer les horaires de travail, de superviser les tâches, et d'obtenir une vue d'ensemble des activités de l'équipe.

Ce projet est structuré sous forme d'une application web, facilement déployable via Docker, pour permettre une installation rapide et simplifiée.

## Prérequis

Avant de commencer, assurez-vous que Docker et Docker Compose sont installés sur votre système. Si ce n'est pas le cas, suivez les instructions d'installation sur les sites officiels de [Docker](https://docs.docker.com/get-docker/) et de [Docker Compose](https://docs.docker.com/compose/install/).

## Lancement de l'Application

Suivez les étapes ci-dessous pour lancer l'application TimeManager :

1. **Arrêter les conteneurs en cours** : Si l'application est déjà en cours d'exécution, assurez-vous de tout arrêter pour éviter les conflits.

    ```bash
    docker compose down
    ```

2. **Démarrer l'application** : Utilisez la commande suivante pour lancer TimeManager. Cette commande va surveiller les changements en temps réel.

    ```bash
    docker compose up --watch
    ```

3. **Accéder à l'application** : Une fois le conteneur lancé, vous pouvez accéder à TimeManager via votre navigateur en visitant l'URL suivante :

    [http://localhost:8080](http://localhost:8080)

## Utilisateurs de Test

Pour tester l'application, trois comptes utilisateurs sont à votre disposition. Sur la page de connexion, vous pouvez utiliser l'un des comptes suivants :

| Rôle          | Adresse Email            | Mot de Passe      |
|---------------|--------------------------|-------------------|
| **Admin**     | admin@example.com        | adminpassword     |
| **Manager**   | manager@example.com      | managerpassword   |
| **Employé**   | employee@example.com     | employeepassword  |

Chaque rôle dispose d'un ensemble de fonctionnalités spécifiques, permettant de tester les différentes perspectives et fonctionnalités de TimeManager.

## Commandes Docker

| Commande                   | Description                                       |
|----------------------------|---------------------------------------------------|
| `docker compose down`      | Arrête et supprime tous les conteneurs actifs.    |
| `docker compose up --watch`| Lance l'application en surveillant les changements.|

---

**Note** : Assurez-vous de bien configurer les variables d'environnement et autres paramètres spécifiques si nécessaire pour garantir le bon fonctionnement de l'application en production.

---

Profitez de TimeManager et n'hésitez pas à contribuer ou à soumettre des retours pour améliorer le projet !
