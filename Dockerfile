# Pake Node.js versi 22 yang slim biar enteng
FROM node:22-slim

# Set working directory di dalem kontainer
WORKDIR /app

# Copy package.json dulu buat install dependencies (biar caching-nya kenceng)
COPY package*.json ./

# Install dependensi produksi aja biar gak kegedean
RUN npm install --omit=dev

# Copy semua file proyek lo (Server, Scripts, Data)
# Folder 'client' sebenernya gak perlu, tapi biarin aja dulu atau exclude lewat dockerignore
COPY . .

# Build database SQLite lo biar pas container nyala datanya udah ready
RUN node scripts/build-db.cjs

# Expose port 8787 (sesuai settingan Security Group & CloudFront lo)
EXPOSE 8787

# Jalankan servernya!
CMD ["node", "server/index.cjs"]