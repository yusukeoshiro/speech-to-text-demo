FROM node:16 AS builder
WORKDIR /app
COPY package.json package-lock.json .npmrc ./
RUN npm run artifactregistry-login
RUN npm install
COPY ./ ./
RUN npm run build


FROM node:16-alpine
ENV NODE_ENV=production
WORKDIR /app
COPY package.json package-lock.json .npmrc ./
RUN npm run artifactregistry-login
RUN npm install --production
COPY ./ ./
COPY --from=builder /app/dist /app/dist
CMD ["npm", "run", "start"];
