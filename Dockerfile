FROM node:20-alpine

# Instalar git (necesario para submodules)
RUN apk add --no-cache git

WORKDIR /app

# Clonar el repo original con submodules
RUN git clone --recurse-submodules https://github.com/Anil-matcha/Open-Generative-AI.git .

# Instalar dependencias y buildear packages
RUN npm run setup

# Exponer puerto
EXPOSE 3000

ENV NODE_ENV=production
ENV PORT=3000

CMD ["npm", "run", "start"]
