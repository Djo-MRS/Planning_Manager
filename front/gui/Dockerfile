# Use the official Node.js image for building the frontend
FROM node:18-alpine AS build

# Set the working directory
WORKDIR /app

# Copy the package.json and install dependencies
COPY package*.json ./
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the Vue.js application for production
RUN npm run build

# Use a minimal image to serve the frontend files
FROM nginx:alpine

# Copy built files to the nginx web directory
COPY --from=build /app/dist /usr/share/nginx/html

# Expose port 80 for serving the frontend
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]