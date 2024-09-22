# Utiliser l'image officielle Dart comme image de base
FROM dart:stable AS build

# Définir le répertoire de travail
WORKDIR /app

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \
    git \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Télécharger et extraire Flutter SDK
RUN curl -LO https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/flutter_linux_3.22.2-stable.tar.xz \
    && tar xf flutter_linux_3.22.2-stable.tar.xz \
    && rm flutter_linux_3.22.2-stable.tar.xz

# Ajouter Flutter au PATH
ENV PATH="/app/flutter/bin:${PATH}"

# Configurer Git pour le répertoire Flutter
RUN git config --global --add safe.directory /app/flutter

# Exécuter Flutter doctor pour s'assurer que tout est en place
RUN flutter doctor

# Créer un utilisateur non-root
RUN useradd -ms /bin/sh flutteruser

# Changer le propriétaire des fichiers de l'application
RUN chown -R flutteruser /app

# Passer à l'utilisateur non-root
USER flutteruser

# Copier les fichiers de configuration du projet
COPY --chown=flutteruser pubspec.yaml pubspec.yaml
COPY --chown=flutteruser pubspec.lock pubspec.lock

# Installer les dépendances Flutter
RUN flutter pub get
RUN flutter pub upgrade

# Copier le reste des fichiers du projet
COPY --chown=flutteruser . .

# Exécuter build_runner pour générer le code
RUN flutter pub run build_runner build --delete-conflicting-outputs || true

# Nettoyer les anciennes constructions
RUN flutter clean

# Construire l'application Flutter pour le web avec verbose logging
RUN flutter build web --verbose

# Étape finale : utiliser une image de serveur web léger
FROM nginx:alpine

# Copier les fichiers construits dans l'image Nginx
COPY --from=build /app/build/web /usr/share/nginx/html

# Exposer le port de l'application
EXPOSE 80

# Commande pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]
