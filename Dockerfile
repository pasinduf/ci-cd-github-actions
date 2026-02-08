
# =======================
# Build stage
# =======================

FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files
COPY package*.json ./

#Install dependencies
RUN npm ci

# Copy source code
COPY . .

# Build the app
RUN npm run build


# ==================
# Runtime stage
# ==================

From node:18-alpine As runner

WORKDIR /app
ENV NODE_ENV=production

# Copy only needed from build stage
COPY package*.json ./
RUN npm ci --omit=dev

COPY --from=builder /app/dist ./dist

# Expose port 8000
EXPOSE 8000

# Start the app
CMD ["node", "dist/main.js"]