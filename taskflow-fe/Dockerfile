# ================================
# Stage 1: Build Angular app
# ================================
FROM node:20-alpine AS build
WORKDIR /app
COPY package*.json ./
RUN npm ci
COPY . .
RUN npm run build --prod

# ================================
# Stage 2: NGINX for serving content
# ================================
FROM nginx:1.25-alpine

# Remove default nginx website
RUN rm -rf /usr/share/nginx/html/*

# Copy built Angular app from previous stage
COPY --from=build /app/dist/<YOUR_PROJECT_NAME> /usr/share/nginx/html

# Optionally copy custom nginx config
# COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port
EXPOSE 8080

# Start NGINX
CMD ["nginx", "-g", "daemon off;"]
