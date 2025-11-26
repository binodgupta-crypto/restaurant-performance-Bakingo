# ================================
# STEP 1 – Build Frontend (React)
# ================================
FROM node:18 AS frontend-build

WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN npm install

COPY frontend .
RUN npm run build

# ================================
# STEP 2 – Build Backend (Express/Node)
# ================================
FROM node:18 AS backend-build

WORKDIR /app/backend

COPY backend/package*.json ./
RUN npm install

COPY backend .

# Copy frontend build into backend public folder
COPY --from=frontend-build /app/frontend/dist ./public

# ================================
# STEP 3 – Final Production Image
# ================================
FROM node:18

WORKDIR /app

COPY --from=backend-build /app/backend ./

EXPOSE 8080

CMD ["node", "server.js"]
