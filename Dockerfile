FROM node:20-alpine
WORKDIR /app
# Update npm to a version with cross-spawn >= 7.0.5
RUN npm install -g npm@11.6.1
COPY app/package*.json ./
RUN npm install --production
COPY app/server.js ./
EXPOSE 3000
CMD ["node", "server.js"]
