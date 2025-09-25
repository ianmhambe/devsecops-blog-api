FROM node:20-slim

WORKDIR /app
COPY app/package*.json ./
RUN npm install --production
COPY app/server.js ./

RUN useradd -m appuser
USER appuser

EXPOSE 3000
CMD ["node", "server.js"]
