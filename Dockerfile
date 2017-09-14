FROM node:4

ENV NODE_ENV=production \
    PORT=80 \
    WEBSERVICE_CRON="0 30 0 * * *"

CMD READONLY=true node index.js

RUN mkdir -p /app && \
    cd /app && \
    curl https://codeload.github.com/pa11y/dashboard/tar.gz/2.2.2 | \
    tar -zxv --strip-components=1 && \
    true

WORKDIR /app

RUN npm install && \
    npm install -g phantomjs && \
    true
