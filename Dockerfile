FROM node:20-alpine

RUN apk add --no-cache git

WORKDIR /app

# Clonar solo el repo principal sin submodules
RUN git clone https://github.com/Anil-matcha/Open-Generative-AI.git .

# Inicializar solo los submodules que funcionan (saltear Open-AI-Design-Agent que tiene commit roto)
RUN git submodule update --init packages/Vibe-Workflow || true
RUN git submodule update --init packages/Open-Poe-AI || true

# Instalar y buildear packages
RUN npm install
RUN npm run build:workflow || true
RUN npm run build:agent || true
RUN npm run build:studio

# Buildear Next.js
RUN npm run build

EXPOSE 3000
ENV NODE_ENV=production
ENV PORT=3000

CMD ["npm", "run", "start"]
