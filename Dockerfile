# Build Environment

FROM node:latest as build

WORKDIR /app

COPY package.json ./
COPY package-lock.json ./

RUN npm ci
RUN npm install react-scripts@5.0.0 -g

COPY ./ ./
RUN npm run build


# Production Environment
FROM nginx:stable-alpine as prod
COPY --from=build /app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]