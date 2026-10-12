FROM python:3.12-slim AS build
WORKDIR /docs
RUN pip install --no-cache-dir mkdocs-material
COPY . .
# "pages:" est l'ancienne clé de MkDocs, "nav:" est la clé actuelle
RUN sed -i 's/^pages:/nav:/' mkdocs.yml && mkdocs build -d /site

FROM nginx:alpine
COPY --from=build /site /usr/share/nginx/html
EXPOSE 80