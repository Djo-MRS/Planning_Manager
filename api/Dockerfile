FROM elixir:1.14.5-alpine AS app

# Installer uniquement les dépendances nécessaires
RUN apk add --no-cache \
    build-base \
    bash \
    postgresql-client \
    openssl-dev

WORKDIR /app

# Copier les fichiers du projet
COPY . .

# Installer les dépendances Elixir et compiler le projet
RUN mix local.hex --force \
    && mix local.rebar --force \
    && mix deps.get \
    && mix compile
RUN apk add --no-cache inotify-tools


# Exposer le port de l'application
EXPOSE 4000

# Point d'entrée pour démarrer l'application
ENTRYPOINT ["sh", "/app/entrypoint.sh"]