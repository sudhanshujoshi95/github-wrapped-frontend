# Use the official Flutter image from Docker Hub
FROM cirrusci/flutter:stable

# Set working directory
WORKDIR /app

# Copy the Flutter project files into the container
COPY . .

# Install dependencies and build the Flutter web app
RUN flutter pub get
RUN flutter build web

# Optionally, install a web server (e.g., Nginx) to serve the app
RUN apt-get update && apt-get install -y nginx

# Copy the build output to Nginx's public directory
RUN cp -r build/web/* /var/www/html/

# Expose port 80 for serving the app
EXPOSE 80

# Run Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]
