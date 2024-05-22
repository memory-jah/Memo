FROM node AS builder 

WORKDIR /app

COPY . /app

RUN npm install

# Stage 2: Serve the application with Alpine
FROM alpine:3.14
RUN apk add --no-cache nodejs
COPY --from=builder /app ./

EXPOSE 80

CMD [ "node","server.js"]