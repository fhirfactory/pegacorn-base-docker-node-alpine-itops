# The source files are in https://github.com/fhirfactory/pegacorn-buildingblocks-itops.git
FROM node:14.16.0-alpine3.13 as js-builder

WORKDIR /usr/src/app/

COPY package.json yarn.lock ./
COPY packages packages

RUN apk --no-cache add git
RUN yarn install --pure-lockfile --no-progress

COPY tsconfig.json .eslintrc .editorconfig .browserslistrc .prettierrc.js ./
COPY public public
COPY tools tools
COPY scripts scripts
COPY emails emails

ENV NODE_ENV production
RUN yarn build
