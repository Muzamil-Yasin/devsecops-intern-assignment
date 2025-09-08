# Step 1: Use Node.js image from aws ecr public repo
FROM public.ecr.aws/docker/library/node:18


# Step 2: Set working directory inside the container
WORKDIR /app

# Step 3: Copy package.json and install dependencies
COPY package*.json ./
RUN npm install

# Step 4: Copy rest of the project files
COPY . .

# Step 5: Expose the port your app runs on
EXPOSE 3000

# Step 6: Command to run the app
CMD ["npm", "start"]
