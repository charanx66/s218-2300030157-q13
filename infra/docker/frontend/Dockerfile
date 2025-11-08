## Multi-stage Dockerfile for React (Vite) frontend
FROM node:18-alpine AS build
WORKDIR /app

# Copy package files and install
COPY frontend/package*.json ./
RUN npm ci --silent

# Copy source and build
COPY frontend/ .
RUN npm run build

FROM nginx:stable-alpine AS runtime
COPY --from=build /app/dist /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
