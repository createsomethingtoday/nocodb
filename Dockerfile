# Use Node.js LTS version
FROM node:18.19.0

# Create app directory
WORKDIR /usr/src/app

# Install pnpm
RUN npm install -g pnpm@8.11.0

# Copy package files
COPY package*.json ./
COPY pnpm-lock.yaml ./

# Install dependencies
RUN pnpm install

# Bundle app source
COPY . .

# Change to packages/nocodb directory and build
RUN cd packages/nocodb && pnpm build

# Expose port
EXPOSE 8080

# Set the working directory to the nocodb package
WORKDIR /usr/src/app/packages/nocodb

# Start command
CMD ["pnpm", "start"]
