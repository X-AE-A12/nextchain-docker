FROM debian:stretch-slim

RUN groupadd -r next && useradd -r -m -g next next

RUN set -ex \
	&& apt-get update \
	&& apt-get install -qq --no-install-recommends ca-certificates dirmngr gosu gpg unzip zip wget \
	&& rm -rf /var/lib/apt/lists/*

ENV NEXT_VERSION 3.5.0
ENV NEXT_URL https://github.com/NextExchange/next-wallet-desktop-app/releases/download/3.5.0/nextcoind-3.5.0-linux.zip

#-----------------------
# install next binaries
#-----------------------

RUN set -ex \
	&& cd /tmp \
	&& wget "$NEXT_URL" -O temp.zip \
	&& unzip temp.zip -d /tmp \
	&& cp -a /tmp/linux_bin/. /usr/local/bin \
	&& rm -rf /tmp/*

# create data directory
ENV NEXT_DATA /data
RUN mkdir "$NEXT_DATA" \
	&& chown -R next:next "$NEXT_DATA" \
	&& ln -sfn "$NEXT_DATA" /home/next/.next \
	&& chown -h next:next /home/next/.next
VOLUME /data

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod 777 /usr/local/bin/docker-entrypoint.sh \
    && ln -s /usr/local/bin/docker-entrypoint.sh /

ENTRYPOINT ["/docker-entrypoint.sh"]

EXPOSE 7077 7078 17077 17078
CMD ["nextd"]
