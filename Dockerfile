FROM markusmcnugen/openconnect:latest

RUN apk add libseccomp lz4 lz4-dev \
	&& rm -rf /var/cache/apk/*

WORKDIR /config

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 4443
EXPOSE 4443/udp
CMD ["ocserv", "-c", "/config/ocserv.conf", "-f"]

