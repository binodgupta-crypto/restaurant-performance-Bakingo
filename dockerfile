# ---- Backend ----
FROM node:18 AS backend
WORKDIR /app/backend
COPY backend/package.json backend/package-lock.json* ./
RUN npm install
COPY backend/ .
EXPOSE 4000

# ---- Frontend ----
FROM nginx:alpine AS frontend
COPY frontend/ /usr/share/nginx/html

# ---- Combined Runtime ----
FROM node:18
WORKDIR /app

# Copy backend
COPY --from=backend /app/backend ./backend

# Copy frontend static site
RUN mkdir -p ./frontend
COPY --from=frontend /usr/share/nginx/html ./frontend

# Install a simple static server for frontend
RUN npm install -g serve

# Startup script
CMD \
  (cd backend && node server.js &) && \
  serve -s frontend -l 8080
