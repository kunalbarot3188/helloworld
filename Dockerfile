# Use the official Node.js image as the base image
FROM node:12.2.0-alpine

# Set the working directory in the container
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . .

# Run the Node.js application
CMD ["node", "hello.js"]
