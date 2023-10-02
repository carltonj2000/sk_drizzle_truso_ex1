FROM node:18-alpine as builder
RUN mkdir -p /app
WORKDIR /app
COPY package*.json .
RUN npm ci --omit dev
COPY . /app
RUN npm run build

FROM node:18-alpine
RUN mkdir -p /app
WORKDIR /app
COPY package*.json .
COPY --from=builder /app/build build/
COPY --from=builder /app/node_modules node_modules/
ENV NODE_ENV=production
CMD ["node", "build"]