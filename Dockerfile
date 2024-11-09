# Use Node.js LTS version
FROM node:18.19.0

# Create app directory
WORKDIR /usr/src/app

# Install pnpm
RUN npm install -g pnpm@8.11.0

# Copy package files
COPY package*.json ./
COPY pnpm-lock.yaml ./
COPY packages/nocodb/package*.json ./packages/nocodb/

# Install root dependencies
RUN pnpm install

# Bundle app source
COPY . .

# Install nocodb package dependencies
RUN cd packages/nocodb && pnpm install

# Install webpack globally
RUN npm install -g webpack webpack-cli

# Build nocodb
RUN cd packages/nocodb && EE=true pnpm run docker:build

# Expose port
EXPOSE 8080

# Set the working directory to the nocodb package
WORKDIR /usr/src/app/packages/nocodb

# Start command
CMD ["pnpm", "start"]
