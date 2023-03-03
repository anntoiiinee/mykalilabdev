# Official base image
FROM docker.io/kalilinux/kali-rolling:latest AS base

RUN apt update\
	&& apt-get install -y --no-install-recommends apt-utils \
	&& apt-get install -y --no-install-recommends vim \
	&& apt-get autoremove -y \
	&& apt-get autoclean -y \
	&& rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/bin/bash"]