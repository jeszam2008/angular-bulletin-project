# Stage 1: Compile and Build angular codebase
FROM node:20.14.0-bookworm AS build 

# Create a directory
RUN mkdir /usr/local/app

# Set a work directory
WORKDIR /usr/local/app

# Copy package.json to directory
COPY package*.json ./ 

# Install all the dependencies
RUN npm install

# Add the source code to app
COPY . .  

# Copy the bash file
COPY build.sh .  

# Generate the build of the application
RUN chmod +x /usr/local/app/build.sh
RUN /usr/local/app/build.sh

# Stage 2: Serve app with nginx server
FROM nginx:latest

# Install vim
RUN apt-get update && apt-get install -y vim

# Remove existing nginx folders / files
RUN rm -rf /usr/share/nginx/html/*

# Copy the build output to replace the default nginx contents.
COPY --from=build /usr/local/app/dist/angular-bulletin-project/browser/* /usr/share/nginx/html/

# Copy the custom Nginx configuration file
COPY nginx/nginx.conf /etc/nginx/conf.d/default.conf

RUN service nginx restart

# Expose port 4200
EXPOSE 4200