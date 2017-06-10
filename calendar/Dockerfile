FROM alpine:latest

ENV VERSION 2.0.0

RUN apk add --no-cache \
      python3 \
      python3-dev \
      build-base \
      libffi-dev \
      ca-certificates \
      openssl && \
    python3 -m pip install passlib bcrypt && \
    apk del \
      python3-dev \
      build-base \
      libffi-dev

ADD https://github.com/Kozea/Radicale/archive/${VERSION}.tar.gz radicale.tar.gz
RUN tar xzf radicale.tar.gz && \
    python3 -m pip install ./Radicale-${VERSION} && \
    rm -r radicale.tar.gz Radicale-${VERSION}

VOLUME /var/lib/radicale
VOLUME /etc/radicale

EXPOSE 5232

CMD ["radicale", "--config", "/etc/radicale/config", "--hosts", "0.0.0.0:5232"]
