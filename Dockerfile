FROM node:22-slim
WORKDIR /app
COPY package*.json ./
RUN npm install --omit=dev
COPY . .
RUN node scripts/build-db.cjs
# Expose port 8787 
EXPOSE 8787
CMD ["node", "server/index.cjs"]