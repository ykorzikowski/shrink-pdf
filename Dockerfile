FROM alpine:3.8

MAINTAINER Yannik Korzikowski <yannik@korzikowski.de>

ARG UID=1000

# data should be mounted with a directory container your PDF's
VOLUME ["/pdf"]

RUN apk --no-cache add \
  sed \
  pdftk \
  ghostscript \
  imagemagick \
  bash \
  ghostscript-fonts

RUN rm -rf /var/cache/apk/*

RUN adduser --uid $UID --disabled-password --home /app pdf

WORKDIR /app

ADD scripts/* /app/
ADD README.md /
env PATH /app:$PATH

RUN chown pdf:pdf /app
RUN chmod -R +x /app

USER pdf
CMD ["/app/entry"]
