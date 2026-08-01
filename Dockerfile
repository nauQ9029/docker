# ┌─────────────────────────────────────────┐
# │ STAGE 1: builder (node:20-alpine)       │
# │                                         │
# │  • npm install (dev + prod deps)        │
# │  • Full source code & build tools       │
# └────────────────────┬────────────────────┘
#                      │
#                      │ COPY --from=builder /usr/src/app/server.js
#                      ▼
# ┌─────────────────────────────────────────┐
# │ STAGE 2: production (node:20-alpine)   │
# │                                         │
# │  • npm ci --only=production             │
# │  • ONLY server.js copied over           │
# │  • Runs as non-root ('USER node')       │
# └─────────────────────────────────────────┘

# ==========================================
# STAGE 1: Build & Dependencies (Development / Build Environment)
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /usr/src/app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

# Start the application in development mode using nodemon
CMD ["npm", "run", "dev"]

# ==========================================
# STAGE 2: Production (Tiny, Secure Runtime)
# ==========================================
FROM node:20-alpine AS production

WORKDIR /usr/src/app

# Set production environment flag
ENV NODE_ENV=production

# Copy package files and install ONLY production dependencies
COPY package*.json ./
RUN npm ci --only=production

# Copy application code from builder stage
COPY --from=builder /usr/src/app/server.js ./server.js

# Use non-root user for security
USER node

EXPOSE 3000

# Start the application in production mode
CMD ["node", "server.js"]
