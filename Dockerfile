FROM ruby:2-alpine

ARG PUSHER_VERSION="2.0.1"
ARG PUSHER_FAKE_VERSION="2.2.0"
ARG PUSHER_WEB_PORT=57003
ARG PUSHER_SOCKET_PORT=57004

ENV PUSHER_VERSION=$PUSHER_VERSION \
	PUSHER_FAKE_VERSION=$PUSHER_FAKE_VERSION \
	PUSHER_WEB_PORT=$PUSHER_WEB_PORT \
    PUSHER_SOCKET_PORT=$PUSHER_SOCKET_PORT

RUN apk --update-cache add --virtual build-dependencies build-base \
    && gem install pusher:$PUSHER_VERSION pusher-fake:$PUSHER_FAKE_VERSION \
    && apk del build-dependencies build-base

EXPOSE $PUSHER_SOCKET_PORT $PUSHER_WEB_PORT

CMD ["/bin/sh", "-c", "pusher-fake -v -i ${PUSHER_APP_ID} -k ${PUSHER_APP_KEY} -s ${PUSHER_APP_SECRET} --web-host 0.0.0.0 --web-port ${PUSHER_WEB_PORT} --socket-host 0.0.0.0 --socket-port ${PUSHER_SOCKET_PORT}"]