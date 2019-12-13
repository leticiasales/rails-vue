FROM node:latest

ENV APP /usr/src/app
RUN mkdir $APP
WORKDIR $APP

RUN curl --compressed -o- -L https://yarnpkg.com/install.sh | bash

COPY package.json yarn.lock $APP/
RUN yarn

COPY . $APP/

CMD ["yarn", "serve"]