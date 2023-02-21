# Specify the Dart SDK base image version using dart:<version> (ex: dart:2.12)
FROM dart:stable AS build

RUN apt-get install unzip

# Create a new user with user id 1000 and add it to the "dart" group
RUN useradd -u 1000 -ms /bin/bash tappuser && \
    # Create a new group
    groupadd dart && \
    usermod -aG dart tappuser
    
 # Set the working directory and set appropriate permissions
RUN mkdir /app && chown -R tappuser:dart /app
WORKDIR /appd
USER tappuser


# Install Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1
ENV PATH "$PATH:/app/flutter/bin"

# Copy the pubspec.yaml and lock file to the container
COPY pubspec.* ./

# Install dependencies
RUN flutter pub get

# Copy the remaining project files to the container
COPY . .

# Build the Flutter app
RUN flutter build web

# Expose the default Flutter port
EXPOSE 8080

# Start the app
CMD [ "flutter", "run", "-d", "web-server", "--web-port", "8080"]
