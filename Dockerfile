FROM alpine:latest

RUN apk add --no-cache --update python3 py3-pip bash

# Créer un environnement virtuel
RUN python3 -m venv /venv

# Activer l'environnement virtuel et installer les dépendances
COPY ./webapp/requirements.txt /tmp/requirements.txt
RUN /venv/bin/pip install --no-cache-dir -r /tmp/requirements.txt

# Ajouter ton code après
COPY ./webapp /app
WORKDIR /app

# Utiliser le Python et pip de l’environnement virtuel
ENV PATH="/venv/bin:$PATH"

CMD ["python", "app.py"]
