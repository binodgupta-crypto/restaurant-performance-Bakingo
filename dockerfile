# -------------------------------------
# 1) Build frontend
# -------------------------------------
FROM node:18 AS frontend-build

WORKDIR /app
COPY ./frontend ./frontend

WORKDIR /app/frontend
RUN npm install
RUN npm run build

# -------------------------------------
# 2) Build backend (Express API + serving static frontend)
# -------------------------------------
FROM node:18 AS backend

WORKDIR /app

# Copy backend code
COPY ./backend ./backend

# Copy built frontend into backend public folder
COPY --from=frontend-build /app/frontend/dist ./backend/public

WORKDIR /app/backend

RUN npm install

EXPOSE 3000

CMD ["node", "server.js"]
