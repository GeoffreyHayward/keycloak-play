# --- build stage ---
FROM node:20-alpine AS build
ARG APP_DIR=/usr/src/app
WORKDIR ${APP_DIR}
COPY package.json package-lock.json* ./
# Use lockfile when present, otherwise do a regular install
RUN if [ -f package-lock.json ]; then npm ci; else npm install; fi
COPY . .
ARG VITE_KEYCLOAK_URL
ARG VITE_KEYCLOAK_REALM
ARG VITE_KEYCLOAK_CLIENT_ID
ENV VITE_KEYCLOAK_URL=$VITE_KEYCLOAK_URL \
    VITE_KEYCLOAK_REALM=$VITE_KEYCLOAK_REALM \
    VITE_KEYCLOAK_CLIENT_ID=$VITE_KEYCLOAK_CLIENT_ID
RUN npm run build

# --- runtime stage ---
FROM nginx:1.27-alpine
ARG APP_DIR=/usr/src/app
COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY --from=build ${APP_DIR}/dist /usr/share/nginx/html
