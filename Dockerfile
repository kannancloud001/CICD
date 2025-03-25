# Step 1: Use the official Nginx base image
FROM nginx:latest

# Step 2: Copy the frontend files to the Nginx default directory
COPY index.html /usr/share/nginx/html/index.html

# Step 3: Copy the custom Nginx configuration
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 for the container
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
