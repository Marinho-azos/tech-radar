FROM node:24-alpine AS builder
WORKDIR /src/build-your-own-radar
RUN apk add --no-cache python3 make g++
COPY package.json package-lock.json ./
ENV CYPRESS_INSTALL_BINARY=0
RUN npm ci
COPY . ./
RUN npm run build:prod

FROM nginx:1.23.0
COPY --from=builder /src/build-your-own-radar/default.template /etc/nginx/conf.d/default.conf
COPY --from=builder /src/build-your-own-radar/dist /opt/build-your-own-radar
COPY --from=builder /src/build-your-own-radar/data /opt/build-your-own-radar/files
RUN rm -f /opt/build-your-own-radar/files/radar.csv /opt/build-your-own-radar/files/radar.json
