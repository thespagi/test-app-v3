FROM node:alpine as dev 
WORKDIR /usr/src/app
COPY package*.json .
RUN npm ci
COPY . .
RUN npm run build

FROM node:alpine as production
WORKDIR /usr/src/app
COPY package*.json .
RUN npm ci --production
COPY --from=dev /usr/src/app/dist dist

CMD ["npm", "start"]