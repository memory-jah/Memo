FROM node:14

WORKDIR /app
COPY . /app

# Install dependencies
RUN npm install || (cp /root/.npm/_logs/*.log /app/npm-error.log && exit 1)

# Stage 2: Serve the application with Alpine
FROM node:14-alpine
WORKDIR /app
COPY --from=0 /app /app
CMD ["npm", "start"]
