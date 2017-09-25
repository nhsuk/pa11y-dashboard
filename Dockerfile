FROM node:4

ENV NODE_ENV=production \
    PORT=3333 \
    WEBSERVICE_CRON="0 30 0 * * *"

RUN mkdir -p /app && \
    cd /app && \
    curl https://codeload.github.com/pa11y/dashboard/tar.gz/2.2.2 | \
    tar -zxv --strip-components=1 && \
    true

WORKDIR /app

RUN npm install && \
    npm install -g phantomjs && \
    true

CMD node index.js
