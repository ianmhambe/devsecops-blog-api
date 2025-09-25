FROM node:20-slim
WORKDIR /app
# Update npm to a version with cross-spawn >= 7.0.5
RUN npm install -g npm@10.8.3
COPY app/package*.json ./
RUN npm install --production
COPY app/server.js ./
RUN useradd -m appuser
USER appuser
EXPOSE 3000
CMD ["node", "server.js"]
