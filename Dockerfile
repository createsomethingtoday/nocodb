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

# Build the application
RUN pnpm build

# Expose port
EXPOSE 8080

# Start command
CMD [ "pnpm", "start" ]
