# Use the official Node.js image as the base image
FROM node:12.2.0-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

#Install the package
RUN npm install

# Expose the port the app runs on
EXPOSE 3000

# Run the Node.js application
CMD ["node", "hello.js"]
