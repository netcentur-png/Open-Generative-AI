FROM node:20-alpine

RUN apk add --no-cache git

WORKDIR /app

# Clonar solo el repo principal sin submodules
RUN git clone https://github.com/Anil-matcha/Open-Generative-AI.git .

# Clonar submodules directamente desde main (saltear referencias rotas)
RUN rm -rf packages/Vibe-Workflow && \
    git clone https://github.com/SamurAIGPT/Vibe-Workflow.git packages/Vibe-Workflow

RUN rm -rf packages/Open-Poe-AI && \
    git clone https://github.com/Anil-matcha/Open-Poe-AI.git packages/Open-Poe-AI

RUN rm -rf packages/Open-AI-Design-Agent && \
    git clone https://github.com/Anil-matcha/Open-AI-Design-Agent.git packages/Open-AI-Design-Agent

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
