# Step 1: Use an official light-weight Node.js image as the foundation
FROM node:20-alpine

# Step 2: Set the folder inside the container where commands will run
WORKDIR /usr/src/app

# Step 3: Copy dependency files first (optimizes Docker build caching)
COPY package*.json ./

# Step 4: Install the Node modules inside the container
RUN npm install

# Step 5: Copy the rest of your app's code into the container
COPY . .

# Step 6: Document that this container listens on port 3000
EXPOSE 3000

# Step 7: Run nodemon dev script instead of npm start
CMD ["npm", "run", "dev"]