FROM alpine:3.5

LABEL maintainer="Jiří Prokop <jprokop@synaptiko.cz>"

ENV HAAS_PROXY_VERSION 1.3

# RUN apk add --no-cache --virtual .build-deps \
# 	gcc \
# 	musl-dev \
# 	gmp-dev \
# 	libffi-dev \
# 	openssl-dev \
# 	ca-certificates \
# 	python2-dev \
# 	py2-pip

# RUN apk add --no-cache \
# 	python2 \
# 	py-twisted \
# 	sshpass

RUN apk add --no-cache \
	gcc \
	musl-dev \
	# gmp-dev \
	# libffi-dev \
	# openssl-dev \
	python3-dev \
	py3-pip \
	py3-cffi \
	py3-cryptography \
	ca-certificates \
	sshpass \
	openssh

RUN pip3 install --upgrade pip
RUN pip3 install haas-proxy==${HAAS_PROXY_VERSION}

# RUN apk del .build-deps

COPY run.sh /opt/cznic/haas/run.sh

VOLUME /var/log

EXPOSE 2222

CMD ["sh", "/opt/cznic/haas/run.sh"]

# TODO jprokop: make sure that deps are correct & remove those which are not needed for running
# TODO jprokop: here's the source: https://hub.docker.com/r/budry/docker-cz-nic-haas/
# Some inspiration from nginx Dockerfile: https://github.com/nginxinc/docker-nginx/blob/f8fad321cf58d5cbcafa3d9fa15314b8a77b5e65/mainline/alpine/Dockerfile
