# Use Node.js LTS version
FROM node:18.19.0

# Create app directory
WORKDIR /usr/src/app

# Install specific pnpm version that matches the project
RUN npm install -g pnpm@7.33.6

# Install webpack globally
RUN npm install -g webpack webpack-cli

# Copy lock files first
COPY pnpm-lock.yaml package.json ./

# Copy the nocodb package files
COPY packages/nocodb/package.json ./packages/nocodb/

# Create required directories
RUN mkdir -p packages/nocodb/dist

# Install dependencies at root level - allow lockfile updates
RUN pnpm install --no-frozen-lockfile

# Copy source files
COPY . .

# Build nocodb
RUN cd packages/nocodb && \
    NODE_ENV=production EE=true pnpm install --no-frozen-lockfile && \
    NODE_ENV=production EE=true pnpm run docker:build

# Expose port
EXPOSE 8080

# Set the working directory to the nocodb package
WORKDIR /usr/src/app/packages/nocodb

# Environment variables
ENV NODE_ENV=production
ENV PORT=8080

# Start command
CMD ["pnpm", "start"]
