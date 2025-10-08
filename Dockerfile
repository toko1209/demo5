# 1️⃣ Base image
FROM node:18-alpine AS build

# 2️⃣ Set working directory
WORKDIR /app

# 3️⃣ Copy package files và cài dependencies
COPY package*.json ./
RUN npm install

# 4️⃣ Copy toàn bộ source code
COPY . .

# 5️⃣ Build ứng dụng
RUN npm run build

# 6️⃣ Dùng web server để phục vụ build (Nginx)
FROM nginx:alpine
COPY --from=build /app/build /usr/share/nginx/html

# 7️⃣ Expose port
EXPOSE 80

# 8️⃣ Start Nginx
CMD ["nginx", "-g", "daemon off;"]
