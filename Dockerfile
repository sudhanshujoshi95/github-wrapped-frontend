# Use an official Ubuntu image as a base image
FROM ubuntu:20.04

# Set the working directory
WORKDIR /app

# Install dependencies and Flutter SDK
RUN apt-get update && apt-get install -y \
    curl \
    unzip \
    git \
    xz-utils \
    libglu1-mesa \
    && rm -rf /var/lib/apt/lists/*

# Download and install Flutter SDK
RUN curl -s https://storage.googleapis.com/download.flutter.io/flutter_linux_v2.10.5-stable.tar.xz | tar -xJ -C /usr/local

# Set up the Flutter environment
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Install Flutter dependencies and doctor
RUN flutter doctor

# Copy the Flutter project files into the container
COPY . .

# Install Flutter dependencies
RUN flutter pub get

# Build the Flutter web app
RUN flutter build web

# Install Nginx to serve the web app
RUN apt-get update && apt-get install -y nginx

# Copy the built web app to Nginx's public directory
RUN cp -r build/web/* /var/www/html/

# Expose port 80 to serve the app
EXPOSE 80

# Run Nginx to serve the app
CMD ["nginx", "-g", "daemon off;"]
