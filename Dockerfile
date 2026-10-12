FROM python:3.12-slim AS build
WORKDIR /docs
RUN pip install --no-cache-dir mkdocs-material
COPY . .
RUN mkdocs build -d /site

FROM nginx:alpine
COPY --from=build /site /usr/share/nginx/html
EXPOSE 80